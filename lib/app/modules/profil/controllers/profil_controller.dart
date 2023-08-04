import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProfilController extends GetxController {
  final ImagePicker picker = ImagePicker();
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestoree = FirebaseFirestore.instance;
  FirebaseStorage storageRef = FirebaseStorage.instance;
  XFile? image;
  var isLoading = false.obs;
  void Hapus() async {
    isLoading.value = true;
    try {
      String uid = await auth.currentUser!.uid;
      await firestoree
          .collection('mahasiswa')
          .doc(uid)
          .update({'image': FieldValue.delete()});

      update();
      Get.snackbar("Berhasil", 'profil berhasil di hapus');
      isLoading.value = false;
    } catch (e) {
      Get.snackbar("gagal", 'profil Gagalk di hapus');
    }
  }

  Future<void> photo() async {
    String uid = await auth.currentUser!.uid;
    image = await picker.pickImage(source: ImageSource.gallery);
    Map<String, dynamic> data = {};
    if (image != null) {
      String ext = image!.name.split('.').last;
      File file = File(image!.path);
      await storageRef.ref('$uid/image.$ext').putFile(file);
      String imageUrl =
          await storageRef.ref('$uid/image.$ext').getDownloadURL();
      ;
      data.addAll({'image': "$imageUrl"});
      Get.snackbar("Berhasil", 'profil berhasil di Ubah');
    } else {
      print(image);
    }

    await firestoree.collection('mahasiswa').doc(uid).update(data);
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getprofil() async* {
    String uid = await auth.currentUser!.uid;
    yield* firestoree.collection("mahasiswa").doc(uid).snapshots();
    // print('ini''${coba}');
  }
}
