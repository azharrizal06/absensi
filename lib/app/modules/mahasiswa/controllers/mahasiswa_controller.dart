import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../firebase_options.dart';

class MahasiswaController extends GetxController {
  TextEditingController Emailc = TextEditingController();
  TextEditingController NIMc = TextEditingController();
  TextEditingController Namac = TextEditingController();
  TextEditingController pwadmin = TextEditingController(text: '123123123');
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final RxString selectedValue = ''.obs;

  void setSelectedValue(String value) {
    selectedValue.value = value;
  }

  Future<void> adm() async {
    if (pwadmin.text.isNotEmpty) {
      try {
        String emailadm = auth.currentUser!.email!;

        UserCredential userCredential =
            await auth.createUserWithEmailAndPassword(
          email: Emailc.text,
          password: "STMIKIKMI",
        );

        if (userCredential.user != null) {
          await userCredential.user!.sendEmailVerification();
          String idu = userCredential.user!.uid;

          await firestore.collection('mahasiswa').doc(idu).set({
            'Nim': NIMc.text,
            'Nama': Namac.text,
            'Email': Emailc.text,
            'Waktu': DateTime.now().toIso8601String(),
            'id': idu,
            'rout': 'mahasiswa',
            'Kelas': selectedValue.value,
          });

          await auth.signOut();

          UserCredential admin = await auth.signInWithEmailAndPassword(
            email: emailadm,
            password: pwadmin.text,
          );
          print(admin);
          Get.back();
          Get.snackbar('Berhasil', 'Data mahasiswa telah ditambahkan');
        } else {
          Get.snackbar('Gagal', 'Terjadi kesalahan');
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          Get.snackbar('Gagal', 'Terjadi kesalahan, password terlalu lemah');
        } else if (e.code == 'email-already-in-use') {
          Get.snackbar('Gagal', 'Terjadi kesalahan, email sudah digunakan');
        } else {
          Get.snackbar('Gagal', 'Terjadi kesalahan');
        }
      } catch (e) {
        Get.snackbar('Gagal', 'Terjadi kesalahan');
      }
    } else {
      Get.snackbar('Gagal', 'Terjadi kesalahan');
    }
  }

  void addmhs(String Namac, String NIMc, String Emailc) async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    if (Emailc.isNotEmpty && NIMc.isNotEmpty && Namac.isNotEmpty) {
      Get.defaultDialog(
          title: "Konfirmasi",
          content: Column(
            children: [
              TextField(
                autocorrect: false,
                controller: pwadmin,
                decoration: InputDecoration(
                  labelText: "password",
                  hintText: "password",
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            OutlinedButton(
              onPressed: () => Get.back(),
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                adm();
              },
              child: Text("OK"),
            ),
          ]);
    }
  }
}
