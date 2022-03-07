import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

import 'package:perfect/app/api/api_settings.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:perfect/app/data/constants.dart';
import 'package:perfect/app/models/company_profile.dart';
import 'package:perfect/app/models/house_type.dart';
import 'package:perfect/app/models/property_type.dart';
import 'package:perfect/app/modules/filterresults/controllers/filterresults_controller.dart';
import 'package:perfect/app/modules/filters/controllers/filters_controller.dart';
import 'package:perfect/app/modules/propertydetails/controllers/propertydetails_controller.dart';
import 'package:perfect/preferences/user_preferences.dart';

class EditprofileController extends GetxController {
  //TODO: Implement EditprofileController
  static EditprofileController get to => Get.find();
  GlobalKey<FormState> profileFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> profileImagesFormKey = GlobalKey<FormState>();

  RxList<PropertyType?> selectedPropertyTypes = <PropertyType>[].obs;
  RxList<HouseType?> selectedHouseType = <HouseType>[].obs;
  RxList<int> selectedHouseTypeIndex = <int>[].obs;
  RxList<int> selectedPropertyTypeIndex = <int>[].obs;
  XFile? pickedFile;
  XFile? pickedFileLogo;
  XFile? pickedFileAdd;
  // RxInt? index;
  // List<XFile?> companyImages;
  RxList<int> companyImagesIndxes = <int>[].obs;
  RxList<XFile> companyImages = <XFile>[].obs;
  ImagePicker _picker = ImagePicker();
  TextEditingController controllerAdd = TextEditingController();

  RxList<String> prices = <String>[].obs;
  RxList<String> keywords = <String>[].obs;
  RxList<int> pricesIndex = <int>[].obs;
  bool addButton = false;
  CompanyProfile? companyProfile;
  bool updateButton = false;
  RxBool click = false.obs;

  var company_images;
  File? companylogo;
  List<String> company_images_paths = [];
  List<String> company_images_prices = [];
  List<String> company_images_keywords = [];
  List<String> company_property_types = [];
  List<String> company_house_types = [];

  // late TextEditingController priceController, keywordController, companyNameController, companyAddressController, companyEmailController, companyPhoneController,
  // companyDescriptionController;

