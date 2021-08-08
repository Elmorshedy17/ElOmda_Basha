class AllNotificationShowModel {
  String key;
  String msg;
  int notificationCount;
  Data data;

  AllNotificationShowModel(
      {this.key, this.msg, this.notificationCount, this.data});

  AllNotificationShowModel.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    msg = json['msg'];
    notificationCount = json['notification_count'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['msg'] = this.msg;
    data['notification_count'] = this.notificationCount;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  List<InnerData> innerData;
  Pagination pagination;

  Data({this.innerData, this.pagination});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      innerData = new List<InnerData>();
      json['data'].forEach((v) {
        innerData.add(new InnerData.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.innerData != null) {
      data['data'] = this.innerData.map((v) => v.toJson()).toList();
    }
    if (this.pagination != null) {
      data['pagination'] = this.pagination.toJson();
    }
    return data;
  }
}

class InnerData {
  int id;
  String message;
  String type;
  String userName;
  String userAvatar;
  String orderId;
  String orderNumber;
  String date;
  String dateFrom;

  InnerData(
      {this.id,
        this.message,
        this.type,
        this.userName,
        this.userAvatar,
        this.orderId,
        this.orderNumber,
        this.date,
        this.dateFrom});

  InnerData.fromJson(Map<String, dynamic> json) {
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

class Pagination {
  int total;
  int count;
  int perPage;
  int currentPage;
  int lastPage;
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
