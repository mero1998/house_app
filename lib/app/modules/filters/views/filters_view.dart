import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:perfect/app/data/address_search.dart';
import 'package:perfect/app/data/constants.dart';
import 'package:perfect/app/data/place_service.dart';
import 'package:perfect/app/modules/contact_us/views/contact_us_view.dart';
import 'package:perfect/app/modules/filterresults/controllers/filterresults_controller.dart';
import 'package:perfect/app/modules/filters/views/select_house_type.dart';
import 'package:perfect/app/modules/filters/views/select_keyword.dart';
import 'package:perfect/app/modules/filters/views/select_property_type.dart';
import 'package:perfect/app/modules/propertydetails/views/propertydetails_view.dart';
import 'package:perfect/app/modules/recommend_to_frind/views/recommend_to_friend_view.dart';
import 'package:perfect/app/routes/app_pages.dart';
import 'package:perfect/app/utils/drop_down_multilanguage.dart';
import 'package:perfect/preferences/user_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'package:geocoding/geocoding.dart';
import '../controllers/filters_controller.dart';
class FiltersView extends StatefulWidget {
  @override
  State<FiltersView> createState() => _FiltersViewState();
}

class _FiltersViewState extends State<FiltersView> {
  final _propTypeKey = GlobalKey<DropdownSearchState<String>>();

  final _houseTypeKey = GlobalKey<DropdownSearchState<String>>();

  final _bhkKey = GlobalKey<DropdownSearchState<String>>();

  final _distanceKey = GlobalKey<DropdownSearchState<String>>();

  final _selectKeywordKey = GlobalKey<DropdownSearchState<String>>();
  TextEditingController searchController = TextEditingController();

String? longitude;
double? latitude;
 final List<String> radiusList = [
   //  'within 20 miles',
   // 'within 30 miles',
   //  'within 40 miles',
   //  'within 50 miles',
   //  'within 60 miles',
   //  'within 70 miles',
   // 'within 80 miles',
   '20',
   '30',
   '40',
   '50',
   '60',
  ];
  String selectItem = "";
 Widget selectedRadius = Text("");
  int radius  = 0;

 late FixedExtentScrollController firstController;

