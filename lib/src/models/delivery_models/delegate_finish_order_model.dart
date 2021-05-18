class DelegateFinishOrderModel {
  String key;
  String msg;

  DelegateFinishOrderModel({this.key, this.msg});

  DelegateFinishOrderModel.fromJson(Map<String, dynamic> json) {
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
//class DelegateFinishOrderModel {
//  String key;
//  String msg;
//
//  DelegateFinishOrderModel({this.key, this.msg});
//
//  DelegateFinishOrderModel.fromJson(Map<String, dynamic> json) {
//    key = json['key'];
//    msg = json['msg'];
//  }
//
//  Map<String, dynamic> toJson() {
//    final Map<String, dynamic> data = new Map<String, dynamic>();
//    data['key'] = this.key;
//    data['msg'] = this.msg;
//    return data;
//  }
//}

