import 'package:rxdart/rxdart.dart';

class ProductDetailsModel {
  int status;
  String message;
  Data data;

  ProductDetailsModel({this.status, this.message, this.data});

  ProductDetailsModel.fromJson(Map<String, dynamic> json) {
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
  Product product;

  Data({this.product});

  Data.fromJson(Map<String, dynamic> json) {
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.product != null) {
      data['product'] = this.product.toJson();
    }
    return data;
  }
}

class Product {
  int id;
  String name;
  String desc;
  String image;
  String price;
  String currency;
  String favourite;
  List<Options> options;
  List<Images> images;

  Product(
      {this.id,
      this.name,
      this.desc,
      this.image,
      this.price,
      this.currency,
      this.favourite,
      this.options,
      this.images});

  // List<Options> getOptions() {
  //   options.add(options[0]);
  //   options.add(options[0]);
  //   options.add(options[0]);
  //   options.add(options[0]);
  //   return options;
  // }

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    desc = json['desc'];
    image = json['image'];
    price = json['price'];
    currency = json['currency'];
    favourite = json['favourite'];
    if (json['options'] != null) {
      options = new List<Options>();
      json['options'].forEach((v) {
        options.add(new Options.fromJson(v));
      });
    }
    if (json['images'] != null) {
      images = new List<Images>();
      json['images'].forEach((v) {
        images.add(new Images.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['desc'] = this.desc;
    data['image'] = this.image;
    data['price'] = this.price;
    data['currency'] = this.currency;
    data['favourite'] = this.favourite;
    if (this.options != null) {
      data['options'] = this.options.map((v) => v.toJson()).toList();
    }
    if (this.images != null) {
      data['images'] = this.images.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Options {
  int id;
  String name;
  String price;
  String currency;
  BehaviorSubject<bool> _isSelected = BehaviorSubject.seeded(false);

  bool get currentState => _isSelected.value;
  Stream<bool> get isSelected$ => _isSelected.stream;
  Sink<bool> get inIsSelected => _isSelected.sink;

  Options({this.id, this.name, this.price, this.currency});

  Options.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    currency = json['currency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['currency'] = this.currency;
    return data;
  }
}

class Images {
  String image;

  Images({this.image});

  Images.fromJson(Map<String, dynamic> json) {
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    return data;
  }
}
