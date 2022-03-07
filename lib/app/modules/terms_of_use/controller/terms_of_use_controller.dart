import 'dart:convert';

import 'package:get/get.dart';
import 'package:perfect/app/api/api_settings.dart';
import 'package:perfect/app/models/privacy_policy.dart';
import 'package:perfect/app/models/terms_of_use.dart';
import 'package:perfect/preferences/user_preferences.dart';
import 'package:http/http.dart' as http;
class TermsOfUseController extends GetxController{

  RxList<TermsOfUse> termsOfUseList = <TermsOfUse>[].obs;


  @override
  void onInit() {
    super.onInit();
    getTermsOfUse();
  }

  Future<TermsOfUse?> getStaticTermsOfUseFromApi() async{

    var url = Uri.parse(ApiSettings.TERMSOFUSE + "&language=${UserPreferences().codeLang}");

    var response = await http.get(url);
    print(response.statusCode);
    if (response.statusCode == 200) {
      var jsonResponse  = jsonDecode(response.body)['data'];
      print(response.statusCode);
      return TermsOfUse.fromJson(jsonResponse);
    }
    return null;
  }


  void getTermsOfUse() async{

    TermsOfUse? termsOfUse = await getStaticTermsOfUseFromApi();

    termsOfUseList.add(termsOfUse!);
  }
}