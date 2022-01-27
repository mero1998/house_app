import 'package:get/get.dart';

import '../controllers/halp_controller.dart';

class HalpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HalpController>(
      () => HalpController(),
    );
  }
}
