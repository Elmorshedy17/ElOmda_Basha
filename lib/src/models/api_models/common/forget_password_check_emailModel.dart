class ForgetPasswordModel {
  String key;
  String msg;
  String status;
  Data data;

  ForgetPasswordModel({this.key, this.msg, this.status, this.data});

  ForgetPasswordModel.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    msg = json['msg'];
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['msg'] = this.msg;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  int id;
  String name;
  String firstName;
  String lastName;
  String email;
  String phone;
  String phoneCode;
  String whatsapp;
  String whatsappCode;
  String userType;
  String benfitType;
  var commission;
  var point;
  String lang;
  bool isConfirm;
  bool isActive;
  bool isBlocked;
  String avatar;

  Data(
      {this.id,
        this.name,
        this.firstName,
        this.lastName,
        this.email,
        this.phone,
        this.phoneCode,
        this.whatsapp,
        this.whatsappCode,
        this.userType,
        this.benfitType,
        this.commission,
        this.point,
        this.lang,
        this.isConfirm,
        this.isActive,
        this.isBlocked,
        this.avatar});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    phone = json['phone'];
    phoneCode = json['phone_code'];
    whatsapp = json['whatsapp'];
    whatsappCode = json['whatsapp_code'];
    userType = json['user_type'];
    benfitType = json['benfit_type'];
    commission = json['commission'];
    point = json['point'];
    lang = json['lang'];
    isConfirm = json['is_confirm'];
    isActive = json['is_active'];
    isBlocked = json['is_blocked'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['phone_code'] = this.phoneCode;
    data['whatsapp'] = this.whatsapp;
    data['whatsapp_code'] = this.whatsappCode;
    data['user_type'] = this.userType;
    data['benfit_type'] = this.benfitType;
    data['commission'] = this.commission;
    data['point'] = this.point;
    data['lang'] = this.lang;
    data['is_confirm'] = this.isConfirm;
    data['is_active'] = this.isActive;
    data['is_blocked'] = this.isBlocked;
    data['avatar'] = this.avatar;
    return data;
  }
}