class User {
 late String token;
 late Data data;



  User.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    data = json['user'] = Data.fromJson(json['user']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    if (this.data != null) {
      data['user'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
 late String? name;
 late String? email;
 late String? type;
 late String? updatedAt;
 late String? createdAt;
 late int? id;

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    type = json['type'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['type'] = this.type;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}