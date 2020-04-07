class AdsModel {
  int status;
  String message;
  Data data;

  AdsModel({this.status, this.message, this.data});

  AdsModel.fromJson(Map<String, dynamic> json) {
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
  Ads ads;

  Data({this.ads});

  Data.fromJson(Map<String, dynamic> json) {
    ads = json['ads'] != null ? new Ads.fromJson(json['ads']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.ads != null) {
      data['ads'] = this.ads.toJson();
    }
    return data;
  }
}

class Ads {
  String desc;
  String image;

  Ads({this.desc, this.image});

  Ads.fromJson(Map<String, dynamic> json) {
    desc = json['desc'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['desc'] = this.desc;
    data['image'] = this.image;
    return data;
  }
}
