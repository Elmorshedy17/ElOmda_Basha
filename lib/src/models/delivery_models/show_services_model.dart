class ShowServicesModel {
  String key;
  String msg;
  List<Data> data;

  ShowServicesModel({this.key, this.msg, this.data});

  ShowServicesModel.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int id;
  String title;
  String desc;
  int price;
  int totalForCountry;
  int solidTotal;
  int quantity;
  String image;

  Data(
      {this.id,
        this.title,
        this.desc,
        this.price,
        this.totalForCountry,
        this.solidTotal,
        this.quantity,
        this.image});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    desc = json['desc'];
    price = json['price'];
    totalForCountry = json['total_for_country'];
    solidTotal = json['solid_total'];
    quantity = json['quantity'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['desc'] = this.desc;
    data['price'] = this.price;
    data['total_for_country'] = this.totalForCountry;
    data['solid_total'] = this.solidTotal;
    data['quantity'] = this.quantity;
    data['image'] = this.image;
    return data;
  }
}
