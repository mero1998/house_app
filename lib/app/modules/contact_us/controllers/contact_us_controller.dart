import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ContactUsController extends GetxController {
  //TODO: Implement ContactUsController

  GlobalKey<FormState> contactFormKey = GlobalKey<FormState>();

  late TextEditingController emailController, contentController, nameController;

  var email = '';
  var name = '';
  var content = '';
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
    contentController = TextEditingController();
    nameController = TextEditingController();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    emailController.dispose();
    contentController.dispose();
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
  void checkRegisterForm() {
    final isValid = contactFormKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    contactFormKey.currentState!.save();
    doRegister();
  }

  void doRegister() {

  }
  void increment() => count.value++;
}
