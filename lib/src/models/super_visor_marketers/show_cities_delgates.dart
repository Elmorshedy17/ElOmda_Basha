class ShowCitiesDelegatesModel {
  String key;
  String msg;
  List<Data> data;

  ShowCitiesDelegatesModel({this.key, this.msg, this.data});

  ShowCitiesDelegatesModel.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int id;
  String title;
  int count;
  List<Delegates> delegates;

  Data({this.id, this.title, this.count, this.delegates});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    count = json['count'];
    if (json['delegates'] != null) {
      delegates = new List<Delegates>();
      json['delegates'].forEach((v) {
        delegates.add(new Delegates.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['count'] = this.count;
    if (this.delegates != null) {
      data['delegates'] = this.delegates.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Delegates {
  int id;
  String name;
  String firstName;
  String lastName;
  String email;
  String phone;
  String phoneCode;
  String whatsapp;
  String whatsappCode;
  String accountNumber;
  String userType;
  var countryId;
  String countryTitle;
  var cityId;
  String cityTitle;
  String avatar;

  Delegates(
      {this.id,
        this.name,
        this.firstName,
        this.lastName,
        this.email,
        this.phone,
        this.phoneCode,
        this.whatsapp,
        this.whatsappCode,
        this.accountNumber,
        this.userType,
        this.countryId,
        this.countryTitle,
        this.cityId,
        this.cityTitle,
        this.avatar});

  Delegates.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    phone = json['phone'];
    phoneCode = json['phone_code'];
    whatsapp = json['whatsapp'];
    whatsappCode = json['whatsapp_code'];
    accountNumber = json['account_number'];
    userType = json['user_type'];
    countryId = json['country_id'];
    countryTitle = json['country_title'];
    cityId = json['city_id'];
    cityTitle = json['city_title'];
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
    data['account_number'] = this.accountNumber;
    data['user_type'] = this.userType;
    data['country_id'] = this.countryId;
    data['country_title'] = this.countryTitle;
    data['city_id'] = this.cityId;
    data['city_title'] = this.cityTitle;
    data['avatar'] = this.avatar;
    return data;
  }
}
