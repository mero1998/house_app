import 'package:get/get.dart';
import 'package:perfect/app/modules/privacy_policy/controller/privacy_policy_controller.dart';


class PrivacyPolicyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PrivacyPolicyController>(
          () => PrivacyPolicyController(),
    );
  }
}