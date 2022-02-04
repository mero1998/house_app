import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:perfect/app/data/constants.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  final SplashController controller = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          child: Image.asset(
            "assets/image/background.png",
            fit: BoxFit.cover,
          ),
        ),
        Center(
            child: Image.asset(
          "assets/image/logo-white.png",
          width: 180,
        )),
      ],
    );
  }
}
