import 'package:get/get.dart';

import '../controllers/updetpassword_controller.dart';

class UpdetpasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdetpasswordController>(
      () => UpdetpasswordController(),
    );
  }
}
