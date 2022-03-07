import 'package:flutter/material.dart';
import 'package:flutter_google_street_view/flutter_google_street_view.dart';

class StreetView extends StatelessWidget {
  StreetViewController? streetViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FlutterGoogleStreetView(
            initPos: LatLng(40.6928271, -74.1851906),
            onStreetViewCreated: (StreetViewController controller) async {
              //save controller for late using
              streetViewController = controller;
              //change position by controller
              controller.setPosition(position: LatLng(40.6928271, -74.1851906));
            }
        ),
      ),
    );
  }
}
