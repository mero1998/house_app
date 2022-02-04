import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class EditprofileController extends GetxController {
  //TODO: Implement EditprofileController
  GlobalKey<FormState> profileFormKey = GlobalKey<FormState>();

  late TextEditingController priceController, keywordController;

  var price = '';
  var keyword = '';
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    priceController = TextEditingController();
    keywordController = TextEditingController();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    priceController.dispose();
    keywordController.dispose();
  }


  String? validateAllField(String value) {
    if (value.length <= 0) {
      return "This filed should't blank";
    }
    return null;
  }


  void checkRegisterForm() {
    final isValid = profileFormKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    profileFormKey.currentState!.save();
    doRegister();
  }

  void doRegister() {

  }
  void increment() => count.value++;
}
