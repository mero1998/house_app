import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:perfect/app/data/constants.dart';
import 'package:perfect/app/routes/app_pages.dart';
import 'package:perfect/app/utils/drop_down_multilanguage.dart';

import '../controllers/propertydetails_controller.dart';

class PropertydetailsView extends GetView<PropertydetailsController> {
  PropertydetailsController controller = Get.put(PropertydetailsController());
  String dropdownValue = 'One';
  String value = 'One';
  String dropdown = 'One';

  @override
  Widget build(BuildContext context) {
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
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              height: 40,
              width: size.width / 6,
              child: OutlinedButton(
                style: ElevatedButton.styleFrom(
                  onPrimary: Colors.white,
                  primary: Color(0xff00DFB6),
                  minimumSize: Size(88, 36),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                ),
                onPressed: () {
                  Get.toNamed(Routes.EDITPROFILE);
                  //Navigator.push(context, MaterialPageRoute(builder: (context) => Search()));
                },
                child: Text(
                  "Edit",
                  style: TextStyle(fontSize: 13),
                ),
              ),
            ),
          ),
          DropDownMultiLanguage()
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
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
                        child: SizedBox.fromSize(
                          size: Size.fromRadius(48), // Image radius
                          child: Image.asset("assets/image/home.jpg",
                              fit: BoxFit.cover),
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
                          "Apartment",
                          style: TextStyle(
                              color: mainColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        )
                      ],
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
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Image.asset(
                                  "assets/image/icon_heart.png",
                                  width: 20,
                                )),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Icon(
                                Icons.warning,
                                color: Colors.black26,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Icon(
                                Icons.share,
                                color: Colors.black26,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
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
                        Text(
                          "78785 Newcastle, Calabasas,Cailfornia",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.black45),
                        )
                      ],
                    ),
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
                Container(
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
                Container(
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
                 SizedBox(
                   height: 130,
                   child: ListView.builder(
                     itemCount: 10,
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
                                 width: MediaQuery.of(context).size.width / 5 - 10,
                                 height: 70,
                                 fit: BoxFit.cover,
                                 imageUrl: "https://media.istockphoto.com/photos/dream-home-luxury-house-success-suburban-house-picture-id1281554848?b=1&k=20&m=1281554848&s=170667a&w=0&h=s7X81b-3hfEGTYVkFKDOG7ZDySs57Tpw_WAETXi5xnQ=",
                                 progressIndicatorBuilder: (context, url, downloadProgress) =>
                                     CircularProgressIndicator(value: downloadProgress.progress),
                                 errorWidget: (context, url, error) => Icon(Icons.error, size: 60,),
                               ),
                               Text("Word"),
                               Divider(),
                               Text("\$55")
                             ],
                           ),
                         );
                       }),
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
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quam ultricies lacus vulputate at posuere velit nulla ut. Elementum accumsan vitae ut aliquam. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quam ultricies lacus vulputate at posuere velit nulla ut. Elementum accumsan vitae ut aliquam.",
                  style: TextStyle(
                      color: Colors.black45, wordSpacing: 3, fontSize: 13)),
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
                  child: SizedBox.fromSize(
                    size: Size.fromRadius(48), // Image radius
                    child: Image.asset("assets/image/img_map.png",
                        fit: BoxFit.cover),
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
                      Get.toNamed(Routes.HALP);
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
