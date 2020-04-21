import 'package:momentoo/shared/domain/cartRequest.dart';

class AsVisitorRequest {
  int sellerId;
  int addressId;
  String promoCode;
  String notes;
  String email;
  String phone;
  int cityId;
  String block;
  String street;
  String street2;
  String building;
  String floor;
  String jadda;
  String flat;
  String firstName;
  String lastName;

  ///
  ///[delivery , pickup]
  ///
  String orderType;
  List<Products> products;

  AsVisitorRequest(
      {this.sellerId,
      this.products,
      this.promoCode,
      this.orderType,
      this.addressId,
      this.notes,
      this.email,
      this.phone,
      this.cityId,
      this.block,
      this.street,
      this.street2,
      this.building,
      this.floor,
      this.jadda,
      this.flat,
      this.firstName,
      this.lastName}) {
    this.products = List<Products>();
  }

  addToProducts(Products product) => products.add(product);
  removeFromProducts(Products product) => products.add(product);

  AsVisitorRequest.fromJson(Map<String, dynamic> json) {
    sellerId = json['seller_id'];
    addressId = json['address_id'];
    promoCode = json['promo_code'];
    notes = json['notes'];
    orderType = json['order_type'];
    email = json['email'];
    phone = json['phone'];
    cityId = json['city_id'];
    block = json['block'];
    street = json['street'];
    street2 = json['street_2'];
    building = json['building'];
    floor = json['floor'];
    jadda = json['jadda'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    flat = json['flat'];
    if (json['products'] != null) {
      products = new List<Products>();
      json['products'].forEach((v) {
        products.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['seller_id'] = this.sellerId;
    data['address_id'] = this.addressId;
    data['promo_code'] = this.promoCode;
    data['notes'] = this.notes;
    data['order_type'] = this.orderType;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['city_id'] = this.cityId;
    data['block'] = this.block;
    data['street'] = this.street;
    data['street_2'] = this.street2;
    data['building'] = this.building;
    data['floor'] = this.floor;
    data['jadda'] = this.jadda;
    data['flat'] = this.flat;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

// class Products {
//   int productId;
//   int count;
//   String options;
//   String notes;

//   Products({this.productId, this.count, this.options, this.notes});

//   Products.fromJson(Map<String, dynamic> json) {
//     productId = json['product_id'];
//     count = json['count'];
//     options = json['options'];
//     notes = json['notes'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['product_id'] = this.productId;
//     data['count'] = this.count;
//     data['options'] = this.options;
//     data['notes'] = this.notes;
//     return data;
//   }
// }
