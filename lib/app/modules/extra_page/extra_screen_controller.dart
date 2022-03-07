import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:perfect/app/api/api_settings.dart';
import 'package:perfect/app/models/extra_screen.dart';
import 'package:perfect/preferences/user_preferences.dart';
import 'package:http/http.dart' as http;
class ExtraScreenController extends GetxController{

  RxList<ExtraScreen> extraScreenList = <ExtraScreen>[].obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getStaticExtraScreen();
  }


  Future<ExtraScreen?> getStaticExtraScreenFromApi() async{
    var url = Uri.parse(
        ApiSettings.EXTRASCREEN + "&language=" +
            UserPreferences().codeLang);
    print("Url : ${url.toString()}");
    print(UserPreferences().getToken());
    var response = await http.get(url);

    print(response.statusCode);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body)['data'];
      return ExtraScreen.fromJson(jsonResponse);
    }
    return null;
  }


  void getStaticExtraScreen() async{
    ExtraScreen? extraScreen = await getStaticExtraScreenFromApi();
   if(extraScreen != null){
     extraScreenList.add(extraScreen);
   }
  }
}