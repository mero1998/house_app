import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:perfect/app/data/address_search.dart';
import 'package:perfect/app/data/constants.dart';
import 'package:perfect/app/data/place_service.dart';
import 'package:perfect/app/models/company_profile.dart';
import 'package:perfect/app/models/house_type.dart';
import 'package:perfect/app/modules/extra_page/extra_page_view.dart';
import 'package:perfect/app/modules/filterresults/controllers/filterresults_controller.dart';
import 'package:perfect/app/modules/filters/controllers/filters_controller.dart';
import 'package:perfect/app/modules/filters/views/select_house_type.dart';
import 'package:perfect/app/modules/filters/views/select_property_type.dart';
import 'package:perfect/app/modules/propertydetails/controllers/propertydetails_controller.dart';
import 'package:perfect/app/modules/propertydetails/views/propertydetails_view.dart';
import 'package:perfect/app/routes/app_pages.dart';
import 'package:perfect/app/utils/drop_down_multilanguage.dart';
import 'package:uuid/uuid.dart';

import '../controllers/editprofile_controller.dart';

class EditprofileView extends StatefulWidget {
  @override
  State<EditprofileView> createState() => _EditprofileViewState();

  CompanyProfile companyProfile;

  EditprofileView({required this.companyProfile});
}

class _EditprofileViewState extends State<EditprofileView> {
  final borderRadius = BorderRadius.circular(10);
  EditprofileController controller = Get.put(EditprofileController());

  final _bhkEditKey = GlobalKey<DropdownSearchState<String>>();

  final _proTypeEditKey = GlobalKey<DropdownSearchState<String>>();
  late TextEditingController priceController, keywordController, companyNameController, companyAddressController, companyEmailController, companyPhoneController,
      companyDescriptionController;

  // XFile? _pickedFile;
  // XFile? _pickedFileLogo;
  // List<XFile?> companyImages = [];
  // List<int> companyImagesIndxes = [];
  // final _pickedFileLength = List<int>.generate(20, (int index) => index, growable: false);
  //
  // bool add = false;
  //
  // bool update= false;

  //
  String? longitude;
  double? latitude;
  @override
  void initState() {
    // TODO: implement initState
    Get.put(FiltersController());
    print("Properties Types :: : ${FiltersController.to.propertyTypes}");
    super.initState();
    companyNameController = TextEditingController(text: widget.companyProfile.companyName);
    companyAddressController = TextEditingController(text: widget.companyProfile.companyAddress);
    companyEmailController = TextEditingController(text: widget.companyProfile.companyEmail);
    companyPhoneController = TextEditingController(text: widget.companyProfile.companyPhoneNumber);
    companyDescriptionController = TextEditingController(text: widget.companyProfile.companyDescription);

    Future.delayed(Duration.zero,(){
      if(widget.companyProfile.companyImages != null){
        for(int i = 0; i < widget.companyProfile.companyImages!.length; i++){
          EditprofileController.to.prices.add(widget.companyProfile.companyImages![i].price.toString());
        }
        for(int i = 0; i < widget.companyProfile.companyImages!.length; i++){
          EditprofileController.to.keywords.add(widget.companyProfile.companyImages![i].keyword.toString());
        }
      }
      print("Price::: ${EditprofileController.to.prices}");
      String s = widget.companyProfile.strHouseTypes!;
      if(s.isNotEmpty){
        List<String> result = s.split(",");
        String houseType;
        for(int i = 0; i < result.length; i++){
          houseType = result[i];
          int index = FiltersController.to.houseTypes.indexWhere((element) => element!.name == houseType);
          EditprofileController.to.selectedHouseTypeIndex.add(index);
          EditprofileController.to.selectedHouseType.add(FiltersController.to.houseTypes.elementAt(index));

          print(EditprofileController.to.selectedHouseTypeIndex);
          print(EditprofileController.to.selectedHouseType);
          print("We are here:::: $houseType");
        }
      }

      String s2 = widget.companyProfile.strPropertyTypes!;
      if(s2.isNotEmpty){
        List<String> result2 = s2.split(",");
        String propertyType;
        for(int i = 0; i < result2.length; i++){
          propertyType = result2[i];
          int index = FiltersController.to.propertyTypes.indexWhere((element) => element!.name == propertyType);
          EditprofileController.to.selectedPropertyTypeIndex.add(index);
          EditprofileController.to.selectedPropertyTypes.add(FiltersController.to.propertyTypes.elementAt(index));

          print(EditprofileController.to.selectedPropertyTypes);
          print(EditprofileController.to.selectedPropertyTypeIndex);
          print("We are here:::: $propertyType");
        }
      }
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    EditprofileController.to.selectedHouseTypeIndex.clear();
    EditprofileController.to.selectedHouseType.clear();
    EditprofileController.to.selectedPropertyTypeIndex.clear();
    EditprofileController.to.selectedPropertyTypes.clear();
  }
@override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

}
  @override
  Widget build(BuildContext context) {
    String s = widget.companyProfile.strHouseTypes!;
//Remove everything after last '.'
    var pos = s.lastIndexOf(',');
    // String result = (pos != -1)? s.substring(0, pos): s;
    // String result = s.substring(0, s.indexOf(','));
    List<String> result = s.split(",");
    print(result);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            EditprofileController.to.companyImages.clear();
            EditprofileController.to.companyImagesIndxes.clear();
            EditprofileController.to.pickedFileAdd = null;
            EditprofileController.to.pickedFileLogo = null;
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 14,
          ),
        ),
        actions: [
          DropDownMultiLanguage(),
        ],
        centerTitle: true,
        title: Image.asset(
          "assets/image/logo-white.png",
          width: 160,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 120,
              child: Stack(
                children: [
                  // Center(child: Image.asset("assets/image/add_pro_header.png")),
                  Center(
                    child: Container(
                      padding: EdgeInsets.all(5), // Border width
                      decoration: BoxDecoration(
                          color: mainColor, borderRadius: borderRadius),
                      child: ClipRRect(
                        borderRadius: borderRadius,
                        child: SizedBox.fromSize(
                          size: Size.fromRadius(44), // Image radius
                          child:   Visibility(
                            visible: EditprofileController.to.pickedFileLogo == null,
                            replacement: CircleAvatar(
                              radius: 50,
                            backgroundImage: EditprofileController.to.pickedFileLogo != null
                                ? FileImage(File(EditprofileController.to.pickedFileLogo!.path))
                                : FileImage(File("sd"))),
                          child: CachedNetworkImage(
                              imageUrl: widget.companyProfile.companyLogoUrl ?? "",
                              // progressIndicatorBuilder: (context, url, downloadProgress) =>
                              //     CircularProgressIndicator(
                              //         value: downloadProgress.progress),
                              errorWidget: (context, url, error) => Icon(
                                Icons.error,
                                size: 60,
                              ),
                            ),
                          ),
                        ),),
                    ),
                  ),
                  Positioned(
                      bottom: 20,
                      right: 0,
                      child: IconButton(
                        onPressed: () {
                         EditprofileController.to.pickImageLogo();
                        },
                        icon: Icon(
                          Icons.edit,
                          color: Colors.black,
                          size: 16,
                        ),
                      ))
                ],
              ),
            ),

