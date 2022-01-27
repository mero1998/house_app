import 'package:get/get.dart';

import '../controllers/propertydetails_controller.dart';

class PropertydetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PropertydetailsController>(
      () => PropertydetailsController(),
    );
  }
}
