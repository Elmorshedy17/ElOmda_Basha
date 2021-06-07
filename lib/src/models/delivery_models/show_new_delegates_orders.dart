
class ShowNewDelegatesOrdersModel {
  String key;
  String msg;
  var variableRate;
  List<Data> data;

  ShowNewDelegatesOrdersModel(
      {this.key, this.msg, this.variableRate, this.data});

  ShowNewDelegatesOrdersModel.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    msg = json['msg'];
    variableRate = json['variable_rate'];
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
    data['variable_rate'] = this.variableRate;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
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
  String notes;
  String message;
  var deliveryForCountry;
  var totalForCountry;
  var delivery;
  var total;
  String newOrder;
  String cancel;
  String hasProvider;
  String inWay;
  String finish;
  int countryId;
  String countryTitle;
  String currencyCode;
  int cityId;
  String cityTitle;
  List<OrderItems> orderItems;
  List<OrderStatus> orderStatus;


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
        this.notes,
        this.message,
        this.deliveryForCountry,
        this.totalForCountry,
        this.delivery,
        this.total,
        this.newOrder,
        this.cancel,
        this.hasProvider,
        this.inWay,
        this.finish,
        this.countryId,
        this.countryTitle,
        this.currencyCode,
        this.cityId,
        this.cityTitle,
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
    lat = json['lat'];
    lng = json['lng'];
    notes = json['notes'];
    message = json['message'];
    deliveryForCountry = json['delivery_for_country'];
    totalForCountry = json['total_for_country'];
    delivery = json['delivery'];
    total = json['total'];
    newOrder = json['new_order'];
    cancel = json['cancel'];
    hasProvider = json['has_provider'];
    inWay = json['in_way'];
    finish = json['finish'];
    countryId = json['country_id'];
    countryTitle = json['country_title'];
    currencyCode = json['currency_code'];
    cityId = json['city_id'];
    cityTitle = json['city_title'];
    if (json['order_items'] != null) {
      orderItems = new List<OrderItems>();
      json['order_items'].forEach((v) {
        orderItems.add(new OrderItems.fromJson(v));
      });
      if (json['order_status'] != null) {
        orderStatus = new List<OrderStatus>();
        json['order_status'].forEach((v) {
          orderStatus.add(new OrderStatus.fromJson(v));
        });
      }
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
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['notes'] = this.notes;
    data['message'] = this.message;
    data['delivery_for_country'] = this.deliveryForCountry;
    data['total_for_country'] = this.totalForCountry;
    data['delivery'] = this.delivery;
    data['total'] = this.total;
    data['new_order'] = this.newOrder;
    data['cancel'] = this.cancel;
    data['has_provider'] = this.hasProvider;
    data['in_way'] = this.inWay;
    data['finish'] = this.finish;
    data['country_id'] = this.countryId;
    data['country_title'] = this.countryTitle;
    data['currency_code'] = this.currencyCode;
    data['city_id'] = this.cityId;
    data['city_title'] = this.cityTitle;
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

