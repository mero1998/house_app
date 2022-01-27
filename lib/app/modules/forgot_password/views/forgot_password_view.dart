import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:perfect/app/data/constants.dart';
import 'package:perfect/app/routes/app_pages.dart';

import '../controllers/forgot_password_controller.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {

  final ForgotPasswordController controller = Get.put(ForgotPasswordController());

  Widget _buildEmailRow() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(color: Colors.white),
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
        hintText: "Your Email",
        hintStyle: TextStyle(color: Colors.white60, fontSize: 12),
        prefixIcon: Padding(
          padding: EdgeInsets.only(top: 15), // add padding to adjust icon
          child: Icon(
            Icons.person,
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

  Widget _buildSendButton(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: OutlinedButton(
        style: raisedButtonStyle,
        onPressed: () {
          controller.checkForm();
        },
        child: Text('Send'),
      ),
    );
  }

  Widget _buildBackBtn(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        FlatButton(
          onPressed: () {
            // controller.loginFormKey.currentState;
            Get.back();
          },
          child: RichText(
            text: TextSpan(children: [
              TextSpan(
                text: "Back to Sign in",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: MediaQuery.of(context).size.height / 65,
                  fontWeight: FontWeight.w600,
                ),
              ),

            ]),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                "assets/image/login_bg.png",
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: controller.forgotPasswordFormKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                              child: Image.asset(
                                "assets/image/logo.png",
                                width: 120,
                              )),
                          SizedBox(height: 35),
                          Text(
                            "Email",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 15),
                          ),
                          _buildEmailRow(),
                          SizedBox(height: 15),

                          _buildSendButton(context),
                          Align(
                              alignment: FractionalOffset.bottomCenter,
                              child: _buildBackBtn(context)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}