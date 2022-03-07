import 'dart:io' show Platform;
import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';



class PurchaseApi{

  static Future<List<Offering>> fetchOffers() async{

    try{
      final offering = await Purchases.getOfferings();
      final current = offering.current;
      return current == null ? [] : [current];

    } on PlatformException catch(e){
      return [];
    }

  }
  Future<void> initPlatformState() async {
    await Purchases.setDebugLogsEnabled(true);

    if (Platform.isAndroid) {
      await Purchases.setup("goog_VjFUrrTKllJrKhSNbwpZtGUjCCS");
    } else if (Platform.isIOS) {
      await Purchases.setup("goog_VjFUrrTKllJrKhSNbwpZtGUjCCS");

      // // OR: if building for Amazon, be sure to follow the installation instructions then:
      // await Purchases.setup("public_amazon_sdk_key",);
    }

  }
}
