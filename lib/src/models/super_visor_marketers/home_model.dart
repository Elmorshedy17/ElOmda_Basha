// class HomeModel {
//   String key;
//   String msg;
//   Data data;
//
//   HomeModel({this.key, this.msg, this.data});
//
//   HomeModel.fromJson(Map<String, dynamic> json) {
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
//   int notificationCount;
//   List<SectionData> sectionData;
//
//   Data({this.notificationCount, this.sectionData});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     notificationCount = json['notification_count'];
//     if (json['section_data'] != null) {
//       sectionData = new List<SectionData>();
//       json['section_data'].forEach((v) {
//         sectionData.add(new SectionData.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['notification_count'] = this.notificationCount;
//     if (this.sectionData != null) {
//       data['section_data'] = this.sectionData.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class SectionData {
//   int id;
//   String title;
//   String desc;
//   var price;
//   var quantity;
//   String image;
//
//   SectionData(
//       {this.id, this.title, this.desc, this.price, this.quantity, this.image});
//
//   SectionData.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     title = json['title'];
//     desc = json['desc'];
//     price = json['price'];
//     quantity = json['quantity'];
//     image = json['image'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['title'] = this.title;
//     data['desc'] = this.desc;
//     data['price'] = this.price;
//     data['quantity'] = this.quantity;
//     data['image'] = this.image;
//     return data;
//   }
// }

class HomeModel {
  String key;
  String msg;
  Data data;

  HomeModel({this.key, this.msg, this.data});

  HomeModel.fromJson(Map<String, dynamic> json) {
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
  int notificationCount;
  List<SectionData> sectionData;

  Data({this.notificationCount, this.sectionData});

  Data.fromJson(Map<String, dynamic> json) {
    notificationCount = json['notification_count'];
    if (json['section_data'] != null) {
      sectionData = new List<SectionData>();
      json['section_data'].forEach((v) {
        sectionData.add(new SectionData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['notification_count'] = this.notificationCount;
    if (this.sectionData != null) {
      data['section_data'] = this.sectionData.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SectionData {
  var id;
  String title;
  String desc;
  var price;
  var totalForCountry;
  String currencyCode;
  var quantity;
  String image;

  SectionData(
      {this.id,
        this.title,
        this.desc,
        this.price,
        this.totalForCountry,
        this.currencyCode,
        this.quantity,
        this.image});

  SectionData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    desc = json['desc'];
    price = json['price'];
    totalForCountry = json['total_for_country'];
    currencyCode = json['currency_code'];
    quantity = json['quantity'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['desc'] = this.desc;
    data['price'] = this.price;
    data['total_for_country'] = this.totalForCountry;
    data['currency_code'] = this.currencyCode;
    data['quantity'] = this.quantity;
    data['image'] = this.image;
    return data;
  }
}
