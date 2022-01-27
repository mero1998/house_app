import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:perfect/app/data/constants.dart';
import 'package:perfect/app/routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
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
    return Container(
      margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
      width: MediaQuery.of(context).size.width,
      height: 45,
      child: OutlinedButton(
        style: raisedButtonStyle,
        onPressed: () {
          Get.toNamed('/filters');
          //Navigator.push(context,
              //MaterialPageRoute(builder: (context) => ())
              //);
        },
        child: Text('Start Search'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Image.asset(
          "assets/image/header_img.png",
          width: 160,
        ),
        centerTitle: true,
        leading: _buildSingInButton(context),
        leadingWidth: 70,
        actions: [
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
                    Get.toNamed(Routes.EDITPROFILE);
                  },
                )),
                PopupMenuDivider(),
                PopupMenuItem(
                    child: GestureDetector(
                      child: Text('Plans'),
                      onTap: () {
                        Get.toNamed(Routes.SUBSCIPTION);
                      },
                    )),
                PopupMenuDivider(),
                PopupMenuItem(child: Text('Recommend to a friend')),
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
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                    )
                  ],
                ),
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
              Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 15.0),
                child: Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quam ultricies lacus vulputate at posuere velit nulla ut. Elementum accumsan vitae ut aliquam. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quam ultricies lacus vulputate at posuere velit nulla ut. Elementum accumsan vitae ut aliquam.",
                    style: TextStyle(
                        color: Colors.black45, wordSpacing: 3, fontSize: 16)),
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
