import 'package:momentoo/features/address_book/addressBook_model.dart';

class AddNewAddressModel {
  int status;
  String message;
  Data data;

  AddNewAddressModel({this.status, this.message, this.data});

  AddNewAddressModel.fromJson(Map<String, dynamic> json) {
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
  List<Addresses> addresses;
  Addresses lastAddress;

  Data({this.addresses, this.lastAddress});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['addresses'] != null) {
      addresses = new List<Addresses>();
      json['addresses'].forEach((v) {
        addresses.add(new Addresses.fromJson(v));
      });
    }
    lastAddress = json['last_address'] != null
        ? new Addresses.fromJson(json['last_address'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.addresses != null) {
      data['addresses'] = this.addresses.map((v) => v.toJson()).toList();
    }
    if (this.lastAddress != null) {
      data['last_address'] = this.lastAddress.toJson();
    }
    return data;
  }
}

//class Addresses {
//  int id;
//  String title;
//
//  Addresses({this.id, this.title});
//
//  Addresses.fromJson(Map<String, dynamic> json) {
//    id = json['id'];
//    title = json['title'];
//  }
//
//  Map<String, dynamic> toJson() {
//    final Map<String, dynamic> data = new Map<String, dynamic>();
//    data['id'] = this.id;
//    data['title'] = this.title;
//    return data;
//  }
//}
