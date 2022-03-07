import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:perfect/app/data/constants.dart';
import 'package:perfect/app/modules/contact_us/views/contact_us_view.dart';
import 'package:perfect/app/modules/filterresults/views/property_list_item.dart';
import 'package:perfect/app/modules/filters/views/filters_view.dart';
import 'package:perfect/app/modules/home/controllers/property_fav_list_item.dart';
import 'package:perfect/app/modules/login/bindings/login_binding.dart';
import 'package:perfect/app/modules/login/controllers/login_controller.dart';
import 'package:perfect/app/modules/propertydetails/views/propertydetails_view.dart';
import 'package:perfect/app/modules/recommend_to_frind/views/recommend_to_friend_view.dart';
import 'package:perfect/app/routes/app_pages.dart';
import 'package:perfect/app/utils/drop_down_multilanguage.dart';
import 'package:perfect/preferences/user_preferences.dart';
import '../controllers/home_controller.dart';

class HomeView extends StatefulWidget {
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  Widget _buildSingInButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 5, top: 10, bottom: 10),
      child: SizedBox(
        height: 10,
        child: OutlinedButton(
          style: raisedButtonStyle,
          onPressed: () {
            Get.toNamed(Routes.LOGIN);
          },
          child: Text(
            'Signin',
            style: TextStyle(fontSize: 10),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchButton(BuildContext context) {
    return GetX<HomeController>(
      builder: (controller) {
        return Container(
          margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
          width: MediaQuery.of(context).size.width,
          height: 45,
          child: OutlinedButton(
            style: raisedButtonStyle,
            onPressed: () {
              // Get.toNamed('/filters');
              controller.click.value = true;
              Future.delayed(Duration(milliseconds: 500), (){
                controller.click.value = false;
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FiltersView())
                );

              });

            },
            child: controller.click.value ? SizedBox(height: 12,width: 12,child: CircularProgressIndicator(color: Colors.white,))  :  Text('Start Search'),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Get.put(LoginController());
    Get.put(HomeController());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.grey.shade500,
        title: Image.asset(
          "assets/image/logo-white.png",
          width: 160,
        ),
        centerTitle: true,
        leading: Visibility(visible: UserPreferences().isLoggedIn == false, child: _buildSingInButton(context)),
        leadingWidth: 70,
        actions: [
          Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
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
                      PopupMenuItem(
                        enabled: UserPreferences().type == "company",
                          child: GestureDetector(
                            child: Text('My Profile'),
                            onTap: () {
                              print("Click");
                              Navigator.push(context, MaterialPageRoute(builder: (context) => PropertydetailsView(companyId: UserPreferences().id),));
                              // Get.toNamed(Routes.EDITPROFILE);
                            },
                          )),
                      PopupMenuDivider(),

                      PopupMenuItem(
                        child: Text('Contact'),
                        onTap: () {
                          Get.toNamed('/contact-us');
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ContactUsView(),
                              ));
                        },
                      ),

                      PopupMenuDivider(),
                      // PopupMenuItem(
                      //     child: GestureDetector(
                      //   child: Text('Plans'),
                      //   onTap: () {
                      //     Get.toNamed(Routes.SUBSCIPTION);
                      //   },
                      // )),
                      PopupMenuDivider(),
                      PopupMenuItem(
                        child: Text('Recommend to a friend'),
                        onTap: () {
                          Get.toNamed("/recommend-to-friend");
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RecommendToFriendView(),
                              ));
                        },
                      ),
                      PopupMenuDivider(),

                      PopupMenuItem(
                          child: GestureDetector(
                             onTap: () => Get.toNamed(Routes.TERMSOFUSE),
                              child: Text('Terms of use'))),
                      PopupMenuDivider(),
                      PopupMenuItem(child: GestureDetector(
                          onTap: () => Get.toNamed(Routes.PRIVACYPOLICY),
                     child: Text('Privacy Policy'))),
                      PopupMenuDivider(),
                      PopupMenuItem(
                          child: InkWell(
                        child: Text('How to work'),
                        onTap: () {
                          Get.toNamed('/halp');
                        },
                      )),
                      PopupMenuDivider(),
                      PopupMenuItem(
                        child: Text('Logout'),
                        onTap: () {
                          LoginBinding().dependencies();
                          LoginController.to.logout();
                        },
                      ),
                    ],
                  ),
                ),
              )),
          DropDownMultiLanguage()
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GetX<HomeController>(
                builder: (controller) {
                  return controller.homeImageList.length != 0 ? Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 5,
                    child: CachedNetworkImage(
                      imageUrl: controller.homeImageList.first!.image,
                      // progressIndicatorBuilder: (context, url, downloadProgress) =>
                      //     CircularProgressIndicator(
                      //         value: downloadProgress.progress),
                      errorWidget: (context, url, error) => Icon(
                        Icons.error,
                        size: 60,
                      ),
                    ),
                  ) :     Center(child: CircularProgressIndicator());
                },
              ),
              _buildSearchButton(context),
              Divider(
                height: 5,
                color: Colors.black45,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
                child: Row(
                  children: [
                    Text(
                      "❤",
                      style: TextStyle(color: Colors.red, fontSize: 18),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Saved Properties",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: "assets/fonts/Gilroy-ExtraBold.otf",
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              GetX<HomeController>(
                builder: (controller) {
                  print("Fav Lenght::; ${controller.savedProp.length}");
                  return ListView.builder(
                    itemCount: controller.savedProp.length,
                      shrinkWrap: true,
                    physics: ScrollPhysics(),
                    // scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                        return PropertyFavListItem(property: controller.savedProp[index]!);
                      },);
                },
              ),
              Divider(
                height: 5,
                color: Colors.black45,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0.0),
                child: Text("About Company",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
              ),
              GetX<HomeController>(
                builder: (controller) {
                  return controller.aboutCompanyList.length != 0 ? Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 15.0),
                    child: Text(
                      controller.aboutCompanyList.first!.text ?? "",
                        style: TextStyle(
                            color: Colors.black45, wordSpacing: 3, fontSize: 16)),
                  ) : Center(child: CircularProgressIndicator(),);
                },
              ),
              Divider(
                height: 5,
                color: Colors.black,
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 1.0),
                child: Center(child: Image.asset("assets/image/ads.png")),
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("BarSeasons Rotisserie - Great Offers",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                      Icon(Icons.more_vert_outlined)
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 15.0),
                child: Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    style: TextStyle(
                        color: Colors.black45, wordSpacing: 3, fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
