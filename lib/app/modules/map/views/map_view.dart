import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:perfect/app/data/constants.dart';
import 'package:perfect/app/models/search_result.dart';
import 'package:perfect/app/modules/filterresults/controllers/filterresults_controller.dart';
import 'package:perfect/app/modules/filterresults/views/filterresults_view.dart';
import 'package:perfect/app/modules/filters/controllers/filters_controller.dart';
import 'package:perfect/app/modules/search/views/search_view.dart';
import 'package:perfect/app/routes/app_pages.dart';
import 'package:perfect/app/utils/drop_down_multilanguage.dart';

import '../controllers/map_controller.dart';

class MapView extends StatefulWidget {

  List<FilterResult?> filterSearch;

  MapView({required this.filterSearch});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  Set<Marker> allMarkers = <Marker>{};

  Completer<GoogleMapController> _controller = Completer();

 late CameraPosition? myLocation;
  int filterResultIndex = -1;
 int companyId = -1;

 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      companyId = widget.filterSearch.first!.companyId!;
    });
    myLocation = CameraPosition
      (target: LatLng(widget.filterSearch.first!.companyLatitude!.toDouble() , widget.filterSearch.first!.companyLongitude!.toDouble()));
  for(int i = 0; i < widget.filterSearch.length; i++){
    allMarkers.add(
      Marker(markerId: MarkerId(widget.filterSearch[i]!.companyId.toString()),
      onTap: () {
        setState(() {
          companyId = widget.filterSearch.first!.companyId!;
          if(widget.filterSearch[i]!.companyId != null){
            companyId = widget.filterSearch[i]!.companyId!;
          }
        });
      },
      position: LatLng(widget.filterSearch.first!.companyLatitude!.toDouble() , widget.filterSearch.first!.companyLongitude!.toDouble())
      ),
    );
  }

 }
 @override
  Widget build(BuildContext context) {

print(companyId);
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
              height: size.height / 7,
              width: size.width / 1,
              decoration: BoxDecoration(color: Colors.black54),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Address : ${FiltersController.to.address}",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      "Selected property type : ${FiltersController.to.selectedProperty.map((element) => element.name)}",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      "Selected house type :  ${FiltersController.to.selectedHouseType.map((element) => element.name)}",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "radius : ${FiltersController.to.radius}",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                        Text(
                          "${FilterresultsController.to.propertiesFilter!.length} Results",
                          style: TextStyle(color: Colors.white, fontSize: 13),
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
              child: GoogleMap(
                myLocationEnabled: true,
                // mapType: MapType.satellite,
                markers: allMarkers,
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
                initialCameraPosition: myLocation!,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
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
                itemCount: widget.filterSearch.firstWhere((element) => element!.companyId == companyId)!.companyImages!.length,
                  // itemCount: widget.filterSearch.firstWhere((element) => element.companyId == companyId).companyImages!.length,
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
                            // imageUrl: widget.filterSearch.firstWhere((element) => element.data.filterResult.ficompanyId == companyId).companyImages![index].imageUrl ?? "",
                           imageUrl: "",
                            progressIndicatorBuilder: (context, url, downloadProgress) =>
                                CircularProgressIndicator(value: downloadProgress.progress),
                            errorWidget: (context, url, error) => Icon(Icons.error, size: 60,),
                          ),
                          Text(widget.filterSearch.firstWhere((element) => element!.companyId == companyId)!.companyImages![index].keyword ?? "N/A"),
                          Divider(),
                          Text("\$ ${widget.filterSearch.firstWhere((element) => element!.companyId == companyId)!.companyImages![index].price ?? "N/A"}")
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
                  Text(widget.filterSearch.firstWhere((element) => element!.companyId == companyId)!.companyName ?? "N/A", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),),
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
