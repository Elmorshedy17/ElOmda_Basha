class UpdatePasswordModel {
  String key;
  String msg;

  UpdatePasswordModel({this.key, this.msg});

  UpdatePasswordModel.fromJson(Map<String, dynamic> json) {
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