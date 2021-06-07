

class StoreOrderModel {
  var key;
  String msg;
  var variableRate;
  Data data;

  StoreOrderModel({this.key, this.msg, this.variableRate, this.data});

  StoreOrderModel.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    msg = json['msg'];
    variableRate = json['variable_rate'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['msg'] = this.msg;
    data['variable_rate'] = this.variableRate;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  int id;
  String status;
  String name;
  String phone;
  String whatsapp;
  String date;
  String time;
  String address;
  var lat;
  var lng;
  var delivery;
  var total;
  var marketerBenfit;
  var marketerCommission;
  var marketerPoint;
  String newOrder;
  String cancel;
  String hasProvider;
  String inWay;
  String finish;
  String countryTitle;
  String currencyCode;
  String cityTitle;
  String delegateName;
  String delegatePhone;
  String delegateWhatsapp;
  String delegateAvatar;
  var totalForCountry;
  List<OrderStatus> orderStatus;
  List<OrderItems> orderItems;

  Data(
      {this.id,
        this.status,
        this.name,
        this.phone,
        this.whatsapp,
        this.date,
        this.time,
        this.address,
        this.lat,
        this.lng,
        this.totalForCountry,
        this.delivery,
        this.total,
        this.marketerBenfit,
        this.marketerCommission,
        this.marketerPoint,
        this.newOrder,
        this.cancel,
        this.hasProvider,
        this.inWay,
        this.finish,
        this.countryTitle,
        this.cityTitle,
        this.delegateName,
        this.delegatePhone,
        this.currencyCode,
        this.delegateWhatsapp,
        this.delegateAvatar,
        this.orderStatus,

        this.orderItems});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    name = json['name'];
    phone = json['phone'];
    whatsapp = json['whatsapp'];
    date = json['date'];
    time = json['time'];
    address = json['address'];
    totalForCountry = json['total_for_country'];
    lat = json['lat'];
    lng = json['lng'];
    delivery = json['delivery'];
    total = json['total'];
    marketerBenfit = json['marketer_benfit'];
    marketerCommission = json['marketer_commission'];
    marketerPoint = json['marketer_point'];
    newOrder = json['new_order'];
    cancel = json['cancel'];
    hasProvider = json['has_provider'];
    inWay = json['in_way'];
    finish = json['finish'];
    countryTitle = json['country_title'];
    cityTitle = json['city_title'];
    delegateName = json['delegate_name'];
    currencyCode = json['currency_code'];
    delegatePhone = json['delegate_phone'];
    delegateWhatsapp = json['delegate_whatsapp'];
    delegateAvatar = json['delegate_avatar'];
    if (json['order_items'] != null) {
      orderItems = new List<OrderItems>();
      json['order_items'].forEach((v) {
        orderItems.add(new OrderItems.fromJson(v));
      });
    }
    if (json['order_status'] != null) {
      orderStatus = new List<OrderStatus>();
      json['order_status'].forEach((v) {
        orderStatus.add(new OrderStatus.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['whatsapp'] = this.whatsapp;
    data['date'] = this.date;
    data['time'] = this.time;
    data['address'] = this.address;
    data['total_for_country'] = this.totalForCountry;
    data['currency_code'] = this.currencyCode;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['delivery'] = this.delivery;
    data['total'] = this.total;
    data['marketer_benfit'] = this.marketerBenfit;
    data['marketer_commission'] = this.marketerCommission;
    data['marketer_point'] = this.marketerPoint;
    data['new_order'] = this.newOrder;
    data['cancel'] = this.cancel;
    data['has_provider'] = this.hasProvider;
    data['in_way'] = this.inWay;
    data['finish'] = this.finish;
    data['country_title'] = this.countryTitle;
    data['city_title'] = this.cityTitle;
    data['delegate_name'] = this.delegateName;
    data['delegate_phone'] = this.delegatePhone;
    data['delegate_whatsapp'] = this.delegateWhatsapp;
    data['delegate_avatar'] = this.delegateAvatar;
    if (this.orderItems != null) {
      data['order_items'] = this.orderItems.map((v) => v.toJson()).toList();
    }
    if (this.orderStatus != null) {
      data['order_status'] = this.orderStatus.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderItems {
  var orderItemId;
  var sectionId;
  String sectionTitle;
  String sectionDesc;
  var sectionPrice;
  String sectionImage;
  var total;
  var buyTotal;
  var giftTotal;
  var giftCount;
  var commission;
  var point;
  var benfit;
  var quantity;

  OrderItems(
      {this.orderItemId,
        this.sectionId,
        this.sectionTitle,
        this.sectionDesc,
        this.sectionPrice,
        this.sectionImage,
        this.total,
        this.buyTotal,
        this.giftTotal,
        this.giftCount,
        this.commission,
        this.point,
        this.benfit,
        this.quantity});

  OrderItems.fromJson(Map<String, dynamic> json) {
    orderItemId = json['order_item_id'];
    sectionId = json['section_id'];
    sectionTitle = json['section_title'];
    sectionDesc = json['section_desc'];
    sectionPrice = json['section_price'];
    sectionImage = json['section_image'];
    total = json['total'];
    buyTotal = json['buy_total'];
    giftTotal = json['gift_total'];
    giftCount = json['gift_count'];
    commission = json['commission'];
    point = json['point'];
    benfit = json['benfit'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_item_id'] = this.orderItemId;
    data['section_id'] = this.sectionId;
    data['section_title'] = this.sectionTitle;
    data['section_desc'] = this.sectionDesc;
    data['section_price'] = this.sectionPrice;
    data['section_image'] = this.sectionImage;
    data['total'] = this.total;
    data['buy_total'] = this.buyTotal;
    data['gift_total'] = this.giftTotal;
    data['gift_count'] = this.giftCount;
    data['commission'] = this.commission;
    data['point'] = this.point;
    data['benfit'] = this.benfit;
    data['quantity'] = this.quantity;
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
