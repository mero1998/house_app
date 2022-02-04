import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:perfect/app/data/constants.dart';
import 'package:perfect/app/modules/extra_page/extra_page_view.dart';
import 'package:perfect/app/modules/filters/controllers/filters_controller.dart';
import 'package:perfect/app/modules/filters/views/select_house_type.dart';
import 'package:perfect/app/routes/app_pages.dart';
import 'package:perfect/app/utils/drop_down_multilanguage.dart';

import '../controllers/editprofile_controller.dart';

class EditprofileView extends StatefulWidget {
  @override
  State<EditprofileView> createState() => _EditprofileViewState();
}

class _EditprofileViewState extends State<EditprofileView> {
  final borderRadius = BorderRadius.circular(10);
  EditprofileController controller = Get.put(EditprofileController());
  final _bhkEditKey = GlobalKey<DropdownSearchState<String>>();

  final _proTypeEditKey = GlobalKey<DropdownSearchState<String>>();

  XFile? _pickedFile;

  ImagePicker _picker = ImagePicker();

  bool add = false;

  bool update= false;

  Widget _buildPriceRow() {
    return TextFormField(
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
        isDense: true,
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
      controller: controller.priceController,
      onSaved: (value) {
        controller.price = value!;
      },
      validator: (value) {
        return controller.validateAllField(value!);
      },
    );
  }

  Widget _buildKeywordRow() {
    return TextFormField(
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
        isDense: true,
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
      controller: controller.keywordController,
      onSaved: (value) {
        controller.keyword = value!;
      },
      validator: (value) {
        return controller.validateAllField(value!);
      },
    );
  }

  Widget _buildUpdateOrAddButton(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: OutlinedButton(
        style: raisedButtonStyle,
        onPressed: () {
          controller.checkRegisterForm();
        },
        child: Text('Save'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
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
                          child: Image.asset('assets/image/add_logo.png',
                              fit: BoxFit.cover),
                        ),),
                    ),
                  ),
                  Positioned(
                      bottom: 20,
                      right: 0,
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.edit,
                          color: Colors.white,
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
                    itemCount: 10,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemBuilder: (context, index){
                      return InkWell(
                        onTap: () {
                          setState(() {
                            add = false;
                            update = true;
                          });
                          _showModal(context);
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
                                imageUrl: "https://media.istockphoto.com/photos/dream-home-luxury-house-success-suburban-house-picture-id1281554848?b=1&k=20&m=1281554848&s=170667a&w=0&h=s7X81b-3hfEGTYVkFKDOG7ZDySs57Tpw_WAETXi5xnQ=",
                                progressIndicatorBuilder: (context, url, downloadProgress) =>
                                    CircularProgressIndicator(value: downloadProgress.progress),
                                errorWidget: (context, url, error) => Icon(Icons.error, size: 60,),
                              ),
                              Text("Word"),
                             Divider(),
                              Text("\$55")
                            ],
                          ),
                        ),
                      );
                    }),
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
                        setState(() {
                          add = true;
                          update = false;
                        });
                      _showModal(context);
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>ExtraPage()));
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SelectHouseType(),));
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
        SizedBox(
          height: 40,
          child: GetX<FiltersController>(
            builder: (controller) {
              return controller.selectedHouseType.length == 0 ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Select...",style: TextStyle(color: Colors.black),),
              ) : ListView.builder(
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
                          controller.selectedHouseType[index],
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
                                controller.removeHouseType(index: index, houseType: controller.selectedHouseType[index]);
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
                  // _buildPropertyTypeDropDown(context),
                  // SizedBox(
                  //   height: 20,
                  // ),
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SelectHouseType(),));
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
                    child: GetX<FiltersController>(
                      builder: (controller) {
                        return controller.selectedProperty.length == 0 ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Select...",style: TextStyle(color: Colors.black),),
                        ) : ListView.builder(
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
                                    controller.selectedHouseType[index],
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
                                          controller.removeHouseType(index: index, houseType: controller.selectedHouseType[index]);
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
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
              child: Divider(
                color: Colors.black,
                height: 5,
              ),
            ),
            SizedBox(height: 10),
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
                    "Save",
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

  void _showModal(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      isScrollControlled: true,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.5,
          expand: false,
          maxChildSize: 0.8,
          minChildSize: 0.5,

          builder: (context, scrollController) {
            return  Container(
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
                          child: Text(add ?  "Add" : "Update"),
                        )
                      ],
                    ),
                    Form(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Visibility(
                            visible: _pickedFile == null,
                            replacement: CircleAvatar(
                                radius: 50,
                                backgroundImage: _pickedFile != null
                                    ? FileImage(File(_pickedFile!.path))
                                    : FileImage(File("sd"))),
                            child: InkWell(
                              onTap: () {
                                pickImage();
                              },
                              child: CachedNetworkImage(
                                imageUrl: "http://via.placeholder.com/350x150",
                                imageBuilder: (context, imageProvider) => Container(
                                  width: 95,
                                  height: 95,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      )),
                                ),
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(),
                                errorWidget: (context, url, error) => Stack(
                                  children: [
                                    Container(
                                        width: 95,
                                        height: 95,
                                        decoration: BoxDecoration(
                                          color: Colors.deepOrangeAccent,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.person,
                                          size: 70,
                                          color: Colors.white,
                                        )),
                                    Container(
                                      width: 95,
                                      height: 95,
                                      decoration: BoxDecoration(
                                        color:Colors.black26,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    Positioned(
                                      top: 0,
                                      bottom: 0,
                                      right: 0,
                                      left: 0,
                                      child: IconButton(onPressed: (){pickImage();}, color: Colors.white, iconSize:50,icon: Icon(Icons.add)),),
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
                        _buildKeywordRow(),

                        SizedBox(height: 15),
                        Text(
                          "Price",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 15),
                        ),
                        _buildPriceRow(),

                        SizedBox(height: 15),
                        _buildUpdateOrAddButton(context),
                      ],
                    ))
                  ],
                ),
              ),
            );
          }
        );
      },
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
    );
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

  Future<void> pickImage() async {
    _pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (_pickedFile != null) {
      // setState(() {});
    }
  }

  Widget _buildBhkTypeDropDown() {
    return DropdownSearch<String>.multiSelection(
      key: _bhkEditKey,

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
                          _bhkEditKey.currentState?.removeItem(i);
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
      items: ["1 BHK", "2 BHK", "3 BHK", '4 BHK'],
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

      selectedItems: ["1 BHK"],
    );
  }

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
}
