import 'dart:convert';
import 'dart:io';

// import 'package:flutter_google_street_view/flutter_google_street_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:perfect/app/api/api_settings.dart';
import 'package:perfect/app/models/company_profile.dart';
import 'package:perfect/preferences/user_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
class PropertydetailsController extends GetxController {

  static PropertydetailsController get to => Get.find();
  RxList<CompanyProfile?> companyDetails = <CompanyProfile>[].obs;
  Set<Marker> allMarkers = <Marker>{};
  RxBool isFav = false.obs;
  RxBool isReport = false.obs;
  RxBool isLoading = true.obs;
  @override
  void onInit() {
    super.onInit();


  }

  @override
  void onReady() {
    super.onReady();

  }

  @override
  void onClose() {
    companyDetails.clear();
    isLoading.value = true;
  }


  Future<CompanyProfile?> getCompanyDetailsFromApi(
      {required int companyId}) async {
    print("we are here...");
    // print("productID : ${productId.toString()}");
    var url = Uri.parse(
        ApiSettings.COMPANYDETAILS + companyId.toString() + "&language=" +
            UserPreferences().codeLang);
    print("Url : ${url.toString()}");
    print(UserPreferences().getToken());
    var response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: UserPreferences().getToken(),
      // "X-Requested-With" : "XMLHttpRequest",
    });

    print(response.statusCode);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body)['data'];
      return CompanyProfile.fromJson(jsonResponse);
    }
    return null;
  }


  void getCompanyDetails({required int companyId}) async {
    isLoading.value = true;
    print("Is Loadnig: $isLoading");
  // companyDetails.clear();
    CompanyProfile? companyProfile = await getCompanyDetailsFromApi(
        companyId: companyId);
    companyDetails.add(companyProfile);
    isFav.value = companyDetails.first!.favorite!;
    isReport.value = companyDetails.first!.report!;
    allMarkers.add(Marker(
      markerId: MarkerId('change'),
      infoWindow: InfoWindow(
        title:  PropertydetailsController.to.companyDetails.first!.companyAddress ?? "",
      ),

      visible: true,
      position: LatLng(31.376438, 34.318592),
    ));
    print(companyDetails.length);
    print(companyDetails);
    isLoading.value = false;

  }

  void makeCall() async {
    if (!await launch("tel://${companyDetails.first!
        .companyPhoneNumber}")) throw 'Could not call';
  }

  sendEamil() async {
    final url =
    Uri.encodeFull('mailto:${companyDetails.first!.companyEmail}?subject=&body=');
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<bool> reportAPI({required int value}) async {

    var url = Uri.parse(ApiSettings.REPORTCOMPANY);

    var response = await http.post(url, body: {
      "company_id" : companyDetails.first!.companyId.toString(),
      "value" : value.toString()
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
  Future<bool> favourateAPI({required int value}) async {

    var url = Uri.parse(ApiSettings.FAVOURATE);

    var response = await http.post(url, body: {
      "company_id" : companyDetails.first!.companyId.toString(),
      "value" : value.toString()
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



  Future<void> addFavoriteProperty({required int value, required int companyId}) async {
   bool fav =  await favourateAPI(value: value);
  if(fav){
    if (companyDetails
        .where((element) => element!.companyId == companyId)
        .isNotEmpty) {
      if (companyDetails
          .firstWhere((element) => element!.companyId == companyId)!
          .favorite!) {
        isFav.value = false;
        companyDetails
            .firstWhere((element) =>element!.companyId == companyId)!
            .favorite = false;

        print("False");
      } else {
        isFav.value = true;
        companyDetails
            .firstWhere((element) => element!.companyId == companyId)!
            .favorite = true;

        print("True");
      }
    }
    // companyDetails.refresh();
  }

  }

  Future<void> addReport({required int value, required int companyId}) async {
    bool report =  await reportAPI(value: value);
    if(report){
      if (companyDetails
          .where((element) => element!.companyId == companyId)
          .isNotEmpty) {
        if (companyDetails
            .firstWhere((element) => element!.companyId == companyId)!
            .report!) {
          companyDetails
              .firstWhere((element) =>element!.companyId == companyId)!
              .report = false;
          isReport.value = false;
          print("false");
        } else {
          companyDetails
              .firstWhere((element) => element!.companyId == companyId)!
              .report = true;
          isReport.value = true;
          print("True");
        }
      }

      print(isFav);
      // companyDetails.refresh();
    }

  }
}


