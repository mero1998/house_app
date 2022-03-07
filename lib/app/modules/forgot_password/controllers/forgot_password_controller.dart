import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:perfect/app/api/api_settings.dart';
import 'package:perfect/app/modules/login/bindings/login_binding.dart';
import 'package:perfect/app/routes/app_pages.dart';
import 'package:http/http.dart' as http;

class ForgotPasswordController extends GetxController {
  GlobalKey<FormState> forgotPasswordFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> resetPasswordFormKey = GlobalKey<FormState>();

  late TextEditingController emailController, otpController, passwordController, confPasswordConroller;
  var email = '';
  var otp = '';
  var password = '';
  var confPassword = '';
  RxBool click = false.obs;

  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
    otpController = TextEditingController();
    passwordController = TextEditingController();
    confPasswordConroller = TextEditingController();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    // emailController.dispose();

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
  String? validateConfPassword(String value) {
    if (value.length < 8) {
      return "Password must be of 8 characters";
    }else if(passwordController.text != confPasswordConroller.text){
      return "Your passwords in not match";
    }
    return null;
  }
  // String? validateMatchPassword(String value) {
  //   if (passwordController.text != confPasswordConroller.text) {
  //     return "Your passwords in not match";
  //   }
  //   return null;
  // }

  void checkFormForget() {
    final isValid = forgotPasswordFormKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    forgotPasswordFormKey.currentState!.save();
    sendOtp();
  }
  void checkFormReset() {
    final isValid = resetPasswordFormKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    resetPasswordFormKey.currentState!.save();
    resetPassword();
  }

  void sendOtp() async {
     click.value = true;

    var url = Uri.parse(ApiSettings.SENDOTP);

    var response = await http.post(url, body: {
      "email" : emailController.text,
    });
    print(response.statusCode);
    var jsonResponse  = jsonDecode(response.body)['message'];

    if (jsonDecode(response.body)["status"] == "success") {

      print(response.statusCode);
      click.value = false;
      Get.snackbar("Success", jsonResponse,backgroundColor: Colors.green);
      Get.offAndToNamed(Routes.RESETPASSWORD);
    }else{
      click.value = false;
      Get.snackbar("Filed", jsonResponse, backgroundColor: Colors.red);

    }
     click.value = false;
     return null;
  }

  void resetPassword() async {

    click.value = true;

    var url = Uri.parse(ApiSettings.RESETPASSWORD);

    var response = await http.post(url, body: {
      "code" : otpController.text,
      "password" : passwordController.text
    });
    print(response.statusCode);
    var jsonResponse  = jsonDecode(response.body)['message'];

    if (jsonDecode(response.body)["status"] == "success") {

      print(response.statusCode);
      Get.snackbar("Success", jsonResponse,backgroundColor: Colors.green);
      click.value = false;

      Get.offNamedUntil(Routes.LOGIN, (route) => false);
      // Get.offNamedUntil(Routes.LOGIN);
    }else{
      click.value = false;

      Get.snackbar("Filed", jsonResponse, backgroundColor: Colors.red);

    }
    click.value = false;

    return null;
  }
  }


