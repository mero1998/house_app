import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:perfect/app/data/constants.dart';
import 'package:perfect/app/modules/forgot_password/controllers/forgot_password_controller.dart';


class ResetPassword extends StatelessWidget {

  final ForgotPasswordController controller = Get.put(ForgotPasswordController());

  Widget _buildOtpRow() {
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
        hintText: "OTP",
        hintStyle: TextStyle(color: Colors.white60, fontSize: 12),
        prefixIcon: Padding(
          padding: EdgeInsets.only(top: 15), // add padding to adjust icon
          child: Icon(
            Icons.person,
            color: mainColor,
          ),
        ),
      ),
      controller: controller.otpController,
      onSaved: (value) {
        controller.otp = value!;
      },
      validator: (value) {
          return controller.validateAllField(value!);
      },
    );
  }
  Widget _buildPasswordRow() {
    return TextFormField(
      obscureText: true,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
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

       return   controller.validatePassword(value!);
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
                color: Colors.white),
          ),
          SizedBox(height: 5),
          Text(
            "\u2022  Number",
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w300,
                color: Colors.white),
          ),
          SizedBox(height: 5),
          Text(
            "\u2022  10 Characters or more",
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w300,
                color: Colors.white),
          ),
        ],
      ),
    );
  }
  Widget _buildConfPasswordRow() {
    return TextFormField(
      obscureText: true,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        contentPadding: EdgeInsets.only(top: 20),
        // add padding to adjust text
        isDense: true,
        hintText: "Password confirmation",
        hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
        prefixIcon: Padding(
          padding: EdgeInsets.only(top: 15), // add padding to adjust icon
          child: Icon(
            Icons.vpn_key_rounded,
            color: mainColor,
          ),
        ),
      ),
      controller: controller.confPasswordConroller,
      onSaved: (value) {
        controller.confPassword = value!;
      },
      validator: (value) {
          return controller.validateConfPassword(value!);

      },
    );
  }

  Widget _buildSendButton(BuildContext context) {
    return GetX<ForgotPasswordController>(
      builder: (val) {
        return  Container(
          width: MediaQuery.of(context).size.width,
          child: OutlinedButton(
            style: raisedButtonStyle,
            onPressed: () {
              controller.checkFormReset();
            },
            child: val.click.value ? SizedBox(height: 12,width: 12, child: CircularProgressIndicator(color: Colors.white))  : Text('Send'),
          ),
        );
      },
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
                    key: controller.resetPasswordFormKey,
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
                            "OTP",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 15),
                          ),
                          _buildOtpRow(),
                          Text(
                            "Password",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 15),
                          ),
                          _buildPasswordRow(),
                          SizedBox(height: 10,),
                          _passwordSuggestion(),
                          SizedBox(height: 10,),

                          Text(
                            "Password confirmation",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 15),
                          ),
                          _buildConfPasswordRow(),
                          SizedBox(height: 15),

                          _buildSendButton(context),
                          Align(
                              alignment: FractionalOffset.bottomCenter,
                              // child: _buildBackBtn(context)),
                          )],
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