  String _streetNumber = '';
  String _street = '';
  String _city = '';
  String _zipCode = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.put(FiltersController());
    Get.put(FilterresultsController());
    firstController = FixedExtentScrollController(initialItem: 0);

  }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title:  Text(
          "Search Filters",
          style: TextStyle(
              color: Colors.white,
              fontSize: 16, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        leading:  IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: 14,
            )),
        actions: [


          Padding(
            padding: const EdgeInsets.only(top:8, bottom: 8),
            child: Container(
              height: 40,
              // width: size.width / 6,
              child: OutlinedButton(
                  style: ElevatedButton.styleFrom(
                    onPrimary: Colors.white,
                    primary: Color(0xff00DFB6),
                    minimumSize: Size(40, 36),
                    padding: EdgeInsets.symmetric(horizontal: 2),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                  ),
                  onPressed: () {
                    // Get.toNamed('/map');
                    //Navigator.push(context, MaterialPageRoute(builder: (context) => Search()));
                  },
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
                      PopupMenuItem(child: Text('Contact'), onTap: () {
                        Get.toNamed("/contact-us");
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ContactUsView(),));
                      },),
                      PopupMenuDivider(),
                      PopupMenuItem(
                              enabled: UserPreferences().type == "company",
                          child: GestureDetector(
                            child: Text('My Profile'),
                            onTap: () {
                              // Get.toNamed('/editprofile');
                              Navigator.push(context, MaterialPageRoute(builder: (context) => PropertydetailsView(companyId: UserPreferences().id),));

                            },
                          )),
                      PopupMenuDivider(),
                      PopupMenuItem(
                        child: Text('Recommend to a friend'), onTap: () {
                        Get.toNamed("/recommend-to-friend");
                        Navigator.push(context, MaterialPageRoute(builder: (context) => RecommendToFriendView(),));
                      },),
                      PopupMenuDivider(),

                      PopupMenuItem(child: GestureDetector(
                          onTap: () => Get.toNamed(Routes.TERMSOFUSE),
                          child: Text('Terms of use'))),
                      PopupMenuDivider(),
                      PopupMenuItem(child: GestureDetector(
                          onTap: () => Get.toNamed(Routes.PRIVACYPOLICY),
                          child: Text('Privacy Policy'))),
                      PopupMenuItem(
                          child: InkWell(
                            child: Text('How to work'),
                            onTap: () {
                              Get.toNamed('/halp');
                            },
                          )),
                    ],
                  )
              ),
            ),
          ),
          DropDownMultiLanguage(),

        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [


                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Color(0XFFE7E7E7),
                            border: Border.all(color: Colors.white10)),
                        child: TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white60),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white60),
                            ),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white60),
                            ),
                            // border: OutlineInputBorder(),
                            hintText: " Search area City, Town",
                            hintStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
                            suffixIcon: Align(
                              widthFactor: 1.0,
                              heightFactor: 1.0,
                              child: Icon(
                                Icons.search,
                              ),
                            ),
                          ),
                        onTap:() async{
                          final sessionToken = Uuid().v4();
                          final Suggestion? result = await showSearch(
                              context: context,
                              delegate: AddressSearch(sessionToken));
                          print("RESULT ::: ${result!.placeId}");
                          print("DESCRIPTION :::: ${result.description}");

                          if (result != null) {
                            var locations = await locationFromAddress(result.description);
                             FiltersController.to.address.value = result.description;
                            setState(() {
                              searchController.text = result.description;
                              longitude = locations.first.longitude.toString();
                              latitude = locations.first.latitude;
                              //   _streetNumber = placeDetails.streetNumber;
                              //   _street = placeDetails.street;
                              //   _city = placeDetails.city;
                              //   _zipCode = placeDetails.zipCode;
                            });

                            print("Length::: ${locations.length}");
                            print(locations.first.latitude);
                            print(locations.first.longitude);

                            // final placeDetails = await PlaceApiProvider(sessionToken)
                            //     .getPlaceDetailFromId(result.placeId);
                            // print(placeDetails!.results!.first.geometry!.location!.lat);

                          }
                          },
                        ),
                      ),
                    ),
                    // ListView.builder(
                    //   physics: NeverScrollableScrollPhysics(),
                    //   shrinkWrap: true,
                    //   itemCount: _placeList.length,
                    //   itemBuilder: (context, index) {
                    //     return ListTile(
                    //       title: Text(_placeList[index]["description"]),
                    //     );
                    //   },
                    // )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Divider(
                  height: 5,
                  color: Colors.black,
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: (){
                          // Get.toNamed(Routes.SELECT_PROPERTY_TYEP);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SelectPropertyType(isFilter: true,),));
                        },
                        child: Text(
                          "Select Property Type",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        height: 40,
                        child: GetX<FiltersController>(
                          builder: (controller) {
                            return controller.selectedProperty.length == 0 ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(onTap: (){
                                // Get.toNamed(Routes.SELECT_PROPERTY_TYEP);
                                Navigator.push(context, MaterialPageRoute(builder: (context) => SelectPropertyType(isFilter: true,),));
                              }, child: Text("Select...",style: TextStyle(color: Colors.black),)),
                            ) : ListView.builder(
                              physics: ScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: controller.selectedProperty.length,
                              itemBuilder: (context, index) {
                              return  Container(
                                padding: EdgeInsets.only(left: 6, bottom: 3, top: 3, right: 0),
                                margin: EdgeInsets.symmetric(horizontal: 2, vertical: 5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.grey[200]),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                       controller.selectedProperty[index].name! ,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Container(
                                      height: 25,
                                      child: ButtonTheme(
                                        minWidth: 0,
                                        child: MaterialButton(
                                          shape: const CircleBorder(),
                                          focusColor: Colors.red[200],
                                          hoverColor: Colors.red[200],
                                          padding: EdgeInsets.all(0),
                                          onPressed: () {
                                            controller.removeProperty(index: index, propertyType: controller.selectedProperty[index]);
                                            // _bhkKey.currentState?.removeItem(i);
                                          },
                                          child: Icon(
                                            Icons.close_outlined,
                                            color: Colors.grey,
                                            size: 14,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },);
                          },
                        ),
                      ),
                      // Text(selectPropertyType),
                      // _buildPropertyTypeDropDown(context),
                      Divider(
                        height: 1,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      InkWell(
                        onTap: (){
                          // Get.toNamed(Routes.SELECT_HOUSE_TYEP);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SelectHouseType(isFilter: true),));
                        },
                        child: Text(
                          "Select House Type",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        height: 40,
                        child: GetX<FiltersController>(
                          builder: (controller) {
                            return controller.selectedHouseType.length == 0 ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(onTap: (){
                                // Get.toNamed(Routes.SELECT_HOUSE_TYEP);
                                Navigator.push(context, MaterialPageRoute(builder: (context) => SelectHouseType(isFilter: true,),));
                              },child: Text("Select...",style: TextStyle(color: Colors.black),)),
                            ) : ListView.builder(
                              physics: ScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: controller.selectedHouseType.length,
                              itemBuilder: (context, index) {
                                return  Container(
                                  padding: EdgeInsets.only(left: 6, bottom: 3, top: 3, right: 0),
                                  margin: EdgeInsets.symmetric(horizontal: 2, vertical: 5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.grey[200]),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        controller.selectedHouseType[index].name!,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      Container(
                                        height: 25,
                                        child: ButtonTheme(
                                          minWidth: 0,
                                          child: MaterialButton(
                                            shape: const CircleBorder(),
                                            focusColor: Colors.red[200],
                                            hoverColor: Colors.red[200],
                                            padding: EdgeInsets.all(0),
                                            onPressed: () {
                                              controller.removeHouseType(index: index, houseType: controller.selectedHouseType[index]);
                                              // _bhkKey.currentState?.removeItem(i);
                                            },
                                            child: Icon(
                                              Icons.close_outlined,
                                              color: Colors.grey,
                                              size: 14,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },);
                          },
                        ),
                      ),
                      // _buildHouseTypeDropDown(),
                      Divider(
                        height: 1,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 15),
                      // Text("Select BHK",
                      //     style: TextStyle(
                      //         fontSize: 15, fontWeight: FontWeight.w600)),
                      // SizedBox(height: 5),
                      // _buildBhkTypeDropDown(),
                      // Divider(
                      //   height: 1,
                      //   color: Colors.grey,
                      // ),
                      // SizedBox(height: 15),
                      InkWell(
                        onTap: () {
                          _showPicker(context);
                        },
                        child: Text("Select Distance Radius",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w600)),
                      ),
                      SizedBox(height: 5),
                      Visibility(
                        visible: radius != 0,
                        replacement: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(onTap: (){
                            _showPicker(context);
                          },child: Text("Select...",style: TextStyle(color: Colors.black),)),
                        ) ,
                        child: Container(
                          padding: EdgeInsets.only(left: 6, bottom: 3, top: 3, right: 0),
                          margin: EdgeInsets.symmetric(horizontal: 2, vertical: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.grey[200]),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [

                              Text(
                                "Within $selectItem Miles",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 12),
                              ),
                              Container(
                                height: 25,
                                child: ButtonTheme(
                                  minWidth: 0,
                                  child: MaterialButton(
                                    shape: const CircleBorder(),
                                    focusColor: Colors.red[200],
                                    hoverColor: Colors.red[200],
                                    padding: EdgeInsets.all(0),
                                    onPressed: () {
                                      // controller.removeKeyword(index: index, keyword: controller.selectedKeyword[index]);
                                      // _bhkKey.currentState?.removeItem(i);
                                    },
                                    child: Icon(
                                      Icons.close_outlined,
                                      color: Colors.grey,
                                      size: 14,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10),

                      // _buildDistanceTypeDropDown(),
                      Divider(
                        height: 1,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 15),
                      InkWell(
                        onTap: (){
                          Get.toNamed(Routes.SELECT_KEYWORD);
                        },
                        child: Text("Select Keyword",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w600)),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        height: 40,
                        child: GetX<FiltersController>(
                          builder: (controller) {
                            return controller.selectedKeyword.length == 0 ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(onTap: (){
                                Get.toNamed(Routes.SELECT_KEYWORD);
                                // Navigator.push(context, MaterialPageRoute(builder: (context) => SelectPropertyType(),));
                              },child: Text("Select...",style: TextStyle(color: Colors.black),)),
                            ) : ListView.builder(
                              physics: ScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: controller.selectedKeyword.length,
                              itemBuilder: (context, index) {
                                return  Container(
                                  padding: EdgeInsets.only(left: 6, bottom: 3, top: 3, right: 0),
                                  margin: EdgeInsets.symmetric(horizontal: 2, vertical: 5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.grey[200]),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        controller.selectedKeyword[index],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      Container(
                                        height: 25,
                                        child: ButtonTheme(
                                          minWidth: 0,
                                          child: MaterialButton(
                                            shape: const CircleBorder(),
                                            focusColor: Colors.red[200],
                                            hoverColor: Colors.red[200],
                                            padding: EdgeInsets.all(0),
                                            onPressed: () {
                                              controller.removeKeyword(index: index, keyword: controller.selectedKeyword[index]);
                                              // _bhkKey.currentState?.removeItem(i);
                                            },
                                            child: Icon(
                                              Icons.close_outlined,
                                              color: Colors.grey,
                                              size: 14,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },);
                          },
                        ),
                      ),
                      // _buildKeywordDropDown(),
                      Divider(
                        height: 1,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 15),
                      _buildSearchButton(context),
                      SizedBox(height: 15),
                      Divider(
                        height: 1,
                        color: Colors.black45,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHouseTypeDropDown() {
    return DropdownSearch<String>.multiSelection(
      key: _houseTypeKey,

      dropdownBuilder: (context, selectedItems) {
        Widget item(String i) => Container(
              padding: EdgeInsets.only(left: 6, bottom: 3, top: 3, right: 0),
              margin: EdgeInsets.symmetric(horizontal: 2, vertical: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey[200]),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    i,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12),
                  ),
                  Container(
                    height: 25,
                    child: MaterialButton(
                      minWidth: 0,
                      shape: const CircleBorder(),
                      focusColor: Colors.red[200],
                      hoverColor: Colors.red[200],
                      onPressed: () {
                        _houseTypeKey.currentState?.removeItem(i);
                      },
                      child: Icon(
                        Icons.close_outlined,
                        color: Colors.grey,
                        size: 14,
                      ),
                    ),
                  )
                ],
              ),
            );
        return Wrap(
          children: selectedItems.map((e) => item(e)).toList(),
        );
      },

      dropdownSearchDecoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(5, 5, 0, 0),
        border: InputBorder.none,
      ),
      mode: Mode.MENU,
      showSelectedItems: true,
      showAsSuffixIcons: true,
      dropdownButtonBuilder: (_) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: const Icon(
          Icons.keyboard_arrow_down_outlined,
          size: 20,
          color: Colors.grey,
        ),
      ),
      popupBarrierColor: Colors.black12,
      items: [
        "Apartment",
        "Bungalow",
        "Cabin",
        'Coach House',
        'Castle',
        'Cave House'
      ],
      onChanged: print,
      popupSelectionWidget: (cnt, String item, bool isSelected) {
        return isSelected
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.check_circle,
                  color: mainColor,
                ),
              )
            : Container();
      },
      // popupItemDisabled: (String s) => s.startsWith('I'),

      selectedItems: ["Apartment"],
    );
  }

  void _showPicker(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (context) {
          return SizedBox(
            height: 250,
            child: CupertinoActionSheet(

               title:  Stack(
                 children: [
                   Center(child: Text("Radius", textAlign: TextAlign.center,)),
                   Container(width: double.infinity,
                   height: 20,),
                   PositionedDirectional(
                       top: 0,
                       end: 5,
                       child: InkWell(
                         onTap: (){
                           Navigator.pop(context);
                         },
                         child: Padding(
                           padding: const EdgeInsets.all(0),
                           child: Text("Done",textAlign: TextAlign.end,),
                         ),
                       ))
                 ],
               ),
              actions: [
                        SizedBox(
                          height: 150,
                          child: CupertinoPicker(
                            backgroundColor: Colors.white,
                            itemExtent: 40,
                            scrollController: firstController,
                            children: radiusList.map((item)=> Center(
                              child: Text("Within $item Miles",
                                style: TextStyle(fontSize: 32),),
                            )).toList(),
                            onSelectedItemChanged: (index) {
                              // _pickerHandler();
                              setState(() => this.radius= index);
                              selectItem= radiusList[index];
                              FiltersController.to.radius.value = radius;
                            },

                          ),
                        ),
              ],
            ),
          );
        },
        // builder: (_) =>  SizedBox(
        //     width: double.infinity,
        //     height: 300,
        //     child: Stack(
        //       fit: StackFit.expand,
        //       children: [
        //         CupertinoPicker(
        //           backgroundColor: Colors.white,
        //           itemExtent: 40,
        //
        //           scrollController: FixedExtentScrollController(initialItem: 2),
        //           children: [
        //             Text('within 20 miles'),
        //             Text('within 30 miles'),
        //             Text('within 40 miles'),
        //             Text('within 50 miles'),
        //             Text('within 60 miles'),
        //             Text('within 70 miles'),
        //             Text('within 80 miles'),
        //           ],
        //           onSelectedItemChanged: (value) {
        //             // setState(() {
        //             //   _selectedValue = value;
        //             // });
        //           },
        //
        //         ),
        //         PositionedDirectional(
        //             start: 0,
        //             end: 0,
        //             top: 20,
        //             child: Padding(
        //               padding: const EdgeInsets.all(8.0),
        //               child: Text("Radius", textAlign: TextAlign.center,),
        //             )),
        //         PositionedDirectional(
        //             end: 10,
        //             top: 10,
        //             child: Padding(
        //               padding: const EdgeInsets.all(0),
        //               child: TextButton(child: Text("Done", textAlign: TextAlign.end,),onPressed: (){}),
        //             )),
        //
        //       ],
        //     ),
        //   ),
    );
  }

  Widget _buildPropertyTypeDropDown(BuildContext context) {
    return DropdownSearch<String>(
        dropdownSearchDecoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(5, 5, 0, 0),
          border: InputBorder.none,
        ),
        mode: Mode.MENU,
        showSelectedItems: true,
        items: [
          "Residential Properties",
          "Commercial Properties",
          "Vacant Land"
        ],
        onChanged: print,
        showAsSuffixIcons: true,
        dropdownButtonBuilder: (_) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: const Icon(
            Icons.keyboard_arrow_down_outlined,
            size: 20,
            color: Colors.grey,
          ),
        ),
        dropdownBuilder: (context, selectedItems) {
          Widget item(String i) => Container();
          return Text(selectedItems!, style: TextStyle(fontSize: 12));
        },
        selectedItem: "Residential Properties");
  }

  Widget _buildBhkTypeDropDown() {
    return DropdownSearch<String>.multiSelection(
      key: _bhkKey,

      dropdownBuilder: (context, selectedItems) {
        Widget item(String i) => Container(
              padding: EdgeInsets.only(left: 6, bottom: 3, top: 3, right: 0),
              margin: EdgeInsets.symmetric(horizontal: 2, vertical: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey[200]),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    i,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12),
                  ),
                  Container(
                    height: 25,
                    child: ButtonTheme(
                      minWidth: 0,
                      child: MaterialButton(
                        shape: const CircleBorder(),
                        focusColor: Colors.red[200],
                        hoverColor: Colors.red[200],
                        padding: EdgeInsets.all(0),
                        onPressed: () {
                          _bhkKey.currentState?.removeItem(i);
                        },
                        child: Icon(
                          Icons.close_outlined,
                          color: Colors.grey,
                          size: 14,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
        return Wrap(
          children: selectedItems.map((e) => item(e)).toList(),
        );
      },

      dropdownSearchDecoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(5, 5, 0, 0),
        border: InputBorder.none,
      ),
      mode: Mode.MENU,
      showSelectedItems: true,
      showAsSuffixIcons: true,
      dropdownButtonBuilder: (_) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: const Icon(
          Icons.keyboard_arrow_down_outlined,
          size: 20,
          color: Colors.grey,
        ),
      ),
      popupBarrierColor: Colors.black12,
      items: ["1 BHK", "2 BHK", "3 BHK", '4 BHK'],
      onChanged: print,
      popupSelectionWidget: (cnt, String item, bool isSelected) {
        return isSelected
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.check_circle,
                  color: mainColor,
                ),
              )
            : Container();
      },
      // popupItemDisabled: (String s) => s.startsWith('I'),

      selectedItems: ["1 BHK"],
    );
  }

  Widget _buildDistanceTypeDropDown() {
    return DropdownSearch<String>.multiSelection(
      key: _distanceKey,

      dropdownBuilder: (context, selectedItems) {
        Widget item(String i) => Container(
              padding: EdgeInsets.only(left: 6, bottom: 3, top: 3, right: 0),
              margin: EdgeInsets.symmetric(horizontal: 2, vertical: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey[200]),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    i,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12),
                  ),
                  Container(
                    height: 25,
                    child: ButtonTheme(
                      minWidth: 0,
                      child: MaterialButton(
                        shape: const CircleBorder(),
                        focusColor: Colors.red[200],
                        hoverColor: Colors.red[200],
                        padding: EdgeInsets.all(0),
                        onPressed: () {
                          _distanceKey.currentState?.removeItem(i);
                        },
                        child: Icon(
                          Icons.close_outlined,
                          color: Colors.grey,
                          size: 14,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
        return Wrap(
          children: selectedItems.map((e) => item(e)).toList(),
        );
      },

      dropdownSearchDecoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(5, 5, 0, 0),
        border: InputBorder.none,
      ),
      mode: Mode.MENU,
      showSelectedItems: true,
      showAsSuffixIcons: true,
      dropdownButtonBuilder: (_) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: const Icon(
          Icons.keyboard_arrow_down_outlined,
          size: 20,
          color: Colors.grey,
        ),
      ),
      popupBarrierColor: Colors.black12,
      items: [
        "5 Miles",
        "10 Miles",
        "15 Miles",
        '20 Miles',
        '25 Miles',
        '30 Miles'
      ],
      onChanged: print,
      popupSelectionWidget: (cnt, String item, bool isSelected) {
        return isSelected
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.check_circle,
                  color: mainColor,
                ),
              )
            : Container();
      },
      // popupItemDisabled: (String s) => s.startsWith('I'),

      selectedItems: ["5 Miles"],
    );
  }

  Widget _buildKeywordDropDown() {
    return DropdownSearch<String>.multiSelection(
      key: _selectKeywordKey,

      dropdownBuilder: (context, selectedItems) {
        Widget item(String i) => Container(
              padding: EdgeInsets.only(left: 6, bottom: 3, top: 3, right: 0),
              margin: EdgeInsets.symmetric(horizontal: 2, vertical: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey[200]),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    i,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12),
                  ),
                  Container(
                    height: 25,
                    child: MaterialButton(
                      minWidth: 0,
                      shape: const CircleBorder(),
                      focusColor: Colors.red[200],
                      hoverColor: Colors.red[200],
                      padding: EdgeInsets.all(0),
                      onPressed: () {
                        _selectKeywordKey.currentState?.removeItem(i);
                      },
                      child: Icon(
                        Icons.close_outlined,
                        color: Colors.grey,
                        size: 14,
                      ),
                    ),
                  )
                ],
              ),
            );
        return Wrap(
          children: selectedItems.map((e) => item(e)).toList(),
        );
      },

      dropdownSearchDecoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(5, 5, 0, 0),
        border: InputBorder.none,
      ),
      mode: Mode.MENU,
      showSelectedItems: true,
      showAsSuffixIcons: true,
      dropdownButtonBuilder: (_) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: const Icon(
          Icons.keyboard_arrow_down_outlined,
          size: 20,
          color: Colors.grey,
        ),
      ),
      popupBarrierColor: Colors.black12,
      items: [
        "Apartment",
        "Bungalow",
        "Cabin",
        'Coach House',
        'Castle',
        'Cave House'
      ],
      onChanged: print,
      popupSelectionWidget: (cnt, String item, bool isSelected) {
        return isSelected
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.check_circle,
                  color: mainColor,
                ),
              )
            : Container();
      },
      // popupItemDisabled: (String s) => s.startsWith('I'),

      selectedItems: ["Apartment"],
    );
  }

  Widget _buildSearchButton(BuildContext context) {
    List<String> prop = [];

    // List<String> myList = ["1", "2", "#3", "*4", "+5"];
    List<String>  propTypes =  FiltersController.to.selectedPropertyTypesIds;
    if(propTypes.length == 0){
      propTypes.add("-1");
    }
    String propTypesSelected = propTypes.reduce((value, element) {
      return value + "," + element;
    });
    List<String>  houseTypes =  FiltersController.to.selectedHouseTypesIds;
    if(houseTypes.length == 0){
      houseTypes.add("-1");
    }
    String houseTypesSelected = houseTypes.reduce((value, element) {
      return value + "," + element;
    });
    // # output: "12#3*4+5"



    return GetX<FilterresultsController>(
      builder: (controller) {
        return Container(
          width: MediaQuery.of(context).size.width,
          child: OutlinedButton(
            style: raisedButtonStyle,
            onPressed: () {
              FilterresultsController.to.getPropertyList(
                // propertyType: FiltersController.to.selectedPropertyTypesIds.length != 0
                //     ? FiltersController.to.selectedPropertyTypesIds : "-1",
                  propertyType: propTypesSelected,
                  houseType: houseTypesSelected,
                  // houseType: FiltersController.to.selectedHouseTypesIds.length != 0
                  //     ? FiltersController.to.selectedHouseTypesIds.toString() : "-1",
                  radius: radius,
                  address: searchController.text,
                  latitude: latitude!,
                  // latitude: 47.2365159,
                  // longitude: double.parse(longitude!.substring(0,11)),
                  longitude: double.parse(longitude!),
                  keyword: "");

              print(longitude!.substring(0,9));
              Get.toNamed(Routes.FILTERRESULTS);
            },
            child: controller.click.value ? SizedBox(height: 12,width: 12,child: CircularProgressIndicator(color: Colors.white,))  :  Text('Enter'),
          ),
        );
      },
    );
  }
}
