import 'package:get/get.dart';

import '../modules/allabsen/bindings/allabsen_binding.dart';
import '../modules/allabsen/views/allabsen_view.dart';
import '../modules/detail/bindings/detail_binding.dart';
import '../modules/detail/views/detail_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/load/bindings/load_binding.dart';
import '../modules/load/views/load_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/mahasiswa/bindings/mahasiswa_binding.dart';
import '../modules/mahasiswa/views/mahasiswa_view.dart';
import '../modules/newpassword/bindings/newpassword_binding.dart';
import '../modules/newpassword/views/newpassword_view.dart';
import '../modules/persentase/bindings/persentase_binding.dart';
import '../modules/persentase/views/persentase_view.dart';
import '../modules/profil/bindings/profil_binding.dart';
import '../modules/profil/views/profil_view.dart';
import '../modules/updetpassword/bindings/updetpassword_binding.dart';
import '../modules/updetpassword/views/updetpassword_view.dart';
import '../modules/updetprofil/bindings/updetprofil_binding.dart';
import '../modules/updetprofil/views/updetprofil_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.MAHASISWA,
      page: () => MahasiswaView(),
      binding: MahasiswaBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.NEWPASSWORD,
      page: () => NewpasswordView(),
      binding: NewpasswordBinding(),
    ),
    GetPage(
      name: _Paths.PROFIL,
      page: () => ProfilView(),
      binding: ProfilBinding(),
    ),
    GetPage(
      name: _Paths.UPDETPROFIL,
      page: () => UpdetprofilView(),
      binding: UpdetprofilBinding(),
    ),
    GetPage(
      name: _Paths.UPDETPASSWORD,
      page: () => UpdetpasswordView(),
      binding: UpdetpasswordBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL,
      page: () => DetailView(),
      binding: DetailBinding(),
    ),
    GetPage(
      name: _Paths.ALLABSEN,
      page: () => AllabsenView(),
      binding: AllabsenBinding(),
    ),
    GetPage(
      name: _Paths.LOAD,
      page: () => LoadView(),
      binding: LoadBinding(),
    ),
    GetPage(
      name: _Paths.PERSENTASE,
      page: () => PersentaseView(),
      binding: PersentaseBinding(),
    ),
  ];
}
