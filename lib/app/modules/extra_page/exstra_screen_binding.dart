import 'package:get/get.dart';
import 'package:perfect/app/modules/extra_page/extra_screen_controller.dart';

class ExtraPageBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<ExtraScreenController>(() => ExtraScreenController());
  }

}