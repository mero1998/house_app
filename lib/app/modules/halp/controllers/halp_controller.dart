import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:perfect/app/api/api_settings.dart';
import 'package:perfect/app/models/help.dart';
import 'package:perfect/app/models/how_to_edit_profile.dart';
import 'package:perfect/preferences/user_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:http/http.dart' as http;
class HalpController extends GetxController {
  static HalpController get to => Get.find();

  RxList<HowToEditProfile> helpList = <HowToEditProfile>[].obs;

  RxList<String> vedioIds = <String>[].obs;
  RxList<String> thumImages = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    getHowToEditProfile();
  }
  
  

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  Future<List<HowToEditProfile>> getHowToEditProfileFromApi() async{
    var url = Uri.parse(ApiSettings.HOWTOEDITPROFILE + "&language=" + UserPreferences().codeLang);

    var response = await http.get(url,
        headers: {
          HttpHeaders.authorizationHeader : UserPreferences().getToken(),
        }
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      var jsonResponse  = jsonDecode(response.body)['data'] as List;
      print(response.statusCode);
      List<HowToEditProfile> list = jsonResponse.map((e) =>HowToEditProfile.fromJson(e)).toList();
      return list;
    }
    return [];
  }

  getHowToEditProfile() async{
    helpList.value = await getHowToEditProfileFromApi();
    for(int i =0; i < helpList.length; i++){
      if(helpList[i].videoLink != null){
        String? videoId = YoutubePlayer.convertUrlToId(
            helpList[i].videoLink!);
        vedioIds.add(videoId!);
        String thumbnailUrl = YoutubePlayer.getThumbnail(videoId: vedioIds[i] ?? "");
    thumImages.add(thumbnailUrl);
      }

    }



  }

  String? convertUrlToId(String url, {bool trimWhitespaces = true}) {
    if (!url.contains("http") && (url.length == 11)) return url;
    if (trimWhitespaces) url = url.trim();

    for (var exp in [
      RegExp(
          r"^https:\/\/(?:www\.|m\.)?youtube\.com\/watch\?v=([_\-a-zA-Z0-9]{11}).*$"),
      RegExp(
          r"^https:\/\/(?:www\.|m\.)?youtube(?:-nocookie)?\.com\/embed\/([_\-a-zA-Z0-9]{11}).*$"),
      RegExp(r"^https:\/\/youtu\.be\/([_\-a-zA-Z0-9]{11}).*$")
    ]) {
      Match? match = exp.firstMatch(url);
      if (match != null && match.groupCount >= 1) return match.group(1);
    }

    return null;
  }
  String getThumbnail({

    required String videoId,
    String quality = ThumbnailQuality.standard,
    bool webp = true,
  }) =>
      webp
          ? 'https://i3.ytimg.com/vi_webp/$videoId/$quality.webp'
          : 'https://i3.ytimg.com/vi/$videoId/$quality.jpg';



  void launchURL(String url) async {
    if (!await launch(url)) throw 'Could not launch $url';
  }
}
