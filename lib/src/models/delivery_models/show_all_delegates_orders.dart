class ShowAllDelegatesOrdersModel {
  String key;
  String msg;
  var variableRate;
  var download;
  Data data;

  ShowAllDelegatesOrdersModel(
      {this.key, this.msg, this.variableRate, this.data,this.download});

  ShowAllDelegatesOrdersModel.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    msg = json['msg'];
    variableRate = json['variable_rate'];
    download = json['download'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['msg'] = this.msg;
    data['variable_rate'] = this.variableRate;
    data['download'] = this.download;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  List<DataInner> dataInner;
  Pagination pagination;

  Data({this.dataInner, this.pagination});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      dataInner = new List<DataInner>();
      json['data'].forEach((v) {
        dataInner.add(new DataInner.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dataInner != null) {
      data['data'] = this.dataInner.map((v) => v.toJson()).toList();
    }
    if (this.pagination != null) {
      data['pagination'] = this.pagination.toJson();
    }
    return data;
  }
}

class DataInner {
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
  var marketerBenfit;
  var marketerCommission;
  var marketerPoint;
  String newOrder;
  String cancel;
  String hasProvider;
  String inWay;
  String finish;
  var countryId;
  String countryTitle;
  String currencyCode;
  var cityId;
  String cityTitle;
  String delegateName;
  String delegatePhone;
  String delegateWhatsapp;
  String delegateAvatar;
  List<OrderStatus> orderStatus;
  List<OrderItems> orderItems;

  DataInner(
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
        this.marketerBenfit,
        this.marketerCommission,
        this.marketerPoint,
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
        this.delegateName,
        this.delegatePhone,
        this.delegateWhatsapp,
        this.delegateAvatar,
        this.orderStatus,
        this.orderItems});

  DataInner.fromJson(Map<String, dynamic> json) {
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
    marketerBenfit = json['marketer_benfit'];
    marketerCommission = json['marketer_commission'];
    marketerPoint = json['marketer_point'];
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
    delegateName = json['delegate_name'];
    delegatePhone = json['delegate_phone'];
    delegateWhatsapp = json['delegate_whatsapp'];
    delegateAvatar = json['delegate_avatar'];
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
    data['marketer_benfit'] = this.marketerBenfit;
    data['marketer_commission'] = this.marketerCommission;
    data['marketer_point'] = this.marketerPoint;
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
    data['delegate_name'] = this.delegateName;
    data['delegate_phone'] = this.delegatePhone;
    data['delegate_whatsapp'] = this.delegateWhatsapp;
    data['delegate_avatar'] = this.delegateAvatar;
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

// class OrderItems {
//   int orderItemId;
//   int sectionId;
//   String sectionTitle;
//   String sectionDesc;
//   int sectionPrice;
//   String sectionImage;
//   int quantity;
//   int total;
//
//   OrderItems(
//       {this.orderItemId,
//         this.sectionId,
//         this.sectionTitle,
//         this.sectionDesc,
//         this.sectionPrice,
//         this.sectionImage,
//         this.quantity,
//         this.total});
//
//   OrderItems.fromJson(Map<String, dynamic> json) {
//     orderItemId = json['order_item_id'];
//     sectionId = json['section_id'];
//     sectionTitle = json['section_title'];
//     sectionDesc = json['section_desc'];
//     sectionPrice = json['section_price'];
//     sectionImage = json['section_image'];
//     quantity = json['quantity'];
//     total = json['total'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['order_item_id'] = this.orderItemId;
//     data['section_id'] = this.sectionId;
//     data['section_title'] = this.sectionTitle;
//     data['section_desc'] = this.sectionDesc;
//     data['section_price'] = this.sectionPrice;
//     data['section_image'] = this.sectionImage;
//     data['quantity'] = this.quantity;
//     data['total'] = this.total;
//     return data;
//   }
// }


class Pagination {
  var total;
  var count;
  var perPage;
  var currentPage;
  var lastPage;
  String nextPageUrl;
  String previousPageUrl;

  Pagination(
      {this.total,
        this.count,
        this.perPage,
        this.currentPage,
        this.lastPage,
        this.nextPageUrl,
        this.previousPageUrl});

  Pagination.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    count = json['count'];
    perPage = json['per_page'];
    currentPage = json['current_page'];
    lastPage = json['last_page'];
    nextPageUrl = json['next_page_url'];
    previousPageUrl = json['previous_page_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['count'] = this.count;
    data['per_page'] = this.perPage;
    data['current_page'] = this.currentPage;
    data['last_page'] = this.lastPage;
    data['next_page_url'] = this.nextPageUrl;
    data['previous_page_url'] = this.previousPageUrl;
    return data;
  }
}
