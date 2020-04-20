class SettingsModel {
  int status;
  String message;
  Data data;

  SettingsModel({this.status, this.message, this.data});

  SettingsModel.fromJson(Map<String, dynamic> json) {
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
  List<Pages> pages;
  Country country;
  String email;

  Data({this.pages, this.country, this.email});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['pages'] != null) {
      pages = new List<Pages>();
      json['pages'].forEach((v) {
        pages.add(new Pages.fromJson(v));
      });
    }
    country =
        json['country'] != null ? new Country.fromJson(json['country']) : null;
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pages != null) {
      data['pages'] = this.pages.map((v) => v.toJson()).toList();
    }
    if (this.country != null) {
      data['country'] = this.country.toJson();
    }
    data['email'] = this.email;
    return data;
  }
}

class Pages {
  String title;
  String content;

  Pages({this.title, this.content});

  Pages.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['content'] = this.content;
    return data;
  }
}

class Country {
  String name;

  Country({this.name});

  Country.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}
