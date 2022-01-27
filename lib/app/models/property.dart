import 'package:perfect/app/models/media.dart';

class Property {
  String? name;
  String? city;
  String? address;
  String? contactNo;
  String? description;
  String? latitude;
  String? longitude;
  List<Media>? medias = [Media()];

  Property(
      {this.name,
      this.city,
      this.address,
      this.contactNo,
      this.description,
      this.latitude,
      this.longitude,
      this.medias});
}
