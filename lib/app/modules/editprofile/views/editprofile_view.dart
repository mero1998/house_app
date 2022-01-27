import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:perfect/app/data/constants.dart';
import 'package:perfect/app/routes/app_pages.dart';

import '../controllers/editprofile_controller.dart';

class EditprofileView extends GetView<EditprofileController> {
  final borderRadius = BorderRadius.circular(10); // Image border
  final _bhkEditKey = GlobalKey<DropdownSearchState<String>>();
  final _proTypeEditKey = GlobalKey<DropdownSearchState<String>>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 14,
          ),
        ),
        centerTitle: true,
        title: Image.asset(
          "assets/image/header_img.png",
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
                  Center(child: Image.asset("assets/image/add_pro_header.png")),
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
                        ),
                      ),
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
            Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Images",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Photos("assets/image/prop_1.png"),
                        SizedBox(
                          width: 10,
                        ),
                        Photos("assets/image/prop_2.png"),
                        SizedBox(
                          width: 10,
                        ),
                        Photos("assets/image/prop_3.png"),
                        SizedBox(
                          width: 10,
                        ),
                        Photos("assets/image/prop_4.png"),
                        SizedBox(
                          width: 10,
                        ),
                        Photos("assets/image/prop_5.png"),
                      ],
                    ),
                  )
                ],
              ),
            ),

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
                    onPressed: () {},
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
              padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
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
                children: [
                  Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Select Property Type",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      )),
                  _buildPropertyTypeDropDown(context),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Column(
                children: [
                  Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Select Property Type",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      )),
                  _buildBhkTypeDropDown(),
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

            SizedBox(height: 10),
          ],
        ),
      ),
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
