class InvoiceModel {
  int status;
  String message;
  Data data;

  InvoiceModel({this.status, this.message, this.data});

  InvoiceModel.fromJson(Map<String, dynamic> json) {
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
  Order order;

  Data({this.order});

  Data.fromJson(Map<String, dynamic> json) {
    order = json['order'] != null ? new Order.fromJson(json['order']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.order != null) {
      data['order'] = this.order.toJson();
    }
    return data;
  }
}

class Order {
  int id;
  String seller;
  String date;
  String time;
  String street;
  String orderType;
  String delivery;
  String name;
  String subTotal;
  String total;
  List<Products> products;

  Order(
      {this.id,
        this.seller,
        this.date,
        this.time,
        this.street,
        this.orderType,
        this.delivery,
        this.name,
        this.subTotal,
        this.total,
        this.products});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    seller = json['seller'];
    date = json['date'];
    time = json['time'];
    street = json['street'];
    orderType = json['order_type'];
    delivery = json['delivery'];
    name = json['name'];
    subTotal = json['sub_total'];
    total = json['total'];
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
    data['seller'] = this.seller;
    data['date'] = this.date;
    data['time'] = this.time;
    data['street'] = this.street;
    data['order_type'] = this.orderType;
    data['delivery'] = this.delivery;
    data['name'] = this.name;
    data['sub_total'] = this.subTotal;
    data['total'] = this.total;
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  String name;
  String price;

  Products({this.name, this.price});

  Products.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['price'] = this.price;
    return data;
  }
}