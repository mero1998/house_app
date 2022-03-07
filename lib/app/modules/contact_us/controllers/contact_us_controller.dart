import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:perfect/app/api/api_settings.dart';
import 'package:http/http.dart' as http;

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
    contact();
  }

  Future<bool> contact() async{
    var url = Uri.parse(ApiSettings.CONTACT);

    var response = await http.post(url, body: {
      "name": nameController.text,
      "email" : emailController.text,
      "content": contentController.text,
    });
    print(response.statusCode);
    var jsonResponse  = jsonDecode(response.body)['message'];
    if (response.statusCode == 200) {
      Get.snackbar("Success", jsonResponse,backgroundColor: Colors.green);
      return true;
    }
    Get.snackbar("Filed", jsonResponse,backgroundColor: Colors.red);
    return false;
  }
  void increment() => count.value++;
}
