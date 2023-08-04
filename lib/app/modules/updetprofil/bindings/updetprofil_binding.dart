import 'package:get/get.dart';

import '../controllers/updetprofil_controller.dart';

class UpdetprofilBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdetprofilController>(
      () => UpdetprofilController(),
    );
  }
}
