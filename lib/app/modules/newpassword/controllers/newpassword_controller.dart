import 'package:absensi/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class NewpasswordController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  void newpw(ubh) async {
    try {
      if (ubh == '123123') {
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
}
