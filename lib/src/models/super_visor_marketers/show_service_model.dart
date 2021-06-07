class ShowService {
  String key;
  String msg;
  Data data;

  ShowService({this.key, this.msg, this.data});

  ShowService.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  int id;
  String title;
  String desc;
  var price;
  var quantity;
  String image;

  Data({this.id, this.title, this.desc, this.price, this.quantity, this.image});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    desc = json['desc'];
    price = json['price'];
    quantity = json['quantity'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['desc'] = this.desc;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['image'] = this.image;
    return data;
  }
}