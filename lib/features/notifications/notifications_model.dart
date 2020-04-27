class NotificationsModel {
  int status;
  String message;
  Data data;

  NotificationsModel({this.status, this.message, this.data});

  NotificationsModel.fromJson(Map<String, dynamic> json) {
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
  Notifications notifications;

  Data({this.notifications});

  Data.fromJson(Map<String, dynamic> json) {
    notifications = json['notifications'] != null
        ? new Notifications.fromJson(json['notifications'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.notifications != null) {
      data['notifications'] = this.notifications.toJson();
    }
    return data;
  }
}

class Notifications {
  int currentPage;
  String firstPageUrl;
  int lastPage;
  String lastPageUrl;
  String nextPageUrl;
  String path;
  int perPage;
  String prevPageUrl;
  int to;
  int total;
  List<NotificationsData> data;

  Notifications(
      {this.currentPage,
      this.firstPageUrl,
      this.lastPage,
      this.lastPageUrl,
      this.nextPageUrl,
      this.path,
      this.perPage,
      this.prevPageUrl,
      this.to,
      this.total,
      this.data});

  Notifications.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    firstPageUrl = json['first_page_url'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
    if (json['data'] != null) {
      data = new List<NotificationsData>();
      json['data'].forEach((v) {
        data.add(new NotificationsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    data['first_page_url'] = this.firstPageUrl;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NotificationsData {
  int id;
  String message;
  int orderId;
  String date;

  NotificationsData({this.id, this.message, this.orderId, this.date});

  NotificationsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    message = json['message'];
    orderId = json['order_id'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['message'] = this.message;
    data['order_id'] = this.orderId;
    data['date'] = this.date;
    return data;
  }
}