  var price = '';
  var keyword = '';
  final count = 0.obs;
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
    // priceController.dispose();
    // keywordController.dispose();
  }


  String? validateAllField(String value) {
    if (value.length <= 0) {
      return "This filed should't blank";
    }
    return null;
  }


  void checkRegisterForm() {
    final isValid = profileFormKey.currentState!.validate();
    if (!isValid) {
      return;
    }

    profileFormKey.currentState!.save();
    // saveCompanyProfile();
  }

  List<String> getImagePath() {
    for (int i = 0; i < companyImages.length; i ++) {
       company_images_paths.add(companyImages[i].path);
    }
    return company_images_paths;
  }
  // getImagesFromList() async{
  //   for(int i = 0; i < companyImages.length; i++){
  //    return await MultipartFile.fromFileSync(companyImages[i].path,
  //         filename: basename(companyImages[i].path));
  //   }
  // }

  Future<bool> saveCompanyProfile({ required String companyName,
    required String companyAddress,required String companyEmail,
    required String companyPhone, required  String companyDescription,
    required String imageLogoUrl, required List<CompanyImages> images,
  }) async{

    click.value = true;
    var url = Uri.parse(ApiSettings.SAVECOMPANYPROFILE);
    var request  = http.MultipartRequest("POST" , url);
    // if(pickedFileLogo != null){
    //   var companyLogo = await http.MultipartFile.fromPath("company_logo" , pickedFileLogo!.path);
    //   if(companyLogo != null){
    //     request.files.add(companyLogo);
    //   }else{
    //     final ByteData imageData = await NetworkAssetBundle(Uri.parse(imageLogoUrl)).load("");
    //     final Uint8List bytes = imageData.buffer.asUint8List();
    //     print("We are here Bytes: $bytes");
    //     // var companyLogo = await http.MultipartFile.fromPath("company_logo" , bytes.toString());
    //     request.files.add(companyLogo);
    //   }
    // }
if(pickedFileLogo != null){
  var stream = new http.ByteStream(pickedFileLogo!.openRead());
  var length = await pickedFileLogo!.length();

  var multipartFile = new http.MultipartFile("company_logo", stream, length,
      filename: basename(pickedFileLogo!.path));

  request.files.add(multipartFile);
}

   if(companyImages.length != 0){
     List<http.MultipartFile> newList = <http.MultipartFile>[];

     for (int i = 0; i < companyImages.length; i++) {
       // var path = await FlutterAbsolutePath.getAbsolutePath(imagesList[i].identifier);
       // File imageFile =  File(path);

       var stream = new http.ByteStream(companyImages[i].openRead());
       var length = await companyImages[i].length();

       var multipartFile = new http.MultipartFile("company_images[]", stream, length,
           filename: basename(companyImages[i].path));
       print("PATH:::: ${companyImages[i].path}");
       newList.add(multipartFile);
     }


     request.files.addAll(newList);
   }
    // if(companyImages != null){
    //   for (int i = 0; i < companyImages.length; i ++) {
    //     company_images = await http.MultipartFile.fromPath("company_images[]", companyImages[i].path ,);
    //     if(company_images != null){
    //       request.files.add(company_images);
    //     }
    //   }
    // }
    // else{
    //   for(int i = 0; i < images.length; i ++){
    //     final ByteData imageData = await NetworkAssetBundle(Uri.parse(images[i].imageUrl!)).load("");
    //     final Uint8List bytes = imageData.buffer.asUint8List();
    //     company_images = await http.MultipartFile.fromPath("company_images[]", bytes.p,);
    //     request.files.add(company_images);
    //   }
    //
    //
    // }
    String pricesStr = prices.reduce((value, element) {
      return value + "," + element;
    });
    String keywordsStr = keywords.reduce((value, element) {
      return value + "," + element;
    });
    request.fields.addAll({
      "company_image_prices" : pricesStr,
      "company_image_keywords":keywordsStr,
      "company_name": companyName,
      "company_address": companyAddress,
      "company_phone_number": companyPhone,
      "company_email":companyEmail,
      "company_property_types": company_property_types.toString(),
      "company_house_types": company_house_types.toString(),
      "company_description": companyDescription,
      "company_latitude": "0",
      "company_longitude": "0",
    });
    request.headers[HttpHeaders.authorizationHeader] = UserPreferences().getToken();
    request.headers["Content-Type"] = "multipart/form-data";


    var response = await request.send();

    response.stream.transform(utf8.decoder).listen((event) async {
      print(event);
      print("We are here");
      Get.snackbar("Message", jsonDecode(event));
    });
    print(response.statusCode);
    if (response.statusCode == 200) {
      click.value = false;
     return true;
    }
    click.value = false;
    Get.snackbar("Filed", "Saved Filed",backgroundColor: Colors.red);
    return false;
  }

  Future<void> pickImage() async {
    pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      // setState(() {});
    }
  }

  Future<void> pickImageLogo() async {
    pickedFileLogo = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFileLogo != null) {
      // setState(() {});
      update();

    }
  }

  Future<void> pickImageAdd() async {
    pickedFileAdd = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFileAdd != null) {
        update();
    }
  }

  Future<void> pickImagesCompany({ required int? index}) async {
    print("Null");

    print(index);
    XFile? picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      print("Success");
      print(companyImagesIndxes);
        if (companyImagesIndxes.contains(index)) {
          companyImages.removeAt(index!);
          companyImagesIndxes.removeAt(index);

          print("We are here,");
          update();
      }
      companyImages.add(picked);
      companyImagesIndxes.add(index!);
      update();

    }


  }

  // getData({required int index, required String price}){
  //
  //   TextEditingController controller = TextEditingController(text:price );
  //   if(pricesIndex.contains(index)){
  //     pricesIndex.removeAt(index);
  //     prices.removeAt(index);
  //     // prices.add(controller);
  //     // pricesIndex.add(index);
  //   }
  //   // prices.addIf(index == pricesIndex.elementAt(index), controller);
  //   // pricesIndex.addIf(index == index, index);
  //   prices.add(controller);
  //   pricesIndex.add(index);
  //   print(pricesIndex);
  // }


  void selectHouseType({required int index,required HouseType houseType}){

    selectedHouseType.contains(houseType)
        ? selectedHouseType.remove(houseType)
        : selectedHouseType.add(houseType);

    selectedHouseTypeIndex.contains(index)
        ? selectedHouseTypeIndex.remove(index)
        : selectedHouseTypeIndex.add(index);

    // selectedHouseTypesIds.contains(houseType.id.toString())
    //     ? selectedHouseTypesIds.remove(houseType.id.toString())
    //     : selectedHouseTypesIds.add(houseType.id.toString());

    print(selectedHouseType.length);
    print(selectedHouseType);
  }

  void removeHouseType({required int index,required HouseType houseType}){

    if(houseType == selectedHouseType[index]){
      selectedHouseType.remove(houseType);
    }else{
      print("No Match");
    }
    print(selectedHouseType.length);
  }


  void selectProperty({required int index,required PropertyType propertyType}){

    selectedPropertyTypes.contains(propertyType)
        ? selectedPropertyTypes.remove(propertyType)
        : selectedPropertyTypes.add(propertyType);

    selectedPropertyTypeIndex.contains(index)
        ? selectedPropertyTypeIndex.remove(index)
        : selectedPropertyTypeIndex.add(index);


    // selectedPropertyTypesIds.contains(propertyType.id.toString())
    //     ? selectedPropertyTypesIds.remove(propertyType.id.toString())
    //     : selectedPropertyTypesIds.add(propertyType.id.toString());

    // print(selectedProperty.length);
    // print(selectedPropertyTypesIds);
  }
  void removeProperty({required int index,required PropertyType propertyType}){

    if(propertyType == selectedPropertyTypes[index]){
      selectedPropertyTypes.remove(propertyType);
    }else{
      print("No Match");
    }
    print(selectedPropertyTypes.length);
  }

  void increment() => count.value++;
}
