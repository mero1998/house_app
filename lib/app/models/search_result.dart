class FilterResult {
  int? id;
  int? companyId;
  String? companyLogo;
  String? companyName;
  String? companyAddress;
  double? companyLatitude;
  double? companyLongitude;
  String? companyPhoneNumber;
  String? companyEmail;
  String? companyPropertyTypes;
  String? companyHouseTypes;
  String? companyDescription;
  String? createdAt;
  String? updatedAt;
  String? companyLogoUrl;
  List<CompanyImages>? companyImages;


  FilterResult.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyId = json['company_id'];
    companyLogo = json['company_logo'];
    companyName = json['company_name'];
    companyAddress = json['company_address'];
    companyLatitude = json['company_latitude'];
    companyLongitude = json['company_longitude'];
    companyPhoneNumber = json['company_phone_number'];
    companyEmail = json['company_email'];
    companyPropertyTypes = json['company_property_types'];
    companyHouseTypes = json['company_house_types'];
    companyDescription = json['company_description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    companyLogoUrl = json['company_logo_url'];
    if (json['company_images'] != null) {
      companyImages = <CompanyImages>[];
      json['company_images'].forEach((v) {
        companyImages!.add(new CompanyImages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['company_id'] = this.companyId;
    data['company_logo'] = this.companyLogo;
    data['company_name'] = this.companyName;
    data['company_address'] = this.companyAddress;
    data['company_latitude'] = this.companyLatitude;
    data['company_longitude'] = this.companyLongitude;
    data['company_phone_number'] = this.companyPhoneNumber;
    data['company_email'] = this.companyEmail;
    data['company_property_types'] = this.companyPropertyTypes;
    data['company_house_types'] = this.companyHouseTypes;
    data['company_description'] = this.companyDescription;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['company_logo_url'] = this.companyLogoUrl;
    if (this.companyImages != null) {
      data['company_images'] =
          this.companyImages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CompanyImages {
  int? id;
  int? companyId;
  String? image;
  double? price;
  String? keyword;
  String? createdAt;
  String? updatedAt;
  String? imageUrl;



  CompanyImages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyId = json['company_id'];
    image = json['image'];
    price = json['price'];
    keyword = json['keyword'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['company_id'] = this.companyId;
    data['image'] = this.image;
    data['price'] = this.price;
    data['keyword'] = this.keyword;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['image_url'] = this.imageUrl;
    return data;
  }
}