class SendServiceRequestModel {
  String key;
  String msg;

  SendServiceRequestModel({this.key, this.msg});

  SendServiceRequestModel.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['msg'] = this.msg;
    return data;
  }
}