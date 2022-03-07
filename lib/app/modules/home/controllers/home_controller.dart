import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:perfect/app/api/api_settings.dart';
import 'package:perfect/app/models/about_company.dart';
import 'package:perfect/app/models/image_home.dart';
import 'package:perfect/app/models/saved_property.dart';
import 'package:perfect/preferences/user_preferences.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  //TODO: Implement HomeController

  RxList<ImageHome?> homeImageList = <ImageHome>[].obs;
  RxList<SavedProperty?> savedProp = <SavedProperty>[].obs;
  RxList<AboutCompany?> aboutCompanyList = <AboutCompany>[].obs;
  final count = 0.obs;
  RxBool click = false.obs;
  @override
  void onInit() {
    super.onInit();
    getHomeImage();
    getSavedProp();
    getAboutCompany();

  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;


 Future<ImageHome?> getStaticImageFromApi() async{

   var url = Uri.parse(ApiSettings.HOMEIMAGE + "&language=${UserPreferences().codeLang}");

   var response = await http.get(url);
   print(response.statusCode);
   if (response.statusCode == 200) {
     var jsonResponse  = jsonDecode(response.body)['data'];

     print(response.statusCode);
     return ImageHome.fromJson(jsonResponse);
   }
   return null;
  }

  Future<AboutCompany?> getStaticAboutCompanyFromApi() async{

    var url = Uri.parse(ApiSettings.ABOUTCOMPANY + "&language=${UserPreferences().codeLang}");

    var response = await http.get(url);
    print(response.statusCode);
    if (response.statusCode == 200) {
      print("We are here");
      var jsonResponse  = jsonDecode(response.body)['data'];
      print(response.statusCode);
      return AboutCompany.fromJson(jsonResponse);
    }
    return null;
  }

  Future<List<SavedProperty>> getSavedPropertyFromApi() async{
    var url = Uri.parse(ApiSettings.GETFAVOURATE);

    var response = await http.get(url,
    headers: {
      HttpHeaders.authorizationHeader : UserPreferences().getToken(),
    }
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      var jsonResponse  = jsonDecode(response.body)['data'] as List;
      print(response.statusCode);
      List<SavedProperty> list = jsonResponse.map((e) =>SavedProperty.fromJson(e)).toList();
      return list;
    }
    return [];
  }

  void getSavedProp() async{
    savedProp.value = await getSavedPropertyFromApi();
  }
  void getHomeImage() async{

   ImageHome? homeImage = await getStaticImageFromApi();
   homeImageList.add(homeImage);
  }

  void getAboutCompany() async{

    AboutCompany? aboutCompany = await getStaticAboutCompanyFromApi();

    aboutCompanyList.add(aboutCompany);
  }
}
