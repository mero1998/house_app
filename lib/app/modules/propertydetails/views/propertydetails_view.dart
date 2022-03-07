import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:perfect/app/data/constants.dart';
import 'package:perfect/app/modules/editprofile/views/editprofile_view.dart';
import 'package:perfect/app/modules/extra_page/extra_screen_controller.dart';
import 'package:perfect/app/modules/propertydetails/views/street_view.dart';
import 'package:perfect/app/routes/app_pages.dart';
import 'package:perfect/app/utils/drop_down_multilanguage.dart';
import 'package:perfect/preferences/user_preferences.dart';
import 'package:share_plus/share_plus.dart';

import '../controllers/propertydetails_controller.dart';

class PropertydetailsView extends StatefulWidget {

  int companyId;

  PropertydetailsView({required this.companyId});


  static late CameraPosition myLocation;

  @override
  State<PropertydetailsView> createState() => _PropertydetailsViewState();
}

class _PropertydetailsViewState extends State<PropertydetailsView> {
  Completer<GoogleMapController> _controller = Completer();



  String dropdownValue = 'One';

  String value = 'One';

  String dropdown = 'One';

  String companyAddress = "";


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    PropertydetailsController.to.companyDetails.clear();
  }

  @override
  Widget build(BuildContext context) {
  print("1234442403 From Build");
    Get.put(PropertydetailsController());
    PropertydetailsController.to.getCompanyDetails(companyId: widget.companyId);
  print("1234442403 From Build");

  print(widget.companyId);
    // myLocation = CameraPosition(
    //   target: LatLng(controller.companyDetails.first!.companyLatitude!.toDouble(), controller.companyDetails.first!.companyLongitude!.toDouble()),
    //   zoom: 14.4746,
    // );
    PropertydetailsView.myLocation = CameraPosition(
    target: LatLng(31.376438, 34.318592),
    zoom: 14.4746,
    );

    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        leading: IconButton(
          onPressed: (){
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 14,
          ),
        ),
        centerTitle: true,
        title: Image.asset(
          "assets/image/logo-white.png",
          width: 160,
        ),
        actions: [
          Visibility(
            visible: UserPreferences().id == widget.companyId,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 40,
                // width: size.width / 10,
                alignment: Alignment.centerRight,
                child: OutlinedButton(
                  style: ElevatedButton.styleFrom(
                    onPrimary: Colors.white,
                    alignment: Alignment.centerRight,
                    primary: Color(0xff00DFB6),
                    minimumSize: Size(40, 36),
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                  ),
                  onPressed: () {
                    // var map = PropertydetailsController.to.companyDetails.map((element) => element);
                    // Get.toNamed(Routes.EDITPROFILE , arguments: map);
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => EditprofileView(companyProfile: PropertydetailsController.to.companyDetails.first!,)));
                  },
                  child: Icon(
                   Icons.edit,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
          DropDownMultiLanguage()
        ],
      ),
      body: GetX<PropertydetailsController>(
        builder: (controller) {
          // controller.isLoading.isTrue ? companyAddress = controller.companyDetails.where((e) => e!.companyId == widget.companyId).first!.companyAddress ?? "" : "" ;

          return controller.isLoading.isTrue ? Center(child: CircularProgressIndicator(),)
              :    SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  // height: size.height/3.5,
                  width: size.width / 1,
                  child: Column(
                    children: [
                      Center(
                        child: Container(
                          height: size.height / 3.5,
                          width: size.width / 1.1,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              topLeft: Radius.circular(10),
                            ), // Image border
                            child:  CachedNetworkImage(
                              // width: MediaQuery.of(context).size.width / 6 - 8.8,

                              fit: BoxFit.cover,
                              imageUrl: controller.companyDetails.where((e) => e!.companyId == widget.companyId).first!.companyLogoUrl ?? "",
                              progressIndicatorBuilder: (context, url, downloadProgress) =>
                                  CircularProgressIndicator(),
                              errorWidget: (context, url, error) => Icon(Icons.error, size: 60,),
                            ),
                          ),
                          //     Image.asset(
                          //   "assets/images/home.jpg",
                          // ),
                          // color: Colors.amber,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10.0, 0.0, 15.0, 0.0),
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/image/icon_mask.png",
                              width: 14,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              controller.companyDetails.where((e) => e!.companyId == widget.companyId).first!.companyName ?? "N/A",
                              style: TextStyle(
                                  color: mainColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ),

                    
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10.0, 0.0, 15.0, 0.0),
                              child: Row(
                                children: [
                                  Image.asset(
                                    "assets/image/icon_address.png",
                                    width: 15,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width / 3,
                                    child: Text(
                                      controller.companyDetails.where((e) => e!.companyId == widget.companyId).first!.companyAddress ?? "N/A",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black45),
                                      // softWrap: true,
                                      overflow: TextOverflow.clip,

                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                // Text(
                                //   "\$ 9000.00",
                                //   style: TextStyle(
                                //       fontSize: 18, fontWeight: FontWeight.w600),
                                // ),
                                // SizedBox(width: 10,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Spacer(),
                                    // SizedBox(width: MediaQuery.of(context).size.width / 2.8,),
                                    IconButton(
                                      padding: EdgeInsets.zero,
                                      icon: Icon(controller.isFav.value ? Icons.favorite :  Icons.favorite_border, color: controller.isFav.value ? Colors.red : Colors.grey,),
                                      onPressed: () {
                                        print(controller.companyDetails.first!.favorite);
                                        // PropertydetailsController.to.isFav.value = PropertydetailsController.to.companyDetails.first!.favorite!;
                                        // setState(() {
                                        //   controller.companyDetails.first!.favorite = !controller.companyDetails.first!.favorite!;
                                        //
                                        // });
                                         controller.isFav.value = !controller.isFav.value;
                                         print("From View ${controller.isFav.value}");
                                       int value = controller.isFav.value ? 1 : 0;
                                        PropertydetailsController.to.addFavoriteProperty(value: value, companyId: widget.companyId);
                                      },
                                    ),

                                    IconButton(
                                      padding: EdgeInsets.zero,
                                      icon: Icon(Icons.warning, color: controller.isReport.value? Colors.yellowAccent : Colors.grey,),
                                      color: controller.isReport.value? Colors.yellowAccent : Colors.grey,
                                      onPressed: (){
                                        controller.isReport.value = !controller.isReport.value;
                                        print(controller.isReport.value);
                                        int value = controller.isReport.value ? 1 : 0;
                                        PropertydetailsController.to.addReport(value: value, companyId: widget.companyId);
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.share),
                                      color: Colors.black26,
                                      onPressed: () {

                                        Share.share("Company Profile");
                                      },
                                    ),
                                  ],
                                ),

                              ],
                            ),
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Divider(
                  height: 10,
                  color: Colors.black,
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        PropertydetailsController.to.makeCall();
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 15),
                        color: mainColor,
                        width: MediaQuery.of(context).size.width / 2.2,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15.0),
                            child: Text(
                              "CALL",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                     onTap: () {
                       PropertydetailsController.to.sendEamil();

                     },
                      child: Container(
                        margin: EdgeInsets.only(right: 15),
                        color: Colors.black12,
                        width: MediaQuery.of(context).size.width / 2.2,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15.0),
                            child: Text(
                              "EMAIL",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Divider(
                  height: 5,
                  color: Colors.black,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10.0, 0.0, 15.0, 0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Photos",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500)),
                            Icon(
                              Icons.keyboard_arrow_down,
                              size: 20,
                              color: mainColor,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 140,
                        margin: EdgeInsetsDirectional.all(10),
                        child: Align(
                          alignment: AlignmentDirectional.topStart,
                          child: ListView.builder(
                              itemCount: controller.companyDetails.where((e) => e!.companyId == widget.companyId).first!.companyImages!.length,
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemBuilder: (context, index){
                                return Container(
                                  // height: 90,

                                  decoration: BoxDecoration(
                                      border: Border.all()
                                  ),
                                  margin: EdgeInsetsDirectional.all(2),
                                  child: Column(

                                    children: [
                                      CachedNetworkImage(
                                        width: 70,
                                        height: 70,
                                        fit: BoxFit.cover,
                                        imageUrl: controller.companyDetails.where((e) => e!.companyId == widget.companyId).first!.companyImages![index].imageUrl ?? "",
                                        progressIndicatorBuilder: (context, url, downloadProgress) =>
                                            CircularProgressIndicator(value: downloadProgress.progress),
                                        errorWidget: (context, url, error) => Icon(Icons.error, size: 60,),
                                      ),
                                      Text(controller.companyDetails.where((e) => e!.companyId == widget.companyId).first!.companyImages![index].keyword ?? ""),
                                      Divider(),
                                      Text("\$ ${controller.companyDetails.where((e) => e!.companyId == widget.companyId).first!.companyImages![index].price.toString()}" ?? "")
                                    ],
                                  ),
                                );
                              }),
                        ),
                      )
                    ],
                  ),
                ),
                Divider(
                  height: 5,
                  color: Colors.black,
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 0.0, 15.0, 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Full Description",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w500)),
                      Icon(
                        Icons.keyboard_arrow_down,
                        size: 20,
                        color: mainColor,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 5.0, 15.0, 15.0),
                  child: Text(
                        controller.companyDetails.where((e) => e!.companyId == widget.companyId).first!.companyDescription ?? "",
                      style: TextStyle(
                          color: Colors.black45, wordSpacing: 3, fontSize: 13), textAlign: TextAlign.start,),
                ),
                SizedBox(
                  height: 15,
                ),
                Center(
                  child: Container(
                    height: size.height / 3.5,
                    width: size.width / 1.1,
                    decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10),
                      ), // Image border
                      child: GoogleMap(
                        myLocationEnabled: true,
                        // mapType: MapType.satellite,
                        markers: controller.allMarkers,
                        // polylines: {
                        //   if (_info != null)
                        //     Polyline(
                        //       polylineId: const PolylineId('overview_polyline'),
                        //       color: const Color(0xFF027A8A),
                        //       width: 5,
                        //       points: _info!.polylinePoints
                        //           .map((e) => LatLng(e.latitude, e.longitude))
                        //           .toList(),
                        //     ),
                        // },
                        // onTap: (argument) {
                        //   changeMarkerTap(argument.latitude, argument.longitude);
                        // },
                        onCameraMove: (position) {
                          // Logger().d(position.target.longitude);
                          // appControler.latMap.value = position.target.latitude;
                          // appControler.longMap.value = position.target.longitude;
                          // appControler.loadAddress.value = true;
                        },
                        onCameraIdle: () async {
                          // await LocationHelper().getPlaceName(
                          //     appControler.latMap.value,
                          //     appControler.longMap.value);
                          // appControler.loadAddress.value = false;
                        },
                        initialCameraPosition: PropertydetailsView.myLocation,
                        onMapCreated: (GoogleMapController controller) {
                          _controller.complete(controller);
                        },
                      ),
                    ),
                    //     Image.asset(
                    //   "assets/images/home.jpg",
                    // ),
                    // color: Colors.amber,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  height: 5,
                  color: Colors.black,
                ),

                // Padding(
                //   padding: const EdgeInsets.fromLTRB(10.0, 15.0, 15.0, 0.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Text("Video Tour",
                //           style: TextStyle(
                //               fontSize: 16,
                //               color: Colors.black,
                //               fontWeight: FontWeight.w500)),
                //       IconButton(
                //         onPressed: () {
                //           Get.toNamed(Routes.HALP);
                //         },
                //         icon: Icon(Icons.keyboard_arrow_right),
                //       )
                //     ],
                //   ),
                // ),
                // SizedBox(
                //   height: 10,
                // ),
                // Divider(
                //   height: 5,
                //   color: Colors.black,
                // ),
                //
                // Padding(
                //   padding: const EdgeInsets.fromLTRB(10.0, 15.0, 15.0, 0.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Text("Map View",
                //           style: TextStyle(
                //               fontSize: 16,
                //               color: Colors.black,
                //               fontWeight: FontWeight.w500)),
                //       IconButton(
                //         onPressed: () {
                //           Get.toNamed(Routes.HALP);
                //         },
                //         icon: Icon(Icons.keyboard_arrow_right),
                //       )
                //     ],
                //   ),
                // ),
                // SizedBox(
                //   height: 10,
                // ),
                // Divider(
                //   height: 5,
                //   color: Colors.black,
                // ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 15.0, 15.0, 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Street View",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w500)),

                      IconButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => StreetView(),));
                          // Get.toNamed(Routes.HALP);
                        },
                        icon: Icon(Icons.keyboard_arrow_right),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          );
        },

      ),
    );
  }

  Widget Photos(String image) {
    //final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.fromLTRB(2.0, 2.0, 2.0, 0.0),
      child: Center(
        child: Container(
          //  height: size.height/8,
          //  width: size.width/5,

          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: SizedBox.fromSize(
              size: Size.fromRadius(35), // Image radius
              child: Image.asset(image, fit: BoxFit.cover),
            ),
          ),
          //     Image.asset(
          //   "assets/images/home.jpg",
          // ),
          // color: Colors.amber,
        ),
      ),
    );
  }
}
