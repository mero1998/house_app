import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:perfect/app/api/api_settings.dart';
import 'package:perfect/app/models/user.dart';
import 'package:perfect/app/routes/app_pages.dart';
import 'package:http/http.dart' as http;
import 'package:perfect/preferences/user_preferences.dart';

class LoginController extends GetxController {


  static LoginController get to => Get.find();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  late TextEditingController emailController, passwordController, confirmController;

  RxBool click = false.obs;
  var email = '';
  var password = '';

  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmController = TextEditingController();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    // emailController.dispose();
    // passwordController.dispose();
    // confirmController.dispose();
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

  bool checkLoginForm() {
    final isValid = loginFormKey.currentState!.validate();
    if (!isValid) {
      return false;
    }else{
      loginFormKey.currentState!.save();
      return true;
    }

    // saveToShared();
  }

  Future<User?>  doLogin() async{
    click.value = true;
    var url = Uri.parse(ApiSettings.LOGIN_USER);
    var response = await http.post(url, body: {
      "email":  emailController.text,
      "password" :  passwordController.text,
    },
    );
    print(    click.value);
    if(response.statusCode == 200){
      var jsonResponse  = jsonDecode(response.body)['data'];
      Get.snackbar("Success", "Login Success", backgroundColor: Colors.green);
      Get.offAndToNamed(Routes.HOME);
      // UserPreferences().save(User.fromJson(jsonResponse));
      click.value = false;

      return User.fromJson(jsonResponse);
    }else{
      Get.snackbar("Filed", "Login Filed", backgroundColor: Colors.red);
      click.value = false;
      return null;
    }

  }


  Future logout() async{

    print("We are here");
    var url  = Uri.parse(ApiSettings.LOGOUT_USER);
    var response = await http.get(url , headers: {
      HttpHeaders.authorizationHeader : UserPreferences().getToken(),
    });
    print(response.statusCode);
    if(response.statusCode == 200){
      UserPreferences().logout();
      Get.offNamedUntil(Routes.LOGIN, (route) => false);
      return true;
    }
    return false;

  }

  saveToShared() async{
    User? user = await doLogin();
    if(user != null){
      UserPreferences().save(user!);
    }

  }



}
