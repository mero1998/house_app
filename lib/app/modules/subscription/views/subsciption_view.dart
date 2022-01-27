import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:perfect/app/data/constants.dart';

import '../controllers/subsciption_controller.dart';

class SubsciptionView extends GetView<SubsciptionController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        centerTitle: true,
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
        title: Text(
          "Subscription",
          style: TextStyle(
              color: Colors.white,
              letterSpacing: 0.5,
              fontSize: 16,
              fontWeight: FontWeight.w500),
        ),
      ),
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      SizedBox(
                          height: 30
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          Text(
                            "Pricing",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: mainColor),
                          ),
                          Text(
                            " Plans",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          )
                        ],
                      ),
                      SizedBox(
                          height: 15
                      ),
                      Text(
                        "Choose a plan that works best for you \n and your team.", textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                      SizedBox(
                          height: 25
                      ),
                      Image.asset("assets/image/plan_1.png"),
                      Image.asset("assets/image/plan_2.png"),

                      Image.asset("assets/image/plan_3.png"),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: _buildContinueButton(context),
                      )
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildContinueButton(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: OutlinedButton(
        style: raisedButtonStyle,
        onPressed: () {
          //controller.checkLoginForm();
        },
        child: Text('Continue'),
      ),
    );
  }

}
