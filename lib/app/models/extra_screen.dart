import 'package:perfect/app/utils/helper.dart';

class ExtraScreen {
  String? image1;
  String? image2;
  String? text1;
  String? text2;


  ExtraScreen.fromJson(Map<String, dynamic> json) {
    image1 = json['image1'];
    image2 = json['image2'];
    text1 = Helper.parseHtmlString(json['text1']);
    text2 = Helper.parseHtmlString(json['text2']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image1'] = this.image1;
    data['image2'] = this.image2;
    data['text1'] = this.text1;
    data['text2'] = this.text2;
    return data;
  }
}