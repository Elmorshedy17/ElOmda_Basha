class UserProfileModel {
  String key;
  String msg;
  Data data;

  UserProfileModel({this.key, this.msg, this.data});

  UserProfileModel.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['msg'] = this.msg;
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
  int totalDelivery;
  int total;
  int debt;
  int totalCommission;
  int doneCommission;
  int needCommission;
  int totalPoint;
  int donePoint;
  int needPoint;
  int totalGifts;
  int doneGifts;
  int needGifts;
  int countryId;
  String countryTitle;
  int cityId;
  String cityTitle;
  String lang;
  bool isConfirm;
  bool isActive;
  bool isBlocked;
  String avatar;
  var accountNumber;

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
        this.totalDelivery,
        this.total,
        this.debt,
        this.totalCommission,
        this.doneCommission,
        this.needCommission,
        this.totalPoint,
        this.donePoint,
        this.needPoint,
        this.totalGifts,
        this.doneGifts,
        this.needGifts,
        this.countryId,
        this.countryTitle,
        this.cityId,
        this.cityTitle,
        this.lang,
        this.isConfirm,
        this.isActive,
        this.isBlocked,
        this.accountNumber,
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
    totalDelivery = json['total_delivery'];
    total = json['total'];
    debt = json['debt'];
    totalCommission = json['total_commission'];
    doneCommission = json['done_commission'];
    needCommission = json['need_commission'];
    totalPoint = json['total_point'];
    donePoint = json['done_point'];
    needPoint = json['need_point'];
    totalGifts = json['total_gifts'];
    doneGifts = json['done_gifts'];
    needGifts = json['need_gifts'];
    countryId = json['country_id'];
    countryTitle = json['country_title'];
    cityId = json['city_id'];
    cityTitle = json['city_title'];
    lang = json['lang'];
    isConfirm = json['is_confirm'];
    isActive = json['is_active'];
    isBlocked = json['is_blocked'];
    avatar = json['avatar'];
    accountNumber = json['account_number'];
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
    data['total_delivery'] = this.totalDelivery;
    data['total'] = this.total;
    data['debt'] = this.debt;
    data['total_commission'] = this.totalCommission;
    data['done_commission'] = this.doneCommission;
    data['need_commission'] = this.needCommission;
    data['total_point'] = this.totalPoint;
    data['done_point'] = this.donePoint;
    data['need_point'] = this.needPoint;
    data['total_gifts'] = this.totalGifts;
    data['done_gifts'] = this.doneGifts;
    data['need_gifts'] = this.needGifts;
    data['country_id'] = this.countryId;
    data['country_title'] = this.countryTitle;
    data['city_id'] = this.cityId;
    data['city_title'] = this.cityTitle;
    data['lang'] = this.lang;
    data['is_confirm'] = this.isConfirm;
    data['is_active'] = this.isActive;
    data['is_blocked'] = this.isBlocked;
    data['avatar'] = this.avatar;
    data['account_number'] = this.accountNumber;
    return data;
  }
}
// class UserProfileModel {
//   String key;
//   String msg;
//   Data data;
//
//   UserProfileModel({this.key, this.msg, this.data});
//
//   UserProfileModel.fromJson(Map<String, dynamic> json) {
//     key = json['key'];
//     msg = json['msg'];
//     data = json['data'] != null ? new Data.fromJson(json['data']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['key'] = this.key;
//     data['msg'] = this.msg;
//     if (this.data != null) {
//       data['data'] = this.data.toJson();
//     }
//     return data;
//   }
// }
//
// class Data {
//   int id;
//   String name;
//   String firstName;
//   String lastName;
//   String email;
//   String phone;
//   String phoneCode;
//   String whatsapp;
//   String whatsappCode;
//   String userType;
//   String benfitType;
//   int totalCommission;
//   int doneCommission;
//   int needCommission;
//   int totalPoint;
//   int donePoint;
//   int needPoint;
//   int totalGifts;
//   int doneGifts;
//   int needGifts;
//   int countryId;
//   String countryTitle;
//   int cityId;
//   String cityTitle;
//   String lang;
//   bool isConfirm;
//   bool isActive;
//   bool isBlocked;
//   String avatar;
//
//   Data(
//       {this.id,
//         this.name,
//         this.firstName,
//         this.lastName,
//         this.email,
//         this.phone,
//         this.phoneCode,
//         this.whatsapp,
//         this.whatsappCode,
//         this.userType,
//         this.benfitType,
//         this.totalCommission,
//         this.doneCommission,
//         this.needCommission,
//         this.totalPoint,
//         this.donePoint,
//         this.needPoint,
//         this.totalGifts,
//         this.doneGifts,
//         this.needGifts,
//         this.countryId,
//         this.countryTitle,
//         this.cityId,
//         this.cityTitle,
//         this.lang,
//         this.isConfirm,
//         this.isActive,
//         this.isBlocked,
//         this.avatar});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     firstName = json['first_name'];
//     lastName = json['last_name'];
//     email = json['email'];
//     phone = json['phone'];
//     phoneCode = json['phone_code'];
//     whatsapp = json['whatsapp'];
//     whatsappCode = json['whatsapp_code'];
//     userType = json['user_type'];
//     benfitType = json['benfit_type'];
//     totalCommission = json['total_commission'];
//     doneCommission = json['done_commission'];
//     needCommission = json['need_commission'];
//     totalPoint = json['total_point'];
//     donePoint = json['done_point'];
//     needPoint = json['need_point'];
//     totalGifts = json['total_gifts'];
//     doneGifts = json['done_gifts'];
//     needGifts = json['need_gifts'];
//     countryId = json['country_id'];
//     countryTitle = json['country_title'];
//     cityId = json['city_id'];
//     cityTitle = json['city_title'];
//     lang = json['lang'];
//     isConfirm = json['is_confirm'];
//     isActive = json['is_active'];
//     isBlocked = json['is_blocked'];
//     avatar = json['avatar'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['first_name'] = this.firstName;
//     data['last_name'] = this.lastName;
//     data['email'] = this.email;
//     data['phone'] = this.phone;
//     data['phone_code'] = this.phoneCode;
//     data['whatsapp'] = this.whatsapp;
//     data['whatsapp_code'] = this.whatsappCode;
//     data['user_type'] = this.userType;
//     data['benfit_type'] = this.benfitType;
//     data['total_commission'] = this.totalCommission;
//     data['done_commission'] = this.doneCommission;
//     data['need_commission'] = this.needCommission;
//     data['total_point'] = this.totalPoint;
//     data['done_point'] = this.donePoint;
//     data['need_point'] = this.needPoint;
//     data['total_gifts'] = this.totalGifts;
//     data['done_gifts'] = this.doneGifts;
//     data['need_gifts'] = this.needGifts;
//     data['country_id'] = this.countryId;
//     data['country_title'] = this.countryTitle;
//     data['city_id'] = this.cityId;
//     data['city_title'] = this.cityTitle;
//     data['lang'] = this.lang;
//     data['is_confirm'] = this.isConfirm;
//     data['is_active'] = this.isActive;
//     data['is_blocked'] = this.isBlocked;
//     data['avatar'] = this.avatar;
//     return data;
//   }
// }