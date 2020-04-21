// coupon_request

import 'package:momentoo/shared/domain/cartRequest.dart';

class CouponRequest {
  int sellerId;
  String promoCode;

  ///
  ///[delivery , pickup]
  ///
  String orderType;
  List<Products> products;

  CouponRequest(
      {this.sellerId, this.products, this.promoCode, this.orderType}) {
    this.products = List<Products>();
  }

  addToProducts(Products product) => products.add(product);
  removeFromProducts(Products product) => products.add(product);

  CouponRequest.fromJson(Map<String, dynamic> json) {
    sellerId = json['seller_id'];
    promoCode = json['promo_code'];
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
    data['promo_code'] = this.promoCode;
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
