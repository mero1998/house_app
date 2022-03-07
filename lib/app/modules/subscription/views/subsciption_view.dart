import 'dart:async';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:perfect/app/api/purchase_api.dart';
import 'package:perfect/app/data/constants.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import '../controllers/subsciption_controller.dart';
import 'dart:io';

final String testID = "test";
class SubsciptionView extends StatefulWidget {
  @override
  State<SubsciptionView> createState() => _SubsciptionViewState();
}

class _SubsciptionViewState extends State<SubsciptionView> {

  static const _productIds = {'plan3', 'plan1', 'plan2'};

// InAppPurchase _iap = InAppPurchase.instance;
// bool _available = false;
// List<PurchaseDetails> _products = [];
// List<PurchaseDetails> _purchases = [];
// StreamSubscription? _subscription;
// int _credits =0;


  InAppPurchaseConnection _connection = InAppPurchaseConnection.instance;
 late StreamSubscription<List<PurchaseDetails>> _subscription;
  List<ProductDetails> _products = [];

@override
  void initState() {
    // TODO: implement initState
  Stream<List<PurchaseDetails>>  purchaseUpdated =
      InAppPurchaseConnection.instance.purchaseUpdatedStream;
  _subscription = purchaseUpdated.listen((purchaseDetailsList) {
    _listenToPurchaseUpdated(purchaseDetailsList);
  }, onDone: () {
    _subscription.cancel();
  }, onError: (error) {
    print("ERORRRR::: ${error}");
    // handle error here.
  });
  initStoreInfo();

    super.initState();
  }
  initStoreInfo() async {
      final bool available = await InAppPurchaseConnection.instance.isAvailable();
      if (!available) {
        print("not availbale:::");
        await _connection.isAvailable();
        // The store cannot be reached or accessed. Update the UI accordingly.
      }

      print(available);
    ProductDetailsResponse productDetailResponse =
    await _connection.queryProductDetails(_productIds.toSet());
      print("Product Details: :: ${productDetailResponse.productDetails}");
      print("Error::; ${productDetailResponse.error}");
    if (productDetailResponse.error == null) {
      setState(() {
        _products = productDetailResponse.productDetails;
        print(" notFoundIDs:::  ${productDetailResponse.notFoundIDs}");
        print(_products);
      });
    }
  }
  _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        // show progress bar or something
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          // show error message or failure icon
        } else if (purchaseDetails.status == PurchaseStatus.purchased) {
          // show success message and deliver the product.
        }
      }
    });
  }
  _buyProduct() {
  print(_products.length);
    final PurchaseParam purchaseParam =
    PurchaseParam(productDetails: _products[0]);
    _connection.buyConsumable(purchaseParam: purchaseParam);
}
  @override
  void dispose() {
    // TODO: implement dispose
    _subscription!.cancel();
    super.dispose();
  }

// _initialze() async{
//   _available = await _iap.isAvailable();
//   await _getProduct();
//   await _getPastPurcheses();
// }
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
        child: SingleChildScrollView(
          child: Column(
            children:[
              Stack(
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
]
          ),
        )
      ),
    );
  }

  Widget _buildContinueButton(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: OutlinedButton(
        style: raisedButtonStyle,
        onPressed: () {
          _buyProduct();
          //controller.checkLoginForm();
        },
        child: Text('Continue'),
      ),
    );
  }


  Future fetchOffers()async{

  final offering = await PurchaseApi.fetchOffers();

  if(offering.isEmpty){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar
      (content: Text("No Plans Found") ));
  }else{

    final pakages = offering
        .map((offer) => offer.availablePackages)
        .expand((pair) => pair)
        .toList();


    showBottomSheet(
        context: context,
        builder: (context){
          return Container(
            child: Column(
              children: [
                Text(pakages.first.product.title),
                Text(pakages.first.product.description),

              ],
            ),
          );
        });
  }


}
}
