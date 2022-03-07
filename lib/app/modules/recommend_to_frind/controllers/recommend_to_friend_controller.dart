import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:perfect/app/api/api_settings.dart';
import 'package:http/http.dart' as http;
import 'package:perfect/preferences/user_preferences.dart';
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
    recommendToFriend();
  }

  Future<bool> recommendToFriend() async{
    var url = Uri.parse(ApiSettings.RECOMMENDTOFRIEND);

    var response = await http.post(url, body: {
      "email" : emailController.text,
    }, headers: {
      HttpHeaders.authorizationHeader : UserPreferences().getToken(),
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
