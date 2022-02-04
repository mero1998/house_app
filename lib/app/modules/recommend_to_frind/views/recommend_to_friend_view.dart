import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:perfect/app/data/constants.dart';

import '../controllers/recommend_to_friend_controller.dart';

class RecommendToFriendView extends GetView<RecommendToFriendController> {
  final RecommendToFriendController controller = Get.put(RecommendToFriendController());


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
        hintText: "Email of friend",
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

  Widget _buildRecommendButton(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: OutlinedButton(
        style: raisedButtonStyle,
        onPressed: () {
          controller.checkRegisterForm();
        },
        child: Text('Recommend to friend'),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recommend to friend'),
        centerTitle: true,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.only(top: 70),
        child: SingleChildScrollView(
          child: Form(
            key: controller.recommendFormKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [


                  Text(
                    "Email of friend",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 15),
                  ),
                  _buildEmailRow(),
                  SizedBox(height: 5),
                  _buildRecommendButton(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
