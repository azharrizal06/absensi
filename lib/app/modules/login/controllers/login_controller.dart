import 'package:absensi/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController ubh = TextEditingController(text: '123123123');
  void riset(Remail) async {
    await auth.sendPasswordResetEmail(email: Remail);
    Get.back();
  }

  void newpw(ubh) async {
    try {
      if (ubh == 'STMIKIKMI') {
        Get.defaultDialog(
            title: 'Gagal', middleText: "Password tidak boleh sama");
      } else {
        String Emailc = auth.currentUser!.email!;
        await auth.currentUser!.updatePassword(ubh);
        await auth.signInWithEmailAndPassword(email: Emailc, password: ubh);
        Get.snackbar('Berhasil', 'Password telah di ubh');
        Get.toNamed(Routes.HOME);
      }
    } catch (e) {
      Get.snackbar(
          'Gagal', 'Tidak dapat mengubah password silakan hubungi admin');
    }
  }

  void login(String Emailc, password) async {
    try {
      final UserCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: Emailc, password: password);
      print(UserCredential.user);
      if (UserCredential.user != null) {
        if (UserCredential.user!.emailVerified == true) {
          if (password == 'STMIKIKMI') {
            return Get.dialog(Dialog(
              child: Container(
                height: 200,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextField(
                        autocorrect: false,
                        controller: ubh,
                        decoration: InputDecoration(
                            label: Text("Password"),
                            border: OutlineInputBorder()),
                      ),
                      OutlinedButton(
                          onPressed: () => newpw(ubh.text),
                          child: Text("New password")),
                    ],
                  ),
                ),
              ),
            ));
          } else {
            Get.offNamed(Routes.HOME);
          }
        } else {
          return Get.defaultDialog(
              title: "Gagal",
              middleText: 'silakan verifikasi',
              actions: [
                OutlinedButton(
                  onPressed: () => Get.back(),
                  child: Text("Cencel"),
                ),
                OutlinedButton(
                    onPressed: () async {
                      await UserCredential.user!.sendEmailVerification();
                    },
                    child: Text("Kirim ulang"))
              ]);
        }
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return Get.defaultDialog(
            title: "Gagal login", middleText: 'Email atauPassword Salah');
      } else if (e.code == 'wrong-password') {
        return Get.defaultDialog(
            title: "Gagal login", middleText: 'Password Salah');
      }
    }
  }
}
