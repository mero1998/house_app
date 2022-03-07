import 'package:flutter/material.dart';
class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Privacy Policy"),
        centerTitle: true,
        backgroundColor: Colors.white,
      elevation: 0,
      ),
      body: Container(
        child: Text(":::::::"),
      ),
    );
  }
}