            Divider(
              height: 5,
              color: Colors.black,
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 130,
                child: ListView.builder(
                        itemCount: widget.companyProfile.companyImages!.length,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              // setState(() {
                              EditprofileController.to.addButton = false;
                              EditprofileController.to.updateButton = true;
                              // });

                              // EditprofileController.to.getData(index: index, price: controller.companyDetails.first!.companyImages![index].price!.toString());
                              // WidgetsBinding.instance!.addPostFrameCallback((_){
                              _showModal(context, index, widget
                                  .companyProfile!);

                              // });
                            },
                            child: Container(
                              width: 120,
                              height: 90,
                              decoration: BoxDecoration(
                                  border: Border.all()
                              ),
                              margin: EdgeInsetsDirectional.all(2),
                              child: Column(
                                children: [
                                  CachedNetworkImage(
                                    width: 120,
                                    height: 70,
                                    fit: BoxFit.cover,
                                    imageUrl: widget.companyProfile!
                                        .companyImages![index].imageUrl ?? "",
                                    progressIndicatorBuilder: (context, url,
                                        downloadProgress) =>
                                        CircularProgressIndicator(
                                            value: downloadProgress.progress),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error, size: 60,),
                                  ),
                                  Text(widget.companyProfile
                                      .companyImages![index].keyword ?? ""),
                                  Divider(),
                                  Text("\$ ${widget.companyProfile!
                                      .companyImages![index].price
                                      .toString()}" ?? "")
                                ],
                              ),
                            ),
                          );
                        })
              ),
            ),
            // Container(
            //   child: Column(
            //     children: [
            //       Padding(
            //         padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             Text("Images",
            //                 style: TextStyle(
            //                     fontSize: 16,
            //                     color: Colors.black,
            //                     fontWeight: FontWeight.w500)),
            //           ],
            //         ),
            //       ),
            //       SizedBox(
            //         height: 10,
            //       ),
            //       SingleChildScrollView(
            //         scrollDirection: Axis.horizontal,
            //         child: Row(
            //           children: [
            //             SizedBox(
            //               width: 10,
            //             ),
            //             Photos("assets/image/prop_1.png"),
            //             SizedBox(
            //               width: 10,
            //             ),
            //             Photos("assets/image/prop_2.png"),
            //             SizedBox(
            //               width: 10,
            //             ),
            //             Photos("assets/image/prop_3.png"),
            //             SizedBox(
            //               width: 10,
            //             ),
            //             Photos("assets/image/prop_4.png"),
            //             SizedBox(
            //               width: 10,
            //             ),
            //             Photos("assets/image/prop_5.png"),
            //           ],
            //         ),
            //       )
            //     ],
            //   ),
            // ),

            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Divider(
                height: 5,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                child: Container(
                  height: 30,
                  width: size.width / 5,
                  child: OutlinedButton(
                    style: ElevatedButton.styleFrom(
                      onPrimary: Colors.white,
                      // primary:  Color(0xff00DFB6),
                      minimumSize: Size(88, 36),
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                    ),
                    onPressed: () {
                          EditprofileController.to.addButton = true;
                          EditprofileController.to.updateButton = false;
                      _showModal(context, null, null);
                    },
                    child: Text("Add",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.w500)),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                width: size.width / 1.1,
                child: OutlinedButton(
                  style: ElevatedButton.styleFrom(
                    onPrimary: Colors.white,
                    primary: Color(0xff00DFB6),
                    minimumSize: Size(88, 36),
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                  ),
                  onPressed: () {
                    //Navigator.push(context, MaterialPageRoute(builder: (context) =>EditPerpact()));
                    Get.toNamed('/halp');
                  },
                  child: Text(
                    "How to Edit Profile Videos ?",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                width: size.width / 1.1,
                child: OutlinedButton(
                  style: ElevatedButton.styleFrom(
                    onPrimary: Colors.white,
                    primary: Color(0xff00DFB6),
                    minimumSize: Size(88, 36),
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                  ),
                  onPressed: () {
                    Get.toNamed(Routes.EXTRAPAGE);
                    // Navigator.push(context, MaterialPageRoute(builder: (context) =>ExtraPage()));
                    // Get.toNamed('/contact-us');
                  },
                  child: Text(
                    "Extras",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0.0),
              child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Company Name",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  )),
            ),
            Form(
              key: EditprofileController.to.profileFormKey,
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.text,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white60),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white60),
                      ),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white60),
                      ),
                      contentPadding: EdgeInsets.only(top: 20),
                      isDense: true,
                      hintText: "Company Name",
                      hintStyle: TextStyle(color: Colors.black54, fontSize: 14),
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(top: 20),
                        // add padding to adjust icon
                        child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 12),
                            child: Image.asset(
                              "assets/image/icon_title.png",
                              width: 15,
                              height: 15,
                            )),
                      ),
                    ),
                    controller: companyNameController,
                    validator: (value) {
                      return controller.validateAllField(value!);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                    child: Divider(
                      color: Colors.black,
                      height: 5,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                    child: Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Address",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        )),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white60),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white60),
                      ),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white60),
                      ),
                      contentPadding: EdgeInsets.only(top: 20),
                      isDense: true,
                      hintText: "address",
                      hintStyle: TextStyle(color: Colors.black54, fontSize: 14),
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(top: 20),
                        // add padding to adjust icon
                        child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 12),
                            child: Image.asset(
                              "assets/image/icon_address.png",
                              width: 15,
                              height: 15,
                            )),
                      ),
                    ),
                    controller: companyAddressController,
                    onTap: () async{
                      final sessionToken = Uuid().v4();
                      final Suggestion? result = await showSearch(
                          context: context,
                          delegate: AddressSearch(sessionToken));
                      print("RESULT ::: ${result!.placeId}");
                      print("DESCRIPTION :::: ${result.description}");

                      if (result != null) {
                        var locations = await locationFromAddress(result.description);

                        setState(() {
                          companyAddressController.text = result.description;
                          longitude = locations.first.longitude.toString();
                          latitude = locations.first.latitude;
                          //   _streetNumber = placeDetails.streetNumber;
                          //   _street = placeDetails.street;
                          //   _city = placeDetails.city;
                          //   _zipCode = placeDetails.zipCode;
                        });


                        print("Length::: ${locations.length}");
                        print(locations.first.latitude);
                        print(locations.first.longitude);

                        // final placeDetails = await PlaceApiProvider(sessionToken)
                        //     .getPlaceDetailFromId(result.placeId);
                        // print(placeDetails!.results!.first.geometry!.location!.lat);

                      }
                    },

                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                    child: Divider(
                      color: Colors.black,
                      height: 5,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                    child: Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Phone Number",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        )),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white60),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white60),
                      ),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white60),
                      ),
                      contentPadding: EdgeInsets.only(top: 20),
                      isDense: true,
                      hintText: "phone number",
                      hintStyle: TextStyle(color: Colors.black54, fontSize: 14),
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(top: 20),
                        // add padding to adjust icon
                        child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 12),
                            child: Image.asset(
                              "assets/image/icon_phone.png",
                              width: 15,
                              height: 15,
                            )),
                      ),
                    ),
                    controller: companyPhoneController,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                    child: Divider(
                      color: Colors.black,
                      height: 5,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                    child: Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Email",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        )),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white60),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white60),
                      ),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white60),
                      ),
                      contentPadding: EdgeInsets.only(top: 20),
                      isDense: true,
                      hintText: "Your email",
                      hintStyle: TextStyle(color: Colors.black54, fontSize: 14),
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(top: 20),
                        // add padding to adjust icon
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 12),
                          child: Icon(
                            Icons.email,
                            size: 22,
                            color: Color(0xff00DFB6),
                          ),
                        ),
                      ),
                    ),
                    controller: companyEmailController,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                    child: Divider(
                      color: Colors.black,
                      height: 5,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => SelectHouseType(isFilter: false, ),));
                          },
                          child: Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Select House Type",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              )),
                        ),

                        SizedBox(
                          height: 5,
                        ),

                        // Text(result.toString()),
                        SizedBox(
                          height: 40,
                          child: GetX<EditprofileController>(
                            builder: (EditprofileController controller) {

                              return controller.selectedHouseType.length == 0 ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => SelectHouseType(isFilter: false, ),));

                                  },
                                    child: Text("Select...",style: TextStyle(color: Colors.black),)),
                              ) :
                              ListView.builder(
                                physics: ScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: controller.selectedHouseType.length,
                                itemBuilder: (context, index) {
                                  return  Container(
                                    padding: EdgeInsets.only(left: 6, bottom: 3, top: 3, right: 0),
                                    margin: EdgeInsets.symmetric(horizontal: 2, vertical: 5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.grey[200]),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          controller.selectedHouseType[index]!.name!,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        Container(
                                          height: 25,
                                          child: ButtonTheme(
                                            minWidth: 0,
                                            child: MaterialButton(
                                              shape: const CircleBorder(),
                                              focusColor: Colors.red[200],
                                              hoverColor: Colors.red[200],
                                              padding: EdgeInsets.all(0),
                                              onPressed: () {
                                                controller.removeHouseType(index: index, houseType: controller.selectedHouseType[index]!);
                                                // _bhkKey.currentState?.removeItem(i);
                                              },
                                              child: Icon(
                                                Icons.close_outlined,
                                                color: Colors.grey,
                                                size: 14,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },);
                            return Text(widget.companyProfile.strHouseTypes!);
                            },
                          ),),

                        SizedBox(
                          height: 20,
                        ),
                        Divider(
                          height: 1,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => SelectPropertyType(isFilter: false),));
                          },
                          child: Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Select Property Type",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              )),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          height: 40,
                          child: GetX<EditprofileController>(
                            builder: (controller) {
                              return controller.selectedPropertyTypes.length == 0 ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Select...",style: TextStyle(color: Colors.black),),
                              ) : ListView.builder(
                                physics: ScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: controller.selectedPropertyTypes.length,
                                itemBuilder: (context, index) {
                                  return  Container(
                                    padding: EdgeInsets.only(left: 6, bottom: 3, top: 3, right: 0),
                                    margin: EdgeInsets.symmetric(horizontal: 2, vertical: 5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.grey[200]),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          controller.selectedPropertyTypes[index]!.name!,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        Container(
                                          height: 25,
                                          child: ButtonTheme(
                                            minWidth: 0,
                                            child: MaterialButton(
                                              shape: const CircleBorder(),
                                              focusColor: Colors.red[200],
                                              hoverColor: Colors.red[200],
                                              padding: EdgeInsets.all(0),
                                              onPressed: () {
                                                controller.removeProperty(index: index, propertyType: controller.selectedPropertyTypes[index]!);
                                                // _bhkKey.currentState?.removeItem(i);
                                              },
                                              child: Icon(
                                                Icons.close_outlined,
                                                color: Colors.grey,
                                                size: 14,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },);
                            },
                          ),),
                        // _buildBhkTypeDropDown(),

                        Divider(
                          height: 1,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                    child: Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Company Description",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        )),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white60),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white60),
                      ),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white60),
                      ),
                      contentPadding: EdgeInsets.only(top: 20),
                      isDense: true,
                      hintText: "Description",
                      hintStyle: TextStyle(color: Colors.black54, fontSize: 14),
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(top: 20),
                        // add padding to adjust icon
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 12),
                          child: Image.asset(
                            "assets/image/icon_description.png",
                            width: 15,
                            height: 15,
                          ),
                        ),
                      ),
                    ),
                    controller: companyDescriptionController,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                    child: Divider(
                      color: Colors.black,
                      height: 5,
                    ),
                  ),
                  SizedBox(height: 10),
                  GetX<EditprofileController>(
                    builder: (controller) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 50,
                          width: size.width / 1.1,
                          child: OutlinedButton(
                            style: ElevatedButton.styleFrom(
                              onPrimary: Colors.white,
                              primary: Color(0xff00DFB6),
                              minimumSize: Size(88, 36),
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(5)),
                              ),
                            ),
                            onPressed: () {
                              // Navigator.push(context, MaterialPageRoute(builder: (context) =>Search()));
                              // Get.toNamed(Routes.SUBSCIPTION);
                              EditprofileController.to.saveCompanyProfile(companyName: companyNameController.text,
                                companyAddress: companyAddressController.text,
                                companyEmail: companyEmailController.text,
                                companyPhone: companyPhoneController.text,
                                companyDescription: companyDescriptionController.text,
                                imageLogoUrl: widget.companyProfile.companyLogoUrl!,
                                images: widget.companyProfile.companyImages!,

                              );

                            },
                            child: controller.click.value ? SizedBox(height: 12,width: 12,child: CircularProgressIndicator(color: Colors.white,))  : Text(
                              "Save",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                width: size.width / 1.1,
                child: OutlinedButton(
                  style: ElevatedButton.styleFrom(
                    onPrimary: Colors.white,
                    primary: Color(0xff00DFB6),
                    minimumSize: Size(88, 36),
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                  ),
                  onPressed: () {
                    // Navigator.push(context, MaterialPageRoute(builder: (context) =>Search()));
                    Get.toNamed(Routes.SUBSCIPTION);
                  },
                  child: Text(
                    "Go Live",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              height: 5,
              color: Colors.black,
            ),
            SizedBox(
              height: 10,
            ),


            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  void _showModal(BuildContext ctx, int? index, CompanyProfile? companyProfile) {

      showModalBottomSheet(
          context: ctx,
          isScrollControlled: true,
          builder: (context) {
            return BottomSheetContent(index: controller.addButton ? 0 : index, companyProfile: widget.companyProfile);
          });


    // builder: (_) =>  SizedBox(
    //     width: double.infinity,
    //     height: 300,
    //     child: Stack(
    //       fit: StackFit.expand,
    //       children: [
    //         CupertinoPicker(
    //           backgroundColor: Colors.white,
    //           itemExtent: 40,
    //
    //           scrollController: FixedExtentScrollController(initialItem: 2),
    //           children: [
    //             Text('within 20 miles'),
    //             Text('within 30 miles'),
    //             Text('within 40 miles'),
    //             Text('within 50 miles'),
    //             Text('within 60 miles'),
    //             Text('within 70 miles'),
    //             Text('within 80 miles'),
    //           ],
    //           onSelectedItemChanged: (value) {
    //             // setState(() {
    //             //   _selectedValue = value;
    //             // });
    //           },
    //
    //         ),
    //         PositionedDirectional(
    //             start: 0,
    //             end: 0,
    //             top: 20,
    //             child: Padding(
    //               padding: const EdgeInsets.all(8.0),
    //               child: Text("Radius", textAlign: TextAlign.center,),
    //             )),
    //         PositionedDirectional(
    //             end: 10,
    //             top: 10,
    //             child: Padding(
    //               padding: const EdgeInsets.all(0),
    //               child: TextButton(child: Text("Done", textAlign: TextAlign.end,),onPressed: (){}),
    //             )),
    //
    //       ],
    //     ),
    //   ),
  }
  Widget _buildPropertyTypeDropDown(BuildContext context) {
    return DropdownSearch<String>.multiSelection(
      key: _proTypeEditKey,

      dropdownBuilder: (context, selectedItems) {
        Widget item(String i) => Container(
              padding: EdgeInsets.only(left: 6, bottom: 3, top: 3, right: 0),
              margin: EdgeInsets.symmetric(horizontal: 2, vertical: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey[200]),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    i,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12),
                  ),
                  Container(
                    height: 25,
                    child: ButtonTheme(
                      minWidth: 0,
                      child: MaterialButton(
                        shape: const CircleBorder(),
                        focusColor: Colors.red[200],
                        hoverColor: Colors.red[200],
                        padding: EdgeInsets.all(0),
                        onPressed: () {
                          _proTypeEditKey.currentState?.removeItem(i);
                        },
                        child: Icon(
                          Icons.close_outlined,
                          color: Colors.grey,
                          size: 14,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
        return Wrap(
          children: selectedItems.map((e) => item(e)).toList(),
        );
      },

      dropdownSearchDecoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(5, 5, 0, 0),
        border: InputBorder.none,
      ),
      mode: Mode.MENU,
      showSelectedItems: true,
      showAsSuffixIcons: true,
      dropdownButtonBuilder: (_) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: const Icon(
          Icons.keyboard_arrow_down_outlined,
          size: 20,
          color: Colors.grey,
        ),
      ),
      popupBarrierColor: Colors.black12,
      items: [
        "Office Space",
        "Commercial Space",
        "Residential Properties",
        "Commercial Properties",
        "Vacant Land"
      ],
      onChanged: print,
      popupSelectionWidget: (cnt, String item, bool isSelected) {
        return isSelected
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.check_circle,
                  color: mainColor,
                ),
              )
            : Container();
      },
      // popupItemDisabled: (String s) => s.startsWith('I'),

      selectedItems: ["Office Space"],
    );
  }



    /*
    * [
    *   File(),
    *   File(),
  *     File(),
    *
    * ]
    *
    * */

  }

  // Widget _buildBhkTypeDropDown() {
  //   return DropdownSearch<String>.multiSelection(
  //     key: _bhkEditKey,
  //
  //     dropdownBuilder: (context, selectedItems) {
  //       Widget item(String i) => Container(
  //             padding: EdgeInsets.only(left: 6, bottom: 3, top: 3, right: 0),
  //             margin: EdgeInsets.symmetric(horizontal: 2, vertical: 5),
  //             decoration: BoxDecoration(
  //                 borderRadius: BorderRadius.circular(5),
  //                 color: Colors.grey[200]),
  //             child: Row(
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 Text(
  //                   i,
  //                   textAlign: TextAlign.center,
  //                   style: TextStyle(fontSize: 12),
  //                 ),
  //                 Container(
  //                   height: 25,
  //                   child: ButtonTheme(
  //                     minWidth: 0,
  //                     child: MaterialButton(
  //                       shape: const CircleBorder(),
  //                       focusColor: Colors.red[200],
  //                       hoverColor: Colors.red[200],
  //                       padding: EdgeInsets.all(0),
  //                       onPressed: () {
  //                         _bhkEditKey.currentState?.removeItem(i);
  //                       },
  //                       child: Icon(
  //                         Icons.close_outlined,
  //                         color: Colors.grey,
  //                         size: 14,
  //                       ),
  //                     ),
  //                   ),
  //                 )
  //               ],
  //             ),
  //           );
  //       return Wrap(
  //         children: selectedItems.map((e) => item(e)).toList(),
  //       );
  //     },
  //
  //     dropdownSearchDecoration: InputDecoration(
  //       contentPadding: EdgeInsets.fromLTRB(5, 5, 0, 0),
  //       border: InputBorder.none,
  //     ),
  //     mode: Mode.MENU,
  //     showSelectedItems: true,
  //     showAsSuffixIcons: true,
  //     dropdownButtonBuilder: (_) => Padding(
  //       padding: const EdgeInsets.all(8.0),
  //       child: const Icon(
  //         Icons.keyboard_arrow_down_outlined,
  //         size: 20,
  //         color: Colors.grey,
  //       ),
  //     ),
  //     popupBarrierColor: Colors.black12,
  //     items: ["1 BHK", "2 BHK", "3 BHK", '4 BHK'],
  //     onChanged: print,
  //     popupSelectionWidget: (cnt, String item, bool isSelected) {
  //       return isSelected
  //           ? Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child: Icon(
  //                 Icons.check_circle,
  //                 color: mainColor,
  //               ),
  //             )
  //           : Container();
  //     },
  //     // popupItemDisabled: (String s) => s.startsWith('I'),
  //
  //     selectedItems: ["1 BHK"],
  //   );
  // }

  Widget Photos(String image) {
    //final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(5.0, 2.0, 2.0, 0.0),
          child: Center(
            child: Container(
              //  height: size.height/8,
              //  width: size.width/5,

              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: SizedBox.fromSize(
                  size: Size.fromRadius(30), // Image radius
                  child: Image.asset(image, fit: BoxFit.cover),
                ),
              ),
              //     Image.asset(
              //   "assets/images/home.jpg",
              // ),
              // color: Colors.amber,
            ),
          ),
        ),
        Positioned(
            right: 0,
            top: 0,
            child: Image.asset("assets/image/icon_delete.png", width: 10,))
      ],
    );
  }


