import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class RegistrationController extends GetxController {

  var jobType = 0.obs;

  GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();

  late TextEditingController emailController, passwordController, nameController;

  var email = '';
  var password = '';
  var name = '';

  setJobTypeRadio(val) {
    jobType.value = val;
  }

  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    nameController = TextEditingController();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
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

  String? validatePassword(String value) {
    if (value.length < 8) {
      return "Password must be of 8 characters";
    }
    return null;
  }

  void checkRegisterForm() {
    final isValid = registerFormKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    registerFormKey.currentState!.save();
    doRegister();
  }

  void doRegister() {

  }



}
