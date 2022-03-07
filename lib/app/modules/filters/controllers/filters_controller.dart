import 'dart:convert';

import 'package:get/get.dart';
import 'package:perfect/app/api/api_settings.dart';
import 'package:perfect/app/models/house_type.dart';
import 'package:perfect/app/models/property_type.dart';
import 'package:perfect/preferences/user_preferences.dart';
import 'package:http/http.dart' as http;
class FiltersController extends GetxController {
  //TODO: Implement FiltersController
RxList<PropertyType?> propertyTypes = <PropertyType>[].obs;
RxList<HouseType?> houseTypes = <HouseType>[].obs;

RxList<PropertyType> selectedProperty  = <PropertyType>[].obs;
RxList<HouseType> selectedHouseType = <HouseType>[].obs;
RxList<String> selectedKeyword = <String>[].obs;
RxList<int> indexesProp = <int>[].obs;
RxList<int> indexesHouseType = <int>[].obs;
RxList<int> indexesKeyword = <int>[].obs;
RxList<String> selectedPropertyTypesIds = <String>[].obs;
RxList<String> selectedHouseTypesIds = <String>[].obs;
RxInt radius = 0.obs;
RxString address = "".obs;
static FiltersController get to => Get.find();
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    getStaticPropertyType();
    getStaticHouseType();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;

Future<List<PropertyType?>> getStaticPropertyTypeApi() async{
print("We are here>>");
  var url = Uri.parse(ApiSettings.PROPERTYTYPE + "&language=${UserPreferences().codeLang}");

  var response = await http.get(url);
  print(response.statusCode);
  if (response.statusCode == 200) {


    // var jsonResponse = jsonDecode(response.body)['list'] as List;
    // List<Address> addresses = jsonResponse.map((e) => Address.fromJson(e)).toList();
    // return addresses;
    var jsonResponse  = jsonDecode(response.body)['data'] as List;
    print(response.statusCode);
     List<PropertyType> list = jsonResponse.map((e) =>PropertyType.fromJson(e)).toList();
  return list;
  }
  return [];
}

  void getStaticPropertyType() async{
    propertyTypes.value = await getStaticPropertyTypeApi();
}


Future<List<HouseType?>> getStaticHouseTypeApi() async{
  print("We are here>>");
  var url = Uri.parse(ApiSettings.HouseTypes + "&language=${UserPreferences().codeLang}");

  var response = await http.get(url);
  print(response.statusCode);
  if (response.statusCode == 200) {


    // var jsonResponse = jsonDecode(response.body)['list'] as List;
    // List<Address> addresses = jsonResponse.map((e) => Address.fromJson(e)).toList();
    // return addresses;
    var jsonResponse  = jsonDecode(response.body)['data'] as List;
    print(response.statusCode);
    List<HouseType> list = jsonResponse.map((e) =>HouseType.fromJson(e)).toList();
    return list;
  }
  return [];
}

void getStaticHouseType() async{
  houseTypes.value = await getStaticHouseTypeApi();
}
void selectProperty({required int index,required PropertyType propertyType}){

    selectedProperty.contains(propertyType)
        ? selectedProperty.remove(propertyType)
        : selectedProperty.add(propertyType);

    indexesProp.contains(index)
        ? indexesProp.remove(index)
        : indexesProp.add(index);


    selectedPropertyTypesIds.contains(propertyType.id.toString())
        ? selectedPropertyTypesIds.remove(propertyType.id.toString())
        : selectedPropertyTypesIds.add(propertyType.id.toString());

    print(selectedProperty.length);
    print(selectedPropertyTypesIds);
  }
void removeProperty({required int index,required PropertyType propertyType}){

    if(propertyType == selectedProperty[index]){
      selectedProperty.remove(propertyType);
    }else{
      print("No Match");
    }
  print(selectedProperty.length);
}

void selectHouseType({required int index,required HouseType houseType}){

  selectedHouseType.contains(houseType)
      ? selectedHouseType.remove(houseType)
      : selectedHouseType.add(houseType);

  indexesHouseType.contains(index)
      ? indexesHouseType.remove(index)
      : indexesHouseType.add(index);

  selectedHouseTypesIds.contains(houseType.id.toString())
      ? selectedHouseTypesIds.remove(houseType.id.toString())
      : selectedHouseTypesIds.add(houseType.id.toString());

  print(selectedProperty.length);
}
void removeHouseType({required int index,required HouseType houseType}){

  if(houseType == selectedHouseType[index]){
    selectedHouseType.remove(houseType);
  }else{
    print("No Match");
  }
  print(selectedHouseType.length);
}



void selectKeyword({required int index,required String keyword}){

  selectedKeyword.contains(keyword)
      ? selectedKeyword.remove(keyword)
      : selectedKeyword.add(keyword);

  indexesKeyword.contains(index)
      ? indexesKeyword.remove(index)
      : indexesKeyword.add(index);

  print(selectedProperty.length);
}
void removeKeyword({required int index,required String keyword}){

  if(keyword == selectedKeyword[index]){
    selectedKeyword.remove(keyword);
  }else{
    print("No Match");
  }
  print(selectedKeyword.length);
}

}
