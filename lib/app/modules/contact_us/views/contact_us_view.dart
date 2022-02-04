import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:perfect/app/data/constants.dart';

import '../controllers/contact_us_controller.dart';

class ContactUsView extends GetView<ContactUsController> {
  final ContactUsController controller = Get.put(ContactUsController());


  Widget _buildEmailRow() {
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
        hintText: "Your Email",
        hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
        prefixIcon: Padding(
          padding: EdgeInsets.only(top: 15), // add padding to adjust icon
          child: Icon(
            Icons.mail,
            color: mainColor,
          ),
        ),
      ),
      controller: controller.emailController,
      onSaved: (value) {
        controller.email = value!;
      },
      validator: (value) {
        return controller.validateEmail(value!);
      },
    );
  }
  Widget _buildFullNameRow() {
    return TextFormField(
      keyboardType: TextInputType.text,
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
        hintText: "Your Name",
        hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
        prefixIcon: Padding(
          padding: EdgeInsets.only(top: 15), // add padding to adjust icon
          child: Icon(
            Icons.person,
            color: mainColor,
          ),
        ),
      ),
      controller: controller.nameController,
      onSaved: (value) {
        controller.name = value!;
      },
      validator: (value) {
        return controller.validateAllField(value!);
      },
    );
  }
  Widget _buildFullContactRow() {
    return TextFormField(
      keyboardType: TextInputType.multiline,
      minLines: 1,
      maxLines: 5,
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
        hintText: "Your Content",
        hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
        prefixIcon: Padding(
          padding: EdgeInsets.only(top: 15), // add padding to adjust icon
          child: Icon(
            Icons.person,
            color: mainColor,
          ),
        ),
      ),
      controller: controller.contentController,
      onSaved: (value) {
        controller.content = value!;
      },
      validator: (value) {
        return controller.validateAllField(value!);
      },
    );
  }
  Widget _buildContactButton(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: OutlinedButton(
        style: raisedButtonStyle,
        onPressed: () {
          controller.checkRegisterForm();
        },
        child: Text('Contact US'),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ContactUsView'),
        centerTitle: true,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.only(top: 70),
        child: SingleChildScrollView(
          child: Form(
            key: controller.contactFormKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Full Name",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 15),
                  ),
                  _buildFullNameRow(),
                  SizedBox(height: 15),
                  Text(
                    "Email",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 15),
                  ),
                  _buildEmailRow(),
                  SizedBox(height: 15),
                  Text(
                    "Content",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 15),
                  ),
                  _buildFullContactRow(),
                  SizedBox(height: 5),
                  _buildContactButton(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
