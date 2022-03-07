import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:perfect/app/modules/extra_page/extra_screen_controller.dart';


class ExtraPage extends StatelessWidget {
  const ExtraPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
        "assets/image/logo-house-app.png",
        width: 160,
      ),
        centerTitle: true,
      ),
      body: GetX(
       builder: (ExtraScreenController controller) {
         return Padding(
           padding: EdgeInsets.only(top: 70, left: 15, right: 15, bottom: 20),
           child: controller.extraScreenList.length== 0 ? Center(child: CircularProgressIndicator(),) : ListView(
             children: [
               Container(
                 width: MediaQuery.of(context).size.width,
                 height: MediaQuery.of(context).size.height / 5,

                 child: CachedNetworkImage(
                   imageUrl: controller.extraScreenList.first.image1 ?? "",
                   progressIndicatorBuilder: (context, url, downloadProgress) =>
                       CircularProgressIndicator(value: downloadProgress.progress),
                   errorWidget: (context, url, error) => Icon(Icons.error, size: 60,),
                 ),
               ),
               Text(controller.extraScreenList.first.text1 ?? ""),
               Container(
                 width: MediaQuery.of(context).size.width,
                 height: MediaQuery.of(context).size.height / 5,

                 child: CachedNetworkImage(
                   imageUrl: controller.extraScreenList.first.image2 ?? "",
                   progressIndicatorBuilder: (context, url, downloadProgress) =>
                       CircularProgressIndicator(value: downloadProgress.progress,),
                   errorWidget: (context, url, error) => Icon(Icons.error, size: 60,),
                 ),
               ),
               Text(controller.extraScreenList.first.text2 ?? ""),
             ],
           ),
         );
       },
      ),
    );
  }
}
