class MyOrdersModel {
  int status;
  String message;
  Data data;

  MyOrdersModel({this.status, this.message, this.data});

  MyOrdersModel.fromJson(Map<String, dynamic> json) {
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
  List<Orders> orders;

  Data({this.orders});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['orders'] != null) {
      orders = new List<Orders>();
      json['orders'].forEach((v) {
        orders.add(new Orders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.orders != null) {
      data['orders'] = this.orders.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Orders {
  String date;
  List<Orders> orders;

  Orders({this.date, this.orders});

  Orders.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    if (json['orders'] != null) {
      orders = new List<Orders>();
      json['orders'].forEach((v) {
        orders.add(new Orders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    if (this.orders != null) {
      data['orders'] = this.orders.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrdersInsider {
  int id;
  String seller;
  String logo;
  String track;
  String reorder;
  String status;
  String total;

  OrdersInsider(
      {this.id,
        this.seller,
        this.logo,
        this.track,
        this.reorder,
        this.status,
        this.total});

  OrdersInsider.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    seller = json['seller'];
    logo = json['logo'];
    track = json['track'];
    reorder = json['reorder'];
    status = json['status'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['seller'] = this.seller;
    data['logo'] = this.logo;
    data['track'] = this.track;
    data['reorder'] = this.reorder;
    data['status'] = this.status;
    data['total'] = this.total;
    return data;
  }
}