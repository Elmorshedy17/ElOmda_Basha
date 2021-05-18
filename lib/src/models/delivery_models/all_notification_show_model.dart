class AllNotificationShowModel {
  String key;
  String msg;
  List<Data> data;

  AllNotificationShowModel({this.key, this.msg, this.data});

  AllNotificationShowModel.fromJson(Map<String, dynamic> json) {
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
  String message;
  String type;
  String userName;
  String userAvatar;
  String orderId;
  String orderNumber;
  String date;
  String dateFrom;

  Data(
      {this.id,
        this.message,
        this.type,
        this.userName,
        this.userAvatar,
        this.orderId,
        this.orderNumber,
        this.date,
        this.dateFrom});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    message = json['message'];
    type = json['type'];
    userName = json['user_name'];
    userAvatar = json['user_avatar'];
    orderId = json['order_id'];
    orderNumber = json['order_number'];
    date = json['date'];
    dateFrom = json['date_from'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['message'] = this.message;
    data['type'] = this.type;
    data['user_name'] = this.userName;
    data['user_avatar'] = this.userAvatar;
    data['order_id'] = this.orderId;
    data['order_number'] = this.orderNumber;
    data['date'] = this.date;
    data['date_from'] = this.dateFrom;
    return data;
  }
}