import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AllabsenController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  DateTime? start;
  DateTime end = DateTime.now();

  Future<QuerySnapshot<Map<String, dynamic>>> alllist() async {
    String uid = auth.currentUser!.uid;
    print(start);
    if (start == null) {
      return firestore
          .collection("mahasiswa")
          .doc(uid)
          .collection("absen")
          // .where("waktu", isGreaterThan: start?.toIso8601String())
          .where("waktu", isLessThan: end.toIso8601String())
          .orderBy('waktu', descending: true)
          .get();
    } else {
      return firestore
          .collection("mahasiswa")
          .doc(uid)
          .collection("absen")
          .where("waktu", isGreaterThan: start?.toIso8601String())
          .where("waktu",
              isLessThan: end.add(Duration(days: 1)).toIso8601String())
          .orderBy('waktu', descending: true)
          .get();
    }
  }

  void filter(pickstrat, pickend) async {
    start = pickstrat;
    end = pickend;
    update();
    Get.back();
  }
}
