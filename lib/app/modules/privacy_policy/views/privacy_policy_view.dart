import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:perfect/app/modules/privacy_policy/controller/privacy_policy_controller.dart';
class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Privacy Policy",style: TextStyle(color: Colors.black),),
        centerTitle: true,
        backgroundColor: Colors.white,
      elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: GetX<PrivacyPolicyController>(
        builder: (PrivacyPolicyController controller) {
          return controller.privacyPolicyList.length == 0 ? 
          Center(child: CircularProgressIndicator(),)  :   Container(
            padding: EdgeInsets.all(16),
            child: Text(controller.privacyPolicyList.first.text ?? ""),
          );
        },
      ),
    );
  }
}
