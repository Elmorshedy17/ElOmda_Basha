import 'package:momentoo/features/address_book/addressBook_model.dart';
import 'package:momentoo/features/shopping_cart/cartActions_manager.dart';
import 'package:momentoo/shared/helper/locator.dart';

class CartActionsModel {
  int status;
  String message;
  Data data;

  CartActionsModel({this.status, this.message, this.data});

  CartActionsModel.fromJson(Map<String, dynamic> json) {
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
  Seller seller;
  List<Addresses> addresses;
  List<Products> products;
  List<Cities> cities;
  Country country;

  Data({this.seller, this.addresses, this.products, this.cities, this.country});

  double getTotalPrice() {
    var totalPrice = 0.0;
    products.forEach((product) {
      totalPrice += double.parse(product.price) * int.parse(product.count);
    });

    return totalPrice;
  }

  double getFinalPrice() {
    // return getTotalPrice() + double.parse(seller.deliveryFee);
    var finalPrice = getTotalPrice() +
        double.parse(locator<CartActionsManager>().getDeliveryFeeValue);
    locator<CartActionsManager>().inFinalPrice.add(finalPrice);
    return finalPrice;
  }

  Data.fromJson(Map<String, dynamic> json) {
    seller =
        json['seller'] != null ? new Seller.fromJson(json['seller']) : null;
    if (json['addresses'] != null) {
      addresses = new List<Addresses>();
      json['addresses'].forEach((v) {
        addresses.add(new Addresses.fromJson(v));
      });
    }
    if (json['products'] != null) {
      products = new List<Products>();
      json['products'].forEach((v) {
        products.add(new Products.fromJson(v));
      });
    }
    if (json['cities'] != null) {
      cities = new List<Cities>();
      json['cities'].forEach((v) {
        cities.add(new Cities.fromJson(v));
      });
    }
    country =
        json['country'] != null ? new Country.fromJson(json['country']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.seller != null) {
      data['seller'] = this.seller.toJson();
    }
    if (this.addresses != null) {
      data['addresses'] = this.addresses.map((v) => v.toJson()).toList();
    }
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    if (this.cities != null) {
      data['cities'] = this.cities.map((v) => v.toJson()).toList();
    }
    if (this.country != null) {
      data['country'] = this.country.toJson();
    }
    return data;
  }
}

class Seller {
  int id;
  String name;
  String deliveryFee;
  String currency;
  String status;

  Seller({this.id, this.name, this.deliveryFee, this.currency, this.status});

  Seller.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    deliveryFee = json['delivery_fee'];
    currency = json['currency'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['delivery_fee'] = this.deliveryFee;
    data['currency'] = this.currency;
    data['status'] = this.status;
    return data;
  }
}

//class Cities {
//  int id;
//  String name;
//
//  Cities({this.id, this.name});
//
//  Cities.fromJson(Map<String, dynamic> json) {
//    id = json['id'];
//    name = json['name'];
//  }
//
//  Map<String, dynamic> toJson() {
//    final Map<String, dynamic> data = new Map<String, dynamic>();
//    data['id'] = this.id;
//    data['name'] = this.name;
//    return data;
//  }
//}
//
//class Country {
//  String name;
//
//  Country({this.name});
//
//  Country.fromJson(Map<String, dynamic> json) {
//    name = json['name'];
//  }
//
//  Map<String, dynamic> toJson() {
//    final Map<String, dynamic> data = new Map<String, dynamic>();
//    data['name'] = this.name;
//    return data;
//  }
//}

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

class Products {
  int id;
  String name;
  String image;
  String currency;
  String count;
  String notes;
  String desc;
  String options;
  String price;

  Products(
      {this.id,
      this.name,
      this.image,
      this.currency,
      this.count,
      this.notes,
      this.desc,
      this.options,
      this.price});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    currency = json['currency'];
    count = json['count'];
    notes = json['notes'];
    desc = json['desc'];
    options = json['options'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['currency'] = this.currency;
    data['count'] = this.count;
    data['notes'] = this.notes;
    data['desc'] = this.desc;
    data['options'] = this.options;
    data['price'] = this.price;
    return data;
  }
}

// class Products {
//   int id;
//   String name;
//   String image;
//   String price;
//   String currency;
//   String section;
//   String favourite;

//   Products(
//       {this.id,
//       this.name,
//       this.image,
//       this.price,
//       this.currency,
//       this.section,
//       this.favourite});

//   Products.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     image = json['image'];
//     price = json['price'];
//     currency = json['currency'];
//     section = json['section'];
//     favourite = json['favourite'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['image'] = this.image;
//     data['price'] = this.price;
//     data['currency'] = this.currency;
//     data['section'] = this.section;
//     data['favourite'] = this.favourite;
//     return data;
//   }
// }
