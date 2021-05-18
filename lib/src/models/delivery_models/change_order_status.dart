class ChangeOrderStatusModel {
  String key;
  String massage;

  ChangeOrderStatusModel({this.key, this.massage});

  ChangeOrderStatusModel.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    massage = json['massage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['massage'] = this.massage;
    return data;
  }
}