import 'package:get/get.dart';
import 'package:perfect/app/modules/privacy_policy/controller/privacy_policy_controller.dart';
import 'package:perfect/app/modules/terms_of_use/controller/terms_of_use_controller.dart';


class TermsOfUseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TermsOfUseController>(
          () => TermsOfUseController(),
    );
  }
}