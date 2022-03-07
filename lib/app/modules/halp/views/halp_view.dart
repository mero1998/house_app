import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:perfect/app/models/help.dart';
import 'package:perfect/app/models/how_to_edit_profile.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../controllers/halp_controller.dart';

class HalpView extends GetView<HalpController> {
  HalpController controller = Get.put(HalpController());
  YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: 'iLnmTe5Q2Qw',
    flags: YoutubePlayerFlags(
      // autoPlay: true,
      // mute: true,
    ),
  );
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            onPressed: (){
              Get.back();
            },
              icon:Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
                size: 14,
              )
          ),
          centerTitle: true,
          title: Text("How to Edit Company \n Profile Videos ?",
              style: TextStyle(
                color: Colors.black,
                fontSize: 17,
              ),
              textAlign: TextAlign.center)),
      body: GetX<HalpController>(
        builder: (controller) {
          return ListView.builder(
              itemCount: controller.helpList.length,
              itemBuilder: (BuildContext context, int index) {
                return _getListItem(index ,controller.helpList[index]);
              });
        },
      ),
    );
  }

  Widget _getListItem( int index,HowToEditProfile help) {
    return Column(
      children: [
        Divider(
          color: Colors.black,
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () => HalpController.to.launchURL(help.videoLink!),
            child: Container(
              child: Row(
                children: [
                  Image.network(
                    HalpController.to.thumImages[index],
                    width: 55,
                    height: 65,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(width: 10,),
                  Flexible(child: Text(help.description!)),
                ],
              ),
            ),
          ),
        ),

      ],
    );
  }
}
