import 'dart:convert';

import 'package:get/get.dart';
import 'package:perfect/app/api/api_settings.dart';
import 'package:perfect/app/models/privacy_policy.dart';
import 'package:perfect/preferences/user_preferences.dart';
import 'package:http/http.dart' as http;
class PrivacyPolicyController extends GetxController{

  RxList<PrivacyPolicy> privacyPolicyList = <PrivacyPolicy>[].obs;


  @override
  void onInit() {
    super.onInit();
    getPrivacyPolicy();
  }

  Future<PrivacyPolicy?> getStaticPrivacyPoilcyFromApi() async{

    var url = Uri.parse(ApiSettings.PRIVACYPOLICY + "&language=${UserPreferences().codeLang}");

    var response = await http.get(url);
    print(response.statusCode);
    if (response.statusCode == 200) {
      var jsonResponse  = jsonDecode(response.body)['data'];
      print(response.statusCode);
      return PrivacyPolicy.fromJson(jsonResponse);
    }
    return null;
  }


  void getPrivacyPolicy() async{

    PrivacyPolicy? privacyPolicy = await getStaticPrivacyPoilcyFromApi();

    privacyPolicyList.add(privacyPolicy!);
  }
}