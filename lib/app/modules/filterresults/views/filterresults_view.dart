import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:perfect/app/modules/filterresults/views/property_list_item.dart';

import '../controllers/filterresults_controller.dart';

class FilterresultsView extends GetView<FilterresultsController> {
  FilterresultsController controller = Get.put(FilterresultsController());
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 14,
            )),
        centerTitle: true,
        title: Text(
          "Search Results",
          style: TextStyle(
              fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
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
                  Get.toNamed('/map');
                  //Navigator.push(context, MaterialPageRoute(builder: (context) => Search()));
                },
                child: Text(
                  "Map",
                  style: TextStyle(fontSize: 13),
                ),
              ),
            ),
          ),
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
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Newcastle Upon Tyne",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Up To \$12,000,Atleast 3 Bedrooms",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                        Text(
                          "40 Results",
                          style: TextStyle(color: Colors.white, fontSize: 13),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ListView.builder(
                primary: false,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount:
                controller.propertyList.length,
                itemBuilder:
                    (BuildContext context, int index) {
                  return PropertyListItem(
                      property:
                      controller.propertyList[index]);
                })
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
          //  height: size.height/9,
          //  width: size.width/5,

          child: ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: SizedBox.fromSize(
              size: Size.fromRadius(24), // Image radius
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
    return InkWell(
      onTap: () {
        Get.toNamed('/propertydetails');
        //Navigator.push(context, MaterialPageRoute(builder: (context) =>ParpcatMove()));
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 0, 10, 0.0),
        child: Container(
          height: 120,
          decoration: BoxDecoration(color: Colors.white),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.home,
                        color: Color(0xff00DFB6),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "ABC Company Name",
                        style:
                            TextStyle(fontSize: 15, color: Color(0XFF636363)),
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
                        width: 5,
                      ),
                      Text(
                        "Califormia",
                        style:
                            TextStyle(fontSize: 15, color: Color(0XFF636363)),
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
                        width: 5,
                      ),
                      Text(
                        "78785 Newcastle, Calabasas,",
                        style:
                            TextStyle(fontSize: 15, color: Color(0XFF636363)),
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
                        width: 5,
                      ),
                      Text(
                        "8000919369",
                        style:
                            TextStyle(fontSize: 15, color: Color(0XFF636363)),
                      )
                    ],
                  ),
                ],
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox.fromSize(
                  size: Size.fromRadius(20), // Image radius
                  child: Image.asset("assets/image/home.jpg", fit: BoxFit.fill),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
