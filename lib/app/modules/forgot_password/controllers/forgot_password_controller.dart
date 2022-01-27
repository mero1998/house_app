import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:perfect/app/routes/app_pages.dart';

class ForgotPasswordController extends GetxController {
  GlobalKey<FormState> forgotPasswordFormKey = GlobalKey<FormState>();

  late TextEditingController emailController;
  var email = '';

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

  String? validatePassword(String value) {
    if (value.length < 8) {
      return "Password must be of 8 characters";
    }
    return null;
  }

  void checkForm() {
    final isValid = forgotPasswordFormKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    forgotPasswordFormKey.currentState!.save();
    doLogin();
  }

  void doLogin() {
    Get.offAndToNamed(Routes.LOGIN);
  }

}
