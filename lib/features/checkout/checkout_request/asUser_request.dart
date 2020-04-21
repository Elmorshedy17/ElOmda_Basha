import 'package:momentoo/shared/domain/cartRequest.dart';

class AsUserRequest {
  int sellerId;
  int addressId;
  String promoCode;
  String notes;

  ///
  ///[delivery , pickup]
  ///
  String orderType;
  List<Products> products;

  AsUserRequest(
      {this.sellerId,
      this.products,
      this.promoCode,
      this.orderType,
      this.addressId,
      this.notes}) {
    this.products = List<Products>();
  }

  addToProducts(Products product) => products.add(product);
  removeFromProducts(Products product) => products.add(product);

  AsUserRequest.fromJson(Map<String, dynamic> json) {
    sellerId = json['seller_id'];
    addressId = json['address_id'];
    promoCode = json['promo_code'];
    notes = json['notes'];
    orderType = json['order_type'];
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