class BottomSheetContent extends StatefulWidget {
  // XFile? pickedFile;
  // List<XFile?> companyImages;
  // List<int> companyImagesIndxes;
  int? index;
  // bool add = false;
  CompanyProfile? companyProfile;
  // bool update= false;
  BottomSheetContent(
      {
  //       this.pickedFile,
  //       required  this.companyImages,
  //       required this.companyImagesIndxes,
  //       required this.add,
  //       required this.update,
          this.index,
         this.companyProfile,
      });


  @override
  _BottomSheetContentState createState() => _BottomSheetContentState();

}

class _BottomSheetContentState extends State<BottomSheetContent> {

  // late TextEditingController textEditingController;
  late TextEditingController priceController, keywordController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // textEditingController = TextEditingController(text: EditprofileController.to.addButton? "" :  widget.companyProfile!.companyImages![widget.index!].price.toString());
    keywordController=  TextEditingController(text:EditprofileController.to.addButton? "" : widget.companyProfile!.companyImages![widget.index!].keyword! ) ;
    priceController= TextEditingController(text: EditprofileController.to.addButton? "" : widget.companyProfile!.companyImages![widget.index!].price!.toString());

  }
  @override
  Widget build(BuildContext context) {
    print(widget.index);

        return GetBuilder<EditprofileController>(
          builder: (EditprofileController controller) {
            print(controller.companyImages.length);
            return DraggableScrollableSheet(
                initialChildSize: 0.8,
                expand: false,
                maxChildSize: 0.8,
                minChildSize: 0.5,
                builder: (context, scrollController) {
                  return Container(
                    padding: EdgeInsets.all(16),
                    // height: 250,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(controller.addButton ? "Add" : "Update"),
                              )
                            ],
                          ),
                          Form(
                              key: EditprofileController.to.profileImagesFormKey,
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /*
                            *
                          1- الحالة الاولى المستخدم لديه صورة ويريد تعديلها
                          2- الحالة الثانية لا يوجد صور
                          3 الاضافة
                          4- خلل من الانترنت في الصورة من api
                          5 - الصورة بعد التعديل واختيارها من الاستديو

                              * */
                              Center(
                                child: Visibility(
                                  visible:  controller.updateButton && controller.companyImages.length == 0,
                                  replacement: Container(
                                    width: 80,
                                    height: 80,
                                    child: Visibility(
                                      visible: controller.updateButton,
                                      replacement: Visibility(
                                        visible: controller.pickedFileAdd != null,
                                        replacement: Container(
                                          width: 80,
                                          height: 80,
                                          child: Stack(
                                            children: [
                                              Container(
                                                width: 80,
                                                height: 80,
                                                color: Colors.grey,
                                                child: IconButton(onPressed: () {
                                                  controller.pickImageAdd();
                                                }, icon: Icon(Icons.add, color: Colors.white,)),
                                              )
                                            ],
                                          ),
                                        ),
                                        child:  controller.pickedFileAdd != null ? Stack(
                                          children: [
                                            Image.file(File(controller.pickedFileAdd!.path), fit: BoxFit.cover,),
                                            IconButton(onPressed: () {
                                              controller.pickImageAdd();
                                            }, icon: Icon(Icons.add, color: Colors.white,)),
                                          ],
                                        ) : Container(),
                                      ),
                                      child: Stack(
                                        children: [
                                          // Visibility(
                                          //   visible: !companyImagesIndxes.contains(index),
                                          //   child: Container(
                                          //     width: 80,
                                          //     height: 80,
                                          //     color: Colors.red,
                                          //   ),
                                          // ),
                                          controller.companyImagesIndxes.contains(
                                              widget.index)
                                              ? Image.file(
                                            File(
                                              controller.companyImages[controller.companyImagesIndxes.indexWhere((element) => element == widget.index!)   ]!.path,),
                                            fit: BoxFit.cover,
                                            width: 80,
                                            height: 80,)
                                              : Container(),
                                          Center(child: IconButton(
                                              onPressed: () =>
                                              {
                                                print(widget.index!),
                                               controller.addButton ? controller.pickImageAdd() : controller.pickImagesCompany(index: widget.index!)
                                                // widget.function(widget.index)
                                              },
                                              icon: Icon(
                                                Icons.add, color: Colors.white,
                                                size: 40,))),
                                          // Visibility(
                                          //   visible: !controller.companyImagesIndxes
                                          //       .contains(widget.index),
                                          //   child: Container(
                                          //     width: 80,
                                          //     height: 80,
                                          //     color: Colors.grey,
                                          //     child: CachedNetworkImage(
                                          //       imageUrl: controller.companyProfile != null ? controller.companyProfile!
                                          //           .companyImages!.first
                                          //           .imageUrl! : "sdsfg",
                                          //       imageBuilder: (context,
                                          //           imageProvider) =>
                                          //           Container(
                                          //             width: 95,
                                          //             height: 95,
                                          //             decoration: BoxDecoration(
                                          //                 shape: BoxShape.circle,
                                          //                 image: DecorationImage(
                                          //                   image: imageProvider,
                                          //                   fit: BoxFit.cover,
                                          //                 )),
                                          //           ),
                                          //       placeholder: (context, url) =>
                                          //           CircularProgressIndicator(),
                                          //       errorWidget: (context, url,
                                          //           error) =>
                                          //           Stack(
                                          //             children: [
                                          //               Container(
                                          //                   width: 95,
                                          //                   height: 95,
                                          //                   decoration: BoxDecoration(
                                          //                     color: Colors
                                          //                         .deepOrangeAccent,
                                          //                     shape: BoxShape
                                          //                         .circle,
                                          //                   ),
                                          //                   child: Icon(
                                          //                     Icons.error,
                                          //                     size: 70,
                                          //                     color: Colors.white,
                                          //                   )),
                                          //               Container(
                                          //                 width: 95,
                                          //                 height: 95,
                                          //                 decoration: BoxDecoration(
                                          //                   color: Colors.black26,
                                          //                   shape: BoxShape
                                          //                       .circle,
                                          //                 ),
                                          //               ),
                                          //               Positioned(
                                          //                 top: 0,
                                          //                 bottom: 0,
                                          //                 right: 0,
                                          //                 left: 0,
                                          //                 child: IconButton(
                                          //                     onPressed: () {
                                          //                       controller.pickImagesCompany(
                                          //                           index: widget.index ?? null);
                                          //
                                          //                       // widget.function(widget.index);
                                          //                     },
                                          //                     color: Colors.white,
                                          //                     iconSize: 50,
                                          //                     icon: Icon(
                                          //                         Icons.add)),),
                                          //             ],
                                          //           ),
                                          //     ),
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      controller.pickImagesCompany(index: widget.index!);
                                      // widget.function(widget.index);
                                    },
                                    child: CachedNetworkImage(
                                      imageUrl:  widget.companyProfile!.companyImages!
                                          [widget.index!].imageUrl ?? "",
                                      imageBuilder: (context, imageProvider) {
                                        return Container(
                                            width: 95,
                                            height: 95,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.cover,
                                                )),
                                          child: IconButton(icon: Icon(Icons.add, color: Colors.white, size: 40,), onPressed: () {
                                              EditprofileController.to.pickImagesCompany(index: widget.index);
                                          },),
                                          );
                                      },
                                      placeholder: (context, url) =>
                                          CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          Stack(
                                            children: [
                                              // Container(
                                              //     width: 95,
                                              //     height: 95,
                                              //     decoration: BoxDecoration(
                                              //       color: Colors
                                              //           .deepOrangeAccent,
                                              //       shape: BoxShape.circle,
                                              //     ),
                                              //     child: Icon(
                                              //       Icons.error,
                                              //       size: 70,
                                              //       color: Colors.white,
                                              //     )),
                                              Container(
                                                width: 95,
                                                height: 95,
                                                decoration: BoxDecoration(
                                                  color: Colors.black26,
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                              Positioned(
                                                top: 0,
                                                bottom: 0,
                                                right: 0,
                                                left: 0,
                                                child: IconButton(
                                                    onPressed: () {
                                                      controller.pickImagesCompany(
                                                          index: widget.index!);
                                                      // widget.function(widget.index);
                                                    },
                                                    color: Colors.white,
                                                    iconSize: 50,
                                                    icon: Icon(Icons.add)),),
                                            ],
                                          ),
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                "Keyword",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15),
                              ),

                             // buildKeywordRow(index: widget.index!, keyword: widget.companyProfile!.companyImages![widget.index!].keyword.toString()),
                              TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  contentPadding: EdgeInsets.only(top: 20),
                                  isDense: false,
                                  hintText: "Keyword",
                                  hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.only(top: 15), // add padding to adjust icon
                                    child: Icon(
                                      Icons.text_fields,
                                      color: mainColor,
                                    ),
                                  ),
                                ),
                                controller: keywordController,
                                onSaved: (value) {
                                  print("Saved");
                                  // EditprofileController.to.keyword = value!;
                                },
                                onChanged: (value) {
                                 keywordController.text = value!;
                                  EditprofileController.to.keyword = value!;

                                },
                                validator: (value) {
                                  return EditprofileController.to.validateAllField(value!);
                                },
                              ),
                              SizedBox(height: 15),
                              Text(
                                "Price",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15),
                              ),

                              TextFormField(
                                keyboardType: TextInputType.number,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  contentPadding: EdgeInsets.only(top: 20),
                                  // add padding to adjust text
                                  // isDense: true,
                                  hintText: "Price",
                                  hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.only(top: 15), // add padding to adjust icon
                                    child: Icon(
                                      Icons.monetization_on,
                                      color: mainColor,
                                    ),
                                  ),
                                ),
                                controller:  priceController,
                                // controller:  EditprofileController.to.addButton ? EditprofileController.to.controllerAdd : EditprofileController.to.prices[index],
                                onSaved: (value) {
                                  print("we are here.... onSaved");
                                  // setState(() {
                                  // textEditingController.text = value!;
                                  // });
                                  // EditprofileController.to.prices.add(value!);
                                  // print( EditprofileController.to.prices);
                                },
                                onChanged: (value) {
                                  print("We are here");
                                  // setState(() {
                                  priceController.text = value!;
                                  EditprofileController.to.price = value!;
                                  // });

                                },
                                validator: (value) {
                                  return EditprofileController.to.validateAllField(value!);
                                },
                              ),
                              // buildPriceRow(index: widget.index!, price: widget.companyProfile!.companyImages![widget.index!].price.toString()),

                              SizedBox(height: 15),
                             buildUpdateOrAddButton(context),
                            ],
                          ))
                        ],
                      ),
                    ),
                  );
                }
            );
          },
        );

  }

  // Future<void> pickImagesCompany({ required int? index}) async {
  //   print("Null");
  //
  //   var _picked = await _picker.pickImage(source: ImageSource.gallery);
  //   if (_picked != null) {
  //     if(index != null){
  //       if (widget.companyImagesIndxes.contains(index)) {
  //         widget.companyImages.removeAt(index);
  //         widget.companyImagesIndxes.removeAt(index);
  //
  //         setState(() {});
  //
  //         widget.companyImages.add(_picked);
  //         widget.companyImagesIndxes.add(index);
  //
  //       }else{
  //
  //       }
  //
  //     }
  //   }
  //
  //
  // }

  // Widget buildPriceRow({required int index,required String price}) {
  //
  //   TextEditingController textEditingController = TextEditingController(text: EditprofileController.to.addButton? "" : price);
  //
  //   // Future.delayed(Duration.zero, () async {
  //   //   if(!EditprofileController.to.pricesIndex.contains(index)){
  //   // EditprofileController.to.pricesIndex.removeAt(index);
  //   // EditprofileController.to.prices.removeAt(index);
  //   // EditprofileController.to.prices.add(controller.text);
  //   // EditprofileController.to.pricesIndex.add(index);
  //   // }
  //   // });
  //   // WidgetsBinding.instance!.addPostFrameCallback((_){
  //
  //
  //   // EditprofileController.to.pricesIndex.add(index);
  //   // EditprofileController.to.prices.add(controller.text);
  //   // EditprofileController.to.prices.add(controller.text);
  //   //
  //   // });
  //   // EditprofileController.to.prices.add(controller.text);
  //   // EditprofileController.to.pricesIndex.add(index);
  //   //   if(EditprofileController.to.pricesIndex.contains(index)){
  //   //     EditprofileController.to.pricesIndex.removeAt(index);
  //   //     EditprofileController.to.prices.removeAt(index);
  //   //     EditprofileController.to.prices.add(controller.text);
  //   //     EditprofileController.to.pricesIndex.add(index);
  //   //   }
  //   //   prices.addIf(index == pricesIndex.elementAt(index), controller);
  //   //   pricesIndex.addIf(index == index, index);
  //   // EditprofileController.to.prices.add(controller.text);
  //   // EditprofileController.to.pricesIndex.add(index);
  //   // EditprofileController.to.prices.remove(controller.text);
  //
  //   // if(!EditprofileController.to.prices.contains(controller.text)){
  //   //   EditprofileController.to.pricesIndex.add(index);
  //   //   EditprofileController.to.prices.add(controller.text);
  //   //   print(EditprofileController.to.prices);
  //   // }
  //   // EditprofileController.to.prices.add(controller.text);
  //
  //   // print(EditprofileController.to.prices);
  //   // print(EditprofileController.to.pricesIndex);
  //
  //   return TextFormField(
  //     keyboardType: TextInputType.number,
  //     style: TextStyle(color: Colors.black),
  //     decoration: InputDecoration(
  //       enabledBorder: UnderlineInputBorder(
  //         borderSide: BorderSide(color: Colors.grey),
  //       ),
  //       focusedBorder: UnderlineInputBorder(
  //         borderSide: BorderSide(color: Colors.grey),
  //       ),
  //       border: UnderlineInputBorder(
  //         borderSide: BorderSide(color: Colors.grey),
  //       ),
  //       contentPadding: EdgeInsets.only(top: 20),
  //       // add padding to adjust text
  //       // isDense: true,
  //       hintText: "Price",
  //       hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
  //       prefixIcon: Padding(
  //         padding: EdgeInsets.only(top: 15), // add padding to adjust icon
  //         child: Icon(
  //           Icons.monetization_on,
  //           color: mainColor,
  //         ),
  //       ),
  //     ),
  //     controller:  textEditingController,
  //     // controller:  EditprofileController.to.addButton ? EditprofileController.to.controllerAdd : EditprofileController.to.prices[index],
  //     onSaved: (value) {
  //       print("we are here.... onSaved");
  //       // setState(() {
  //       // textEditingController.text = value!;
  //       // });
  //       // EditprofileController.to.prices.add(value!);
  //       // print( EditprofileController.to.prices);
  //     },
  //     onChanged: (value) {
  //       print("We are here");
  //       // setState(() {
  //       textEditingController.text = value!;
  //       EditprofileController.to.price = value!;
  //       // });
  //
  //     },
  //     validator: (value) {
  //       return EditprofileController.to.validateAllField(value!);
  //     },
  //   );
  // }

  // Widget buildKeywordRow({required int index, required String keyword}) {
  //   EditprofileController.to.keywordController.text = EditprofileController.to.addButton? "" : keyword;
  //   // TextEditingController textEditingController = TextEditingController(text: EditprofileController.to.addButton? "" : keyword);
  //
  //   return TextFormField(
  //     keyboardType: TextInputType.emailAddress,
  //     style: TextStyle(color: Colors.black),
  //     decoration: InputDecoration(
  //       enabledBorder: UnderlineInputBorder(
  //         borderSide: BorderSide(color: Colors.grey),
  //       ),
  //       focusedBorder: UnderlineInputBorder(
  //         borderSide: BorderSide(color: Colors.grey),
  //       ),
  //       border: UnderlineInputBorder(
  //         borderSide: BorderSide(color: Colors.grey),
  //       ),
  //       contentPadding: EdgeInsets.only(top: 20),
  //       isDense: false,
  //       hintText: "Keyword",
  //       hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
  //       prefixIcon: Padding(
  //         padding: EdgeInsets.only(top: 15), // add padding to adjust icon
  //         child: Icon(
  //           Icons.text_fields,
  //           color: mainColor,
  //         ),
  //       ),
  //     ),
  //     controller: EditprofileController.to.keywordController,
  //     onSaved: (value) {
  //       // EditprofileController.to.keyword = value!;
  //     },
  //     onChanged: (value) {
  //       EditprofileController.to.keywordController.text = value!;
  //       EditprofileController.to.keyword = value!;
  //
  //     },
  //     validator: (value) {
  //       return EditprofileController.to.validateAllField(value!);
  //     },
  //   );
  // }

  Widget buildUpdateOrAddButton(BuildContext context) {
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width,
      child: OutlinedButton(
        style: raisedButtonStyle,
        onPressed: () {
          // EditprofileController.to.checkRegisterForm();
          EditprofileController.to.companyImages.add(EditprofileController.to.pickedFileAdd!);
          EditprofileController.to.prices.add(priceController.text);
          EditprofileController.to.keywords.add(keywordController.text);
              print(EditprofileController.to.prices);
              print(EditprofileController.to.keywords);
          },
        child: Text('Save'),
      ),
    );
  }

}
