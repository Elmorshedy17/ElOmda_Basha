class CouponResponse {
  int status;
  String message;
  Data data;

  CouponResponse({this.status, this.message, this.data});

  CouponResponse.fromJson(Map<String, dynamic> json) {
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
  String total;
  String delivery;
  String currency;

  Data({this.total, this.delivery, this.currency});

  Data.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    delivery = json['delivery'];
    currency = json['currency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['delivery'] = this.delivery;
    data['currency'] = this.currency;
    return data;
  }
}
