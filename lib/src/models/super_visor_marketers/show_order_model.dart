class ShowOrderModel {
  String key;
  String msg;
  Data data;

  ShowOrderModel({this.key, this.msg, this.data});

  ShowOrderModel.fromJson(Map<String, dynamic> json) {
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
  int totalForCountry;
  int currencyCode;
  String status;
  String name;
  String phone;
  String whatsapp;
  String date;
  String time;
  String address;
  String notes;
  String message;
//  double lat;
//  double lng;
  int delivery;
  int total;
  String newOrder;
  String cancel;
  String hasProvider;
  String inWay;
  String finish;
  String countryTitle;
  String cityTitle;
  String marketerName;
  String marketerPhone;
  String marketerAvatar;
  String marketerBenfitType;
  int marketerCommission;
  int marketerPoint;
  String delegateName;
  String delegatePhone;
  String delegateBenfitType;
  String delegateAvatar;
  int delegateCommission;
  int delegatePoint;
  List<OrderStatus> orderStatus;
  List<OrderItems> orderItems;

  Data(
      {this.id,
        this.status,
        this.totalForCountry,
        this.currencyCode,
        this.name,
        this.phone,
        this.whatsapp,
        this.date,
        this.time,
        this.address,
        this.notes,
        this.message,
//        this.lat,
//        this.lng,
        this.delivery,
        this.total,
        this.newOrder,
        this.cancel,
        this.hasProvider,
        this.inWay,
        this.finish,
        this.countryTitle,
        this.cityTitle,
        this.marketerName,
        this.marketerPhone,
        this.marketerAvatar,
        this.marketerBenfitType,
        this.marketerCommission,
        this.marketerPoint,
        this.delegateName,
        this.delegatePhone,
        this.delegateBenfitType,
        this.delegateAvatar,
        this.delegateCommission,
        this.delegatePoint,
        this.orderStatus,
        this.orderItems});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    totalForCountry = json['total_for_country'];
    currencyCode = json['currency_code'];
    status = json['status'];
    name = json['name'];
    phone = json['phone'];
    whatsapp = json['whatsapp'];
    date = json['date'];
    time = json['time'];
    address = json['address'];
    notes = json['notes'];
    message = json['message'];
//    lat = json['lat'];
//    lng = json['lng'];
    delivery = json['delivery'];
    total = json['total'];
    newOrder = json['new_order'];
    cancel = json['cancel'];
    hasProvider = json['has_provider'];
    inWay = json['in_way'];
    finish = json['finish'];
    countryTitle = json['country_title'];
    cityTitle = json['city_title'];
    marketerName = json['marketer_name'];
    marketerPhone = json['marketer_phone'];
    marketerAvatar = json['marketer_avatar'];
    marketerBenfitType = json['marketer_benfit_type'];
    marketerCommission = json['marketer_commission'];
    marketerPoint = json['marketer_point'];
    delegateName = json['delegate_name'];
    delegatePhone = json['delegate_phone'];
    delegateBenfitType = json['delegate_benfit_type'];
    delegateAvatar = json['delegate_avatar'];
    delegateCommission = json['delegate_commission'];
    delegatePoint = json['delegate_point'];
    if (json['order_status'] != null) {
      orderStatus = new List<OrderStatus>();
      json['order_status'].forEach((v) {
        orderStatus.add(new OrderStatus.fromJson(v));
      });
    }
    if (json['order_items'] != null) {
      orderItems = new List<OrderItems>();
      json['order_items'].forEach((v) {
        orderItems.add(new OrderItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['total_for_country'] = this.totalForCountry;
    data['currency_code'] = this.currencyCode;
    data['status'] = this.status;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['whatsapp'] = this.whatsapp;
    data['date'] = this.date;
    data['time'] = this.time;
    data['address'] = this.address;
    data['notes'] = this.notes;
    data['message'] = this.message;
//    data['lat'] = this.lat;
//    data['lng'] = this.lng;
    data['delivery'] = this.delivery;
    data['total'] = this.total;
    data['new_order'] = this.newOrder;
    data['cancel'] = this.cancel;
    data['has_provider'] = this.hasProvider;
    data['in_way'] = this.inWay;
    data['finish'] = this.finish;
    data['country_title'] = this.countryTitle;
    data['city_title'] = this.cityTitle;
    data['marketer_name'] = this.marketerName;
    data['marketer_phone'] = this.marketerPhone;
    data['marketer_avatar'] = this.marketerAvatar;
    data['marketer_benfit_type'] = this.marketerBenfitType;
    data['marketer_commission'] = this.marketerCommission;
    data['marketer_point'] = this.marketerPoint;
    data['delegate_name'] = this.delegateName;
    data['delegate_phone'] = this.delegatePhone;
    data['delegate_benfit_type'] = this.delegateBenfitType;
    data['delegate_avatar'] = this.delegateAvatar;
    data['delegate_commission'] = this.delegateCommission;
    data['delegate_point'] = this.delegatePoint;
    if (this.orderStatus != null) {
      data['order_status'] = this.orderStatus.map((v) => v.toJson()).toList();
    }
    if (this.orderItems != null) {
      data['order_items'] = this.orderItems.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderStatus {
  String status;
  String message;

  OrderStatus({this.status, this.message});

  OrderStatus.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}

class OrderItems {
  int orderItemId;
  int sectionId;
  String sectionTitle;
  String sectionDesc;
  int sectionPrice;
  String sectionImage;
  int quantity;
  int total;

  OrderItems(
      {this.orderItemId,
        this.sectionId,
        this.sectionTitle,
        this.sectionDesc,
        this.sectionPrice,
        this.sectionImage,
        this.quantity,
        this.total});

  OrderItems.fromJson(Map<String, dynamic> json) {
    orderItemId = json['order_item_id'];
    sectionId = json['section_id'];
    sectionTitle = json['section_title'];
    sectionDesc = json['section_desc'];
    sectionPrice = json['section_price'];
    sectionImage = json['section_image'];
    quantity = json['quantity'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_item_id'] = this.orderItemId;
    data['section_id'] = this.sectionId;
    data['section_title'] = this.sectionTitle;
    data['section_desc'] = this.sectionDesc;
    data['section_price'] = this.sectionPrice;
    data['section_image'] = this.sectionImage;
    data['quantity'] = this.quantity;
    data['total'] = this.total;
    return data;
  }
}