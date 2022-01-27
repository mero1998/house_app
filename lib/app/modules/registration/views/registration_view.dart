import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:perfect/app/data/constants.dart';
import 'package:perfect/app/routes/app_pages.dart';

import '../controllers/registration_controller.dart';

class RegistrationView extends GetView<RegistrationController> {
  final RegistrationController controller = Get.put(RegistrationController());

  Widget _buildPasswordRow() {
    return TextFormField(
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
        hintText: "Your Password",
        hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
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

  Widget _passwordSuggestion() {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "\u2022 Uppercase Letter",
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w300,
                color: Colors.black45),
          ),
          SizedBox(height: 5),
          Text(
            "\u2022  Number",
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w300,
                color: Colors.black45),
          ),
          SizedBox(height: 5),
          Text(
            "\u2022  10 Characters or more",
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w300,
                color: Colors.black45),
          ),
        ],
      ),
    );
  }

  Widget _buildSignUpButton(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: OutlinedButton(
        style: raisedButtonStyle,
        onPressed: () {
          controller.checkRegisterForm();
        },
        child: Text('Create an account'),
      ),
    );
  }

  Widget _buildLoginBtn(BuildContext context) {
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
                text: "Already have an account? ",
                style: TextStyle(
                  color: Colors.black45,
                  fontSize: MediaQuery.of(context).size.height / 65,
                  fontWeight: FontWeight.w400,
                ),
              ),
              TextSpan(
                text: 'Sign in',
                style: TextStyle(
                  color: Colors.black,
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

  Widget _buildJobType(BuildContext context) {
    return Container(
      child: Obx(() {
        return Row(
          children: [
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: <Widget>[
                Theme(
                  data: Theme.of(context).copyWith(
                      unselectedWidgetColor: Colors.black,
                      disabledColor: Colors.black),
                  child: Radio(
                    value: 0,
                    groupValue: controller.jobType.value,
                    activeColor: Colors.black,
                    onChanged: (val) {
                      controller.setJobTypeRadio(val);
                    },
                  ),
                ),
                Text(
                  "Guest",
                  style: TextStyle(color: Colors.black54, fontSize: 12),
                ),
                Theme(
                  data: Theme.of(context).copyWith(
                      unselectedWidgetColor: Colors.black,
                      disabledColor: Colors.black),
                  child: Radio(
                    value: 1,
                    groupValue: controller.jobType.value,
                    activeColor: Colors.black,
                    onChanged: (val) {
                      controller.setJobTypeRadio(val);
                    },
                  ),
                ),
                Text(
                  "Company",
                  style: TextStyle(color: Colors.black54, fontSize: 12),
                ),
              ],
            )
          ],
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: controller.registerFormKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                          child: Image.asset(
                        "assets/image/register_icon.png",
                        width: 120,
                      )),
                      SizedBox(height: 25),
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
                        "Job As a",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 15),
                      ),
                      _buildJobType(context),
                      SizedBox(height: 15),
                      Text(
                        "User Name/Email",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 15),
                      ),
                      _buildEmailRow(),
                      SizedBox(height: 15),
                      Text(
                        "Password",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 15),
                      ),
                      _buildPasswordRow(),
                      SizedBox(height: 5),
                      _passwordSuggestion(),
                      SizedBox(height: 10),
                      _buildSignUpButton(context),
                      Align(
                          alignment: FractionalOffset.bottomCenter,
                          child: _buildLoginBtn(context)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
