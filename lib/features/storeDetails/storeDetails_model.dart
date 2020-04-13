class StoreDetailsModel {
  int status;
  String message;
  Data data;

  StoreDetailsModel({this.status, this.message, this.data});

  StoreDetailsModel.fromJson(Map<String, dynamic> json) {
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

  Data({this.seller});

  Data.fromJson(Map<String, dynamic> json) {
    seller =
        json['seller'] != null ? new Seller.fromJson(json['seller']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.seller != null) {
      data['seller'] = this.seller.toJson();
    }
    return data;
  }
}

class Seller {
  int id;
  String name;
  String desc;
  String address;
  int rate;
  String featured;
  String deliveryFee;
  String deliveryTime;
  String time;
  String image;
  String share;
  String lat;
  String lng;
  String status;
  String favourite;
  List<ProductsFeatured> productsFeatured;
  List<Menu> menu;

  Seller(
      {this.id,
      this.name,
      this.desc,
      this.address,
      this.rate,
      this.featured,
      this.deliveryFee,
      this.deliveryTime,
      this.time,
      this.image,
      this.share,
      this.lat,
      this.lng,
      this.status,
      this.favourite,
      this.productsFeatured,
      this.menu});

  Seller.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    desc = json['desc'];
    address = json['address'];
    rate = json['rate'];
    featured = json['featured'];
    deliveryFee = json['delivery_fee'];
    deliveryTime = json['delivery_time'];
    time = json['time'];
    image = json['image'];
    share = json['share'];
    lat = json['lat'];
    lng = json['lng'];
    status = json['status'];
    favourite = json['favourite'];
    if (json['products_featured'] != null) {
      productsFeatured = new List<ProductsFeatured>();
      json['products_featured'].forEach((v) {
        productsFeatured.add(new ProductsFeatured.fromJson(v));
      });
    }
    if (json['menu'] != null) {
      menu = new List<Menu>();
      json['menu'].forEach((v) {
        menu.add(new Menu.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['desc'] = this.desc;
    data['address'] = this.address;
    data['rate'] = this.rate;
    data['featured'] = this.featured;
    data['delivery_fee'] = this.deliveryFee;
    data['delivery_time'] = this.deliveryTime;
    data['time'] = this.time;
    data['image'] = this.image;
    data['share'] = this.share;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['status'] = this.status;
    data['favourite'] = this.favourite;
    if (this.productsFeatured != null) {
      data['products_featured'] =
          this.productsFeatured.map((v) => v.toJson()).toList();
    }
    if (this.menu != null) {
      data['menu'] = this.menu.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductsFeatured {
  int id;
  String name;
  String image;
  String price;
  String currency;
  String section;
  String favourite;

  ProductsFeatured(
      {this.id,
      this.name,
      this.image,
      this.price,
      this.currency,
      this.section,
      this.favourite});

  ProductsFeatured.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    price = json['price'];
    currency = json['currency'];
    section = json['section'];
    favourite = json['favourite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['price'] = this.price;
    data['currency'] = this.currency;
    data['section'] = this.section;
    data['favourite'] = this.favourite;
    return data;
  }
}

class Menu {
  int id;
  String name;
  List<Products> products;

  Menu({this.id, this.name, this.products});

  Menu.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['products'] != null) {
      products = new List<Products>();
      json['products'].forEach((v) {
        products.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  int id;
  String name;
  String image;
  String price;
  String currency;
  String section;
  String favourite;

  Products(
      {this.id,
      this.name,
      this.image,
      this.price,
      this.currency,
      this.section,
      this.favourite});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    price = json['price'];
    currency = json['currency'];
    section = json['section'];
    favourite = json['favourite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['price'] = this.price;
    data['currency'] = this.currency;
    data['section'] = this.section;
    data['favourite'] = this.favourite;
    return data;
  }
}
