import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:perfect/app/api/api_settings.dart';
import 'package:http/http.dart' as http;
import 'package:perfect/app/models/user.dart';
import 'package:perfect/app/routes/app_pages.dart';
import 'package:perfect/preferences/user_preferences.dart';

class RegistrationController extends GetxController {

  var jobType = 0.obs;

  GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();

  late TextEditingController emailController, passwordController, nameController;
  RxBool click = false.obs;
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

  bool checkRegisterForm(){
    final isValid = registerFormKey.currentState!.validate();
    if (!isValid) {
      return false;
    }else{
      registerFormKey.currentState!.save();

      return true;
    }

  }

  Future<User?> doRegister() async{

    click.value = true;
    var url = Uri.parse(ApiSettings.REGISTER_USER);

    var response = await http.post(url, body: {
      "name": nameController.text,
      "password": passwordController.text,
      "email" : emailController.text,
      "type": jobType.value == 0 ? "guest" : "company",
    });
    print(response.statusCode);
    if (response.statusCode == 200) {
      var jsonResponse  = jsonDecode(response.body)['data'];

      print(response.statusCode);
      Get.snackbar("Success", "Registered Successful",backgroundColor: Colors.green);
    Get.offAndToNamed(Routes.HOME);
    UserPreferences().save(User.fromJson(jsonResponse));
      click.value = false;

      return User.fromJson(jsonResponse);
    }
    Get.snackbar("Filed", "Registered Filed",backgroundColor: Colors.red);
    click.value = false;

    return null;
  }

}
