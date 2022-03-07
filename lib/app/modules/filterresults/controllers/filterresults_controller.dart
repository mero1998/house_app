import 'dart:convert';

import 'package:get/get.dart';
import 'package:perfect/app/api/api_settings.dart';
import 'package:perfect/app/models/media.dart';
import 'package:perfect/app/models/property.dart';
import 'package:perfect/app/models/search_result.dart';
import 'package:http/http.dart' as http;

class FilterresultsController extends GetxController {

  RxList<FilterResult?> propertiesFilter = <FilterResult>[].obs;

  RxBool isLoading = true.obs;
  RxBool click = false.obs;
  // var propertyList = <Property>[].obs;
  // var  medias = <Media>[];
  // var  medias1 = <Media>[];
  // var  medias2 = <Media>[];

  static FilterresultsController get to => Get.find();
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
    isLoading.value = true;
  }

  Future<List<FilterResult?>> getPropertyListFromApi({required String propertyType,required String houseType,
    required int radius, required String address, required String keyword,required double latitude,  required double longitude, }) async {
    print("We are here>>");
    var url = Uri.parse(ApiSettings.SEARCH);

    var response = await http.post(url, body: {
      "property_type" : propertyType,
      "house_types" : houseType,
      "radius" : radius.toString(),
      "keyword" : keyword,
      "address" : address,
      "latitude": latitude.toString(),
      "longitude" :longitude.toString()
    });
    print(response.statusCode);
    if (response.statusCode == 200) {
      var jsonResponse  = jsonDecode(response.body)['data']['filter_result'] as List;
      print(response.statusCode);
      List<FilterResult> list = jsonResponse.map((e) =>FilterResult.fromJson(e)).toList();
      return list;
    }
    return [];
   }

   void getPropertyList({required String propertyType,required String houseType,required double latitude,  required double longitude,
     required int radius, required String address, required String keyword }) async{
     click.value = true;
     isLoading.value = true;
     propertiesFilter.value = await getPropertyListFromApi(propertyType: propertyType, houseType: houseType, radius: radius,
         address: address, keyword: keyword,
        latitude:latitude,   longitude:longitude,);
     click.value = false;
     isLoading.value = false;
      print(propertiesFilter.length);
     }
  //
  //    medias.add(Media(image: "assets/image/prop_1.png"));
  //    medias.add(Media(image: "assets/image/prop_2.png"));
  //    medias.add(Media(image: "assets/image/prop_3.png"));
  //    medias.add(Media(image: "assets/image/prop_4.png"));
  //    medias.add(Media(image: "assets/image/prop_5.png"));
  //    medias.add(Media(image: "assets/image/logo_1.png"));
  //
  //
  //    propertyList.add(Property(name: "ABC company name", address: "78587 Newcastle, Calabasas, California",
  //        city: "California", contactNo: "9876543210", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Enim at scelerisque porttitor erat bibendum. Venenatis sed non, aenean enim pulvinar arcu in porta. Turpis eu suspendisse netus nunc duis commodo imperdiet euismod ultrices. Odio dictumst non tortor ut tincidunt. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Enim at scelerisque porttitor erat bibendum. Venenatis sed non, aenean enim pulvinar arcu in porta. Turpis eu suspendisse netus nunc duis commodo imperdiet euismod ultrices. Odio dictumst non tortor ut tincidunt",
  //        latitude: "0.0", longitude: "0.0", medias: medias));
  //
  //    medias1.add(Media(image: "assets/image/prop_11.png"));
  //    medias1.add(Media(image: "assets/image/prop_12.png"));
  //    medias1.add(Media(image: "assets/image/prop_13.png"));
  //    medias1.add(Media(image: "assets/image/prop_14.png"));
  //    medias1.add(Media(image: "assets/image/prop_15.png"));
  //    medias1.add(Media(image: "assets/image/logo_2.png"));
  //
  //    propertyList.add(Property(name: "ABC company name", address: "78587 Newcastle, Calabasas, California",
  //        city: "California", contactNo: "9876543210", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Enim at scelerisque porttitor erat bibendum. Venenatis sed non, aenean enim pulvinar arcu in porta. Turpis eu suspendisse netus nunc duis commodo imperdiet euismod ultrices. Odio dictumst non tortor ut tincidunt. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Enim at scelerisque porttitor erat bibendum. Venenatis sed non, aenean enim pulvinar arcu in porta. Turpis eu suspendisse netus nunc duis commodo imperdiet euismod ultrices. Odio dictumst non tortor ut tincidunt",
  //        latitude: "0.0", longitude: "0.0", medias: medias1));
  //
  //    medias2.add(Media(image: "assets/image/prop_1.png"));
  //    medias2.add(Media(image: "assets/image/prop_12.png"));
  //    medias2.add(Media(image: "assets/image/prop_3.png"));
  //    medias2.add(Media(image: "assets/image/prop_14.png"));
  //    medias2.add(Media(image: "assets/image/prop_16.png"));
  //    medias2.add(Media(image: "assets/image/add_logo.png"));
  //
  //    propertyList.add(Property(name: "ABC company name", address: "78587 Newcastle, Calabasas, California",
  //        city: "California", contactNo: "9876543210", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Enim at scelerisque porttitor erat bibendum. Venenatis sed non, aenean enim pulvinar arcu in porta. Turpis eu suspendisse netus nunc duis commodo imperdiet euismod ultrices. Odio dictumst non tortor ut tincidunt. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Enim at scelerisque porttitor erat bibendum. Venenatis sed non, aenean enim pulvinar arcu in porta. Turpis eu suspendisse netus nunc duis commodo imperdiet euismod ultrices. Odio dictumst non tortor ut tincidunt",
  //        latitude: "0.0", longitude: "0.0", medias: medias2));
  //
  //
  // }

}
