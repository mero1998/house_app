import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:perfect/app/data/constants.dart';
import 'package:perfect/app/models/user.dart';
import 'package:perfect/app/routes/app_pages.dart';
import 'package:perfect/preferences/user_preferences.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  final LoginController controller = Get.put(LoginController());

  Widget _buildPasswordRow() {
    return TextFormField(
      obscureText: true,
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
        // add padding to adjust text
        isDense: true,
        hintText: "Your Password",
        hintStyle: TextStyle(color: Colors.white60, fontSize: 12),
        prefixIcon: Padding(
          padding: EdgeInsets.only(top: 15), // add padding to adjust icon
          child: Icon(
            Icons.vpn_key_rounded,
            color: mainColor,
          ),
        ),
      ),
      controller: controller.passwordController,
      onSaved: (value) {
        controller.password = value!;
      },
      validator: (value) {
        return controller.validatePassword(value!);
      },
    );
  }

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

  Widget _buildForgotButton(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.centerRight,
      child: TextButton(
        style: flatButtonStyle,
        onPressed: () {
          Get.toNamed(Routes.FORGOT_PASSWORD);
        },
        child: Text(
          'Forgot Password ?',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
        ),
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return GetX<LoginController>(
      builder: (val) {
        return Container(
          width: MediaQuery.of(context).size.width,
          child: OutlinedButton(
            style: raisedButtonStyle,
            onPressed: () async {
              if(controller.checkLoginForm()){
                User? user = await  controller.doLogin();
                if(user != null){
                  UserPreferences().save(user!);
                }
              }


            },
            child: val.click.value ? SizedBox(height: 12,width: 12,child: CircularProgressIndicator(color: Colors.white,))  : Text('Sign In'),
          ),
        );
      },
    );
  }

  Widget _buildSignUpBtn(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        FlatButton(
          onPressed: () {
            // controller.loginFormKey.currentState;
            Get.toNamed(Routes.REGISTRATION);
          },
          child: RichText(
            text: TextSpan(children: [
              TextSpan(
                text: "Don't have an account? ",
                style: TextStyle(
                  color: Colors.white60,
                  fontSize: MediaQuery.of(context).size.height / 65,
                  fontWeight: FontWeight.w400,
                ),
              ),
              TextSpan(
                text: 'Sign Up',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: MediaQuery.of(context).size.height / 65,
                  fontWeight: FontWeight.bold,
                ),
              )
            ]),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
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
                    key: controller.loginFormKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                              child: Image.asset(
                            "assets/image/logo-white.png",
                            width: 200,
                          )),
                          SizedBox(height: 35),
                          Text(
                            "User Name/Email",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 15),
                          ),
                          _buildEmailRow(),
                          SizedBox(height: 15),
                          Text(
                            "Password",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 15),
                          ),
                          _buildPasswordRow(),
                          SizedBox(height: 10),
                          _buildForgotButton(context),
                          _buildLoginButton(context),
                          Align(
                              alignment: FractionalOffset.bottomCenter,
                              child: _buildSignUpBtn(context)),
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
