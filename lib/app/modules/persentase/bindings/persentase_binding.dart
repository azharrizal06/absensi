import 'package:get/get.dart';

import '../controllers/persentase_controller.dart';

class PersentaseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PersentaseController>(
      () => PersentaseController(),
    );
  }
}
