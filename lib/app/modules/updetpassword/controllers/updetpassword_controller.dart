import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdetpasswordController extends GetxController {
  TextEditingController password = TextEditingController();
  TextEditingController new_password = TextEditingController();
  TextEditingController confpassword = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

  void ubhpw() async {
    if (new_password.text == confpassword.text &&
        password.text != confpassword.text) {
      try {
        if (password.text.isNotEmpty &&
            new_password.text.isNotEmpty &&
            confpassword.text.isNotEmpty) {
          String emaill = auth.currentUser!.email!;
          await auth.signInWithEmailAndPassword(
              email: auth.currentUser!.email!.toString(),
              password: password.text);
          await auth.currentUser!.updatePassword(confpassword.text);
          await auth.signOut();
          await auth.signInWithEmailAndPassword(
              email: emaill.toString(), password: confpassword.text);
          Get.back();
          Get.snackbar("Berhasil", "Berhasil megubah Password");
        }
      } catch (e) {
        Get.snackbar("Gagal", "password salah");
      }
    } else {
      Get.snackbar("Gagal",
          "Konfirmasi password salah dan tidak boleh sama dengan password lama");
    }
  }
}
