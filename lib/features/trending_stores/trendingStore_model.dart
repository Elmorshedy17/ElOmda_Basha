class TrendingStoreModel {
  int status;
  String message;
  Data data;

  TrendingStoreModel({this.status, this.message, this.data});

  TrendingStoreModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  List<Sellers> sellers;

  Data({this.sellers});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['sellers'] != null) {
      sellers = new List<Sellers>();
      json['sellers'].forEach((v) {
        sellers.add(new Sellers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sellers != null) {
      data['sellers'] = this.sellers.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Sellers {
  int id;
  String name;
  String image;
  int rate;
  String cuisine;
  String favourite;

  Sellers(
      {this.id,
      this.name,
      this.image,
      this.rate,
      this.cuisine,
      this.favourite});

  Sellers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    rate = json['rate'];
    cuisine = json['cuisine'];
    favourite = json['favourite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['rate'] = this.rate;
    data['cuisine'] = this.cuisine;
    data['favourite'] = this.favourite;
    return data;
  }
}
