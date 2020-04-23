class TrackOrderModel {
  int status;
  String message;
  Data data;

  TrackOrderModel({this.status, this.message, this.data});

  TrackOrderModel.fromJson(Map<String, dynamic> json) {
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
  String logo;
  String total;
  List<Steps> steps;

  Order({this.id, this.seller, this.logo, this.total, this.steps});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    seller = json['seller'];
    logo = json['logo'];
    total = json['total'];
    if (json['steps'] != null) {
      steps = new List<Steps>();
      json['steps'].forEach((v) {
        steps.add(new Steps.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['seller'] = this.seller;
    data['logo'] = this.logo;
    data['total'] = this.total;
    if (this.steps != null) {
      data['steps'] = this.steps.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Steps {
  int id;
  String name;
  String date;
  String active;

  Steps({this.id, this.name, this.date, this.active});

  Steps.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    date = json['date'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['date'] = this.date;
    data['active'] = this.active;
    return data;
  }
}