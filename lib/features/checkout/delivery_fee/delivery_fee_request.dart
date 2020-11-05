class DeliveryFeeRequest {
  String sellerId;
  String cityId;

  DeliveryFeeRequest({this.sellerId, this.cityId});

  DeliveryFeeRequest.fromJson(Map<String, dynamic> json) {
    sellerId = json['seller_id'];
    cityId = json['city_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['seller_id'] = this.sellerId;
    data['city_id'] = this.cityId;
    return data;
  }
}
