import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class UpdetprofilController extends GetxController {
  TextEditingController Emailc = TextEditingController();
  TextEditingController NIMc = TextEditingController();
  TextEditingController Namac = TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<void> updt(uid) async {
    if (Emailc.text.isNotEmpty &&
        NIMc.text.isNotEmpty &&
        Namac.text.isNotEmpty) {
      try {
        await firestore
            .collection('mahasiswa')
            .doc(uid)
            .update({"Nama": Namac.text});
        Get.back();
        Get.snackbar("Berhasil", "Berhasil mengupdet data");
      } catch (e) {
        Get.snackbar("Gagal", "Gagal mengupdet data");
      }
    }
  }
}
