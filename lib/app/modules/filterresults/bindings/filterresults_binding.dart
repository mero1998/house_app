import 'package:get/get.dart';

import '../controllers/filterresults_controller.dart';

class FilterresultsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FilterresultsController>(
      () => FilterresultsController(),
    );
  }
}
