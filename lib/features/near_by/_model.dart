class NearByModel {
  int status;
  String message;
  Data data;

  NearByModel({this.status, this.message, this.data});

  NearByModel.fromJson(Map<String, dynamic> json) {
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
  List<Cuisines> cuisines;
  String categoryId;

  Data({this.sellers, this.cuisines, this.categoryId});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['sellers'] != null) {
      sellers = new List<Sellers>();
      json['sellers'].forEach((v) {
        sellers.add(new Sellers.fromJson(v));
      });
    }
    if (json['cuisines'] != null) {
      cuisines = new List<Cuisines>();
      json['cuisines'].forEach((v) {
        cuisines.add(new Cuisines.fromJson(v));
      });
    }
    categoryId = json['category_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sellers != null) {
      data['sellers'] = this.sellers.map((v) => v.toJson()).toList();
    }
    if (this.cuisines != null) {
      data['cuisines'] = this.cuisines.map((v) => v.toJson()).toList();
    }
    data['category_id'] = this.categoryId;
    return data;
  }
}

class Sellers {
  int id;
  String name;
  String image;
  int rate;
  String lat;
  String lng;
  String cuisine;
  String favourite;

  Sellers(
      {this.id,
        this.name,
        this.image,
        this.rate,
        this.lat,
        this.lng,
        this.cuisine,
        this.favourite});

  Sellers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    rate = json['rate'];
    lat = json['lat'];
    lng = json['lng'];
    cuisine = json['cuisine'];
    favourite = json['favourite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['rate'] = this.rate;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['cuisine'] = this.cuisine;
    data['favourite'] = this.favourite;
    return data;
  }
}

class Cuisines {
  int id;
  String name;

  Cuisines({this.id, this.name});

  Cuisines.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}