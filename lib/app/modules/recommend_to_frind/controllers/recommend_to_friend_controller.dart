import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class RecommendToFriendController extends GetxController {
  //TODO: Implement ContactUsController

  GlobalKey<FormState> recommendFormKey = GlobalKey<FormState>();

  late TextEditingController emailController;

  var email = '';

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    emailController.dispose();
  }

  String? validateEmail(String value) {
    if (!GetUtils.isEmail(value)) {
      return "Provide valid Email";
    }
    return null;
  }

  String? validateAllField(String value) {
    if (value.length <= 0) {
      return "This filed should't blank";
    }
    return null;
  }
  void checkRegisterForm() {
    final isValid = recommendFormKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    recommendFormKey.currentState!.save();
    doRegister();
  }

  void doRegister() {

  }
  void increment() => count.value++;
}
