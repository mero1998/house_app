import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:perfect/app/data/constants.dart';
import 'package:perfect/app/routes/app_pages.dart';

import '../controllers/filters_controller.dart';

class FiltersView extends GetView<FiltersController> {
  final _propTypeKey = GlobalKey<DropdownSearchState<String>>();
  final _houseTypeKey = GlobalKey<DropdownSearchState<String>>();
  final _bhkKey = GlobalKey<DropdownSearchState<String>>();
  final _distanceKey = GlobalKey<DropdownSearchState<String>>();
  final _selectKeywordKey = GlobalKey<DropdownSearchState<String>>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: Icon(
                              Icons.arrow_back_ios,
                              size: 14,
                            )),
                        Text(
                          "Search Filters",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: PopupMenuButton<int>(
                            onCanceled: () => {print("Push")},
                            // color: Colors.amber,
                            child: Icon(
                              Icons.menu,
                              size: 20.0,
                              color: Colors.black,
                            ),
                            itemBuilder: (context) => [
                              //  PopupMenuDivider(),
                              PopupMenuItem(child: Text('Contact')),
                              PopupMenuDivider(),
                              PopupMenuItem(
                                  child: GestureDetector(
                                child: Text('Add Profile'),
                                onTap: () {
                                  Get.toNamed('/editprofile');
                                },
                              )),
                              PopupMenuDivider(),
                              PopupMenuItem(
                                  child: Text('Recommend to a friend')),
                              PopupMenuDivider(),

                              PopupMenuItem(child: Text('Terms of use')),
                              PopupMenuDivider(),
                              PopupMenuItem(child: Text('Privacy Policy')),
                              PopupMenuItem(
                                  child: InkWell(
                                child: Text('How to work'),
                                onTap: () {
                                  Get.toNamed('/halp');
                                },
                              )),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Color(0XFFE7E7E7),
                            border: Border.all(color: Colors.white10)),
                        child: TextField(
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
                            hintText: " Search",
                            hintStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
                            suffixIcon: Align(
                              widthFactor: 1.0,
                              heightFactor: 1.0,
                              child: Icon(
                                Icons.search,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
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
                      Text(
                        "Select Property Type",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 5),
                      _buildPropertyTypeDropDown(context),
                      Divider(
                        height: 1,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Select House Type",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      _buildHouseTypeDropDown(),
                      Divider(
                        height: 1,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 15),
                      Text("Select BHK",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600)),
                      SizedBox(height: 5),
                      _buildBhkTypeDropDown(),
                      Divider(
                        height: 1,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 15),
                      Text("Select Distance Radius",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600)),
                      SizedBox(height: 5),
                      _buildDistanceTypeDropDown(),
                      Divider(
                        height: 1,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 15),
                      Text("Select Keyword",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600)),
                      SizedBox(height: 5),
                      _buildKeywordDropDown(),
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
    return Container(
      width: MediaQuery.of(context).size.width,
      child: OutlinedButton(
        style: raisedButtonStyle,
        onPressed: () {
          Get.toNamed(Routes.FILTERRESULTS);
        },
        child: Text('Enter'),
      ),
    );
  }
}
