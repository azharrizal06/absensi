import 'package:absensi/app/controllers/navigasi_controller.dart';
// import 'package:absensi/app/modules/load/views/load_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'firebase_options.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(Myapp());
}

class Myapp extends StatefulWidget {
  const Myapp({Key? key}) : super(key: key);

  @override
  State<Myapp> createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
  @override
  Widget build(BuildContext context) {
    final navc = Get.put(NavigasiController(), permanent: true);
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snp) {
          if (snp.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          print(snp.data);
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: "Application",
            initialRoute: snp.data != null ? Routes.HOME : Routes.LOGIN,
            getPages: AppPages.routes,
          );
        });
  }
}
