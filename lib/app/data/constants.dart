import 'package:flutter/material.dart';
import 'package:get/get.dart';

const mainColor = Color(0xff00DFB6);
const backgroundColor = Color(0xff666666);

const apiUrl = "http://projects.softechplanet.com/delivery/bapi/";
const propertyImageUrl = "https://projects.softechplanet.com/property/upload/property/";


 showErrorDialog(String mgs, String type) {
  Get.snackbar(
    type,
    mgs,
    colorText: Colors.white,
    backgroundColor: Colors.black45,
    snackPosition: SnackPosition.BOTTOM,
  );
}



  InputDecoration getEditStyle(String hint, IconData iconData){
  return InputDecoration(
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.black45),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.black45),
    ),
    border: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.black45),
    ),
    contentPadding: EdgeInsets.only(top: 20),
    isDense: true,
    hintText: hint,
    hintStyle: TextStyle(color: Colors.black45, fontSize: 12),
    prefixIcon: Padding(
      padding: EdgeInsets.only(top: 15), // add padding to adjust icon
      child: Icon(
        iconData,
        color: Color(0xff73B828),
      ),
    ),
  );
}

Widget getTitleStyle(String text){
  return Text(
    "$text",
    style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w600,
        fontSize: 14),
  );
}

Widget getHeadingStyle(String text){
  return Text(
    "$text",
    style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w600,
        fontSize: 12),
  );
}

final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
  onPrimary: Colors.white,
  primary: mainColor,
  minimumSize: Size(88, 36),
  padding: EdgeInsets.symmetric(horizontal: 16),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(5)),
  ),
);



final ButtonStyle? outlineButtonStyle = OutlinedButton.styleFrom(
  primary: mainColor,
  minimumSize: Size(88, 36),
  padding: EdgeInsets.symmetric(horizontal: 16),
  side: BorderSide(color: mainColor),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(2),
    ),
  ),
);

final ButtonStyle flatButtonStyle = TextButton.styleFrom(
  primary: Colors.black87,
  minimumSize: Size(88, 36),
  padding: EdgeInsets.symmetric(horizontal: 16.0),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(2.0)),
  ),
);