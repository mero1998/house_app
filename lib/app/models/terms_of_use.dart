
import 'package:perfect/app/utils/helper.dart';

class TermsOfUse {
  String? text;


  TermsOfUse.fromJson(Map<String, dynamic> json) {

    text =  Helper.parseHtmlString(json['text']);

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    return data;
  }


}