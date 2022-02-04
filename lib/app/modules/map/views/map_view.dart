import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:perfect/app/data/constants.dart';
import 'package:perfect/app/modules/filterresults/views/filterresults_view.dart';
import 'package:perfect/app/modules/search/views/search_view.dart';
import 'package:perfect/app/routes/app_pages.dart';
import 'package:perfect/app/utils/drop_down_multilanguage.dart';

import '../controllers/map_controller.dart';

class MapView extends GetView<MapController> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
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
        centerTitle: true,
        title: Text(
          "Search Results",
          style: TextStyle(
              fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: PopupMenuButton<int>(
              onCanceled: () => {print("Push")},
              // color: Colors.amber,
              child: Icon(
                Icons.menu,
                size: 20.0,
                color: Colors.white,
              ),
              itemBuilder: (context) => [
                //  PopupMenuDivider(),
                PopupMenuItem(child: Text('Search'),
                  onTap: () {
                     Get.toNamed(Routes.FILTERRESULTS);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => FilterresultsView(),));
                  },),
              ],
            ),
          ),
          DropDownMultiLanguage()
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: size.height / 14,
              width: size.width / 1,
              decoration: BoxDecoration(color: Colors.black54),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Newcastle Upon Tyne",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Up To \$12,000,Atleast 3 Bedooms",
                          style: TextStyle(color: Colors.white, fontSize: 13),
                        ),
                        Text(
                          "40 Results",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            // SizedBox(
            //   height: 10,
            // ),
            // Container(
            //   height: size.height / 14,
            //   width: size.width / 1,
            //   decoration: BoxDecoration(color: Colors.white),
            //   child: Padding(
            //     padding: const EdgeInsets.symmetric(horizontal: 20),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       children: [
            //         Row(
            //           children: [
            //             Image.asset(
            //               "assets/image/icon_filter.png",
            //               width: 15,
            //             ),
            //             SizedBox(
            //               width: 5,
            //             ),
            //             Text("Sort")
            //           ],
            //         ),
            //         Row(
            //           children: [
            //             Image.asset(
            //               "assets/image/icon_save_search.png",
            //               width: 15,
            //             ),
            //             SizedBox(
            //               width: 5,
            //             ),
            //             Text("Save Search")
            //           ],
            //         ),
            //         Row(
            //           children: [
            //             Image.asset(
            //               "assets/image/icon_pin.png",
            //               width: 15,
            //             ),
            //             SizedBox(
            //               width: 5,
            //             ),
            //             Text("Map")
            //           ],
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            Container(
              height: MediaQuery.of(context).size.height/1.8,
              child: Stack(

                children: [
                  // Text("Missions High School",style: TextStyle(color: Colors.black),),
                  Image.asset(
                    "assets/image/map_image.png",
                    fit: BoxFit.fill,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height/1.8,
                  ),
                  Center(
                    child: Image.asset(
                      "assets/image/icon_map_pin.png",
                      width: 35,
                    ),
                  )
                ],
              ),
            ),

            SizedBox(
              height: 10,
            ),
            // Container(
            //   height: 100,
            //   decoration: BoxDecoration(color: Colors.white),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceAround,
            //     children: [
            //       Row(
            //         children: [
            //           ClipRRect(
            //             borderRadius: BorderRadius.circular(10),
            //             child: SizedBox.fromSize(
            //               size: Size.fromRadius(35), // Image radius
            //               child: Image.asset("assets/image/home.jpg",
            //                   fit: BoxFit.cover),
            //             ),
            //           ),
            //           SizedBox(
            //             width: 10,
            //           ),
            //           Column(
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               Row(
            //                 children: [
            //
            //                   SizedBox(
            //                     width: 5,
            //                   ),
            //                   Text(
            //                     '\$ 9800.00',
            //                     style: TextStyle(
            //                         fontSize: 16, color: Colors.black),
            //                   )
            //                 ],
            //               ),
            //               SizedBox(
            //                 height: 5,
            //               ),
            //               Row(
            //                 children: [
            //                   Image.asset(
            //                       "assets/image/icon_address.png",
            //                       width: 15
            //                   ),
            //                   SizedBox(
            //                     width: 10,
            //                   ),
            //                   Text(
            //                     "78587 Newcastle, \n Calabasas, California",
            //                     style: TextStyle(
            //                         fontSize: 13, color:  Colors.black54),
            //                   )
            //                 ],
            //               ),
            //
            //               Row(
            //                 children: [
            //                   Image.asset("assets/image/icon_distance.png", width: 18,),
            //                   SizedBox(
            //                     width: 10,
            //                   ),
            //                   Text(
            //                     "10.0 Miles",
            //                     style: TextStyle(
            //                         fontSize: 13, color: Colors.black54),
            //                   )
            //                 ],
            //               ),
            //             ],
            //           ),
            //         ],
            //       ),
            //       ClipRRect(
            //         borderRadius: BorderRadius.circular(2),
            //         child: SizedBox.fromSize(
            //           size: Size.fromRadius(20), // Image radius
            //           child: Image.asset("assets/image/add_logo.png",
            //               fit: BoxFit.cover),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
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
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(Icons.location_city, color: mainColor,),
                  Text("Company ABC", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),),
                ],
              ),
            )

          ],
        ),
      ),
    );
  }

  Widget Photos() {
    // final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.fromLTRB(1.0, 1.0, 1.0, 0.0),
      child: Center(
        child: Container(
          // height: size.height / 9,
          // width: size.width / 5,

          child: ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: SizedBox.fromSize(
              size: Size.fromRadius(48), // Image radius
              child: Image.asset("assets/image/home.jpg", fit: BoxFit.cover),
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

  Widget SearchResults(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.fromLTRB(10.0, 0.0, 15.0, 0.0),
      width: size.width / 1,
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Icon(
                Icons.home,
                color: Color(0xff00DFB6),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "ABC Company Name",
                style: TextStyle(fontSize: 18, color: Color(0XFF636363)),
              )
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.home,
                color: Color(0xff00DFB6),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "Califormia",
                style: TextStyle(fontSize: 18, color: Color(0XFF636363)),
              )
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.add_location,
                color: Color(0xff00DFB6),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "78785 Newcastle, Calabasas,",
                style: TextStyle(fontSize: 18, color: Color(0XFF636363)),
              )
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.phone,
                color: Color(0xff00DFB6),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "8000919369",
                style: TextStyle(fontSize: 18, color: Color(0XFF636363)),
              )
            ],
          ),
        ],
      ),
    );
  }
}
