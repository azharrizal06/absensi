import 'package:get/get.dart';

import '../controllers/allabsen_controller.dart';

class AllabsenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllabsenController>(
      () => AllabsenController(),
    );
  }
}
