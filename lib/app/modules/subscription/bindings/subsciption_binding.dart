import 'package:get/get.dart';

import '../controllers/subsciption_controller.dart';

class SubsciptionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SubsciptionController>(
      () => SubsciptionController(),
    );
  }
}
