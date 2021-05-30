class DelegateFinishOrderModel {
  String key;
  String msg;
  var variableRate;
  var download;

  DelegateFinishOrderModel({this.key, this.msg,this.variableRate,this.download});

  DelegateFinishOrderModel.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    msg = json['msg'];
    variableRate = json['variable_rate'];
    download = json['download'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['msg'] = this.msg;
    data['variable_rate'] = this.variableRate;
    data['download'] = this.download;
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

