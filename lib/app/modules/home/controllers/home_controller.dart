import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeController extends GetxController {
  final auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<DocumentSnapshot<Map<String, dynamic>>> getdatauser() async* {
    String uid = auth.currentUser!.uid;
    yield* firestore.collection("mahasiswa").doc(uid).snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> list5() async* {
    String uid = auth.currentUser!.uid;
    yield* firestore
        .collection("mahasiswa")
        .doc(uid)
        .collection("absen")
        .orderBy(
          'waktu',
        )
        .limitToLast(4)
        .snapshots();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> Sekarang() async* {
    String uid = auth.currentUser!.uid;
    var uidwaktu = DateFormat.yMd().format(DateTime.now()).replaceAll("/", '-');
    yield* firestore
        .collection("mahasiswa")
        .doc(uid)
        .collection("absen")
        .doc(uidwaktu)
        .snapshots();
  }
}
