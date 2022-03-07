import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:perfect/app/modules/terms_of_use/controller/terms_of_use_controller.dart';
class TermsOfUseView extends StatelessWidget {
  const TermsOfUseView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Terms of Use", style: TextStyle(color: Colors.black),),
        centerTitle: true,
        backgroundColor: Colors.white,
      elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: GetX<TermsOfUseController>(
        builder: (TermsOfUseController controller) {
          return controller.termsOfUseList.length == 0 ?
          Center(child: CircularProgressIndicator(),)  :
          Container(
            padding: EdgeInsets.all(16),

            child: Text(controller.termsOfUseList.first.text ?? ""),
          );
        },
      ),
    );
  }
}
