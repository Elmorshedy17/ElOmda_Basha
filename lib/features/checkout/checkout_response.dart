class CheckoutResponse {
  int status;
  String message;
  Data data;

  CheckoutResponse({this.status, this.message, this.data});

  CheckoutResponse.fromJson(Map<String, dynamic> json) {
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
  int orderId;
  String paymentLink;

  Data({this.orderId, this.paymentLink});

  Data.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    paymentLink = json['payment_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['payment_link'] = this.paymentLink;
    return data;
  }
}
