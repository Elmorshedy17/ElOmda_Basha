class DeliveryFeeModel {
  int status;
  String message;
  Data data;

  DeliveryFeeModel({this.status, this.message, this.data});

  DeliveryFeeModel.fromJson(Map<String, dynamic> json) {
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
  String deliveryFee;
  Country country;

  Data({this.deliveryFee, this.country});

  Data.fromJson(Map<String, dynamic> json) {
    deliveryFee = json['delivery_fee'];
    country =
        json['country'] != null ? new Country.fromJson(json['country']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['delivery_fee'] = this.deliveryFee;
    if (this.country != null) {
      data['country'] = this.country.toJson();
    }
    return data;
  }
}

class Country {
  String name;

  Country({this.name});

  Country.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}
