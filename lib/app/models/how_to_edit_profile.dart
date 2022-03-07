
class HowToEditProfile {
  String? videoLink;
  String? description;


  HowToEditProfile.fromJson(Map<String, dynamic> json) {
    videoLink = json['video_link'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['video_link'] = this.videoLink;
    data['description'] = this.description;
    return data;
  }
}