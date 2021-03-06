class ShowCartModel {
  String key;
  String msg;
  var commission;
  var variableRate;
  Data data;

  ShowCartModel({this.key, this.msg, this.commission,this.variableRate, this.data});

  ShowCartModel.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    msg = json['msg'];
    commission = json['commission'];
    variableRate = json['variable_rate'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['msg'] = this.msg;
    data['commission'] = this.commission;
    data['variable_rate'] = this.variableRate;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  List<CartData> cartData;
  List<CountriesData> countriesData;

  Data({this.cartData, this.countriesData});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['cart_data'] != null) {
      cartData = new List<CartData>();
      json['cart_data'].forEach((v) {
        cartData.add(new CartData.fromJson(v));
      });
    }
    if (json['countries_data'] != null) {
      countriesData = new List<CountriesData>();
      json['countries_data'].forEach((v) {
        countriesData.add(new CountriesData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cartData != null) {
      data['cart_data'] = this.cartData.map((v) => v.toJson()).toList();
    }
    if (this.countriesData != null) {
      data['countries_data'] =
          this.countriesData.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CartData {
  int id;
  int sectionId;
  String sectionTitle;
  String sectionDesc;
  var sectionPrice;
  var sectionQuantity;
  String sectionImage;
  var quantity;
  var total;

  CartData(
      {this.id,
        this.sectionId,
        this.sectionTitle,
        this.sectionDesc,
        this.sectionPrice,
        this.sectionQuantity,
        this.sectionImage,
        this.quantity,
        this.total});

  CartData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sectionId = json['section_id'];
    sectionTitle = json['section_title'];
    sectionDesc = json['section_desc'];
    sectionPrice = json['section_price'];
    sectionQuantity = json['section_quantity'];
    sectionImage = json['section_image'];
    quantity = json['quantity'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['section_id'] = this.sectionId;
    data['section_title'] = this.sectionTitle;
    data['section_desc'] = this.sectionDesc;
    data['section_price'] = this.sectionPrice;
    data['section_quantity'] = this.sectionQuantity;
    data['section_image'] = this.sectionImage;
    data['quantity'] = this.quantity;
    data['total'] = this.total;
    return data;
  }
}

// class CountriesData {
//   int id;
//   String title;
//   List<Cities> cities;
//
//   CountriesData({this.id, this.title, this.cities});
//
//   CountriesData.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     title = json['title'];
//     if (json['cities'] != null) {
//       cities = new List<Cities>();
//       json['cities'].forEach((v) {
//         cities.add(new Cities.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['title'] = this.title;
//     if (this.cities != null) {
//       data['cities'] = this.cities.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }


class CountriesData {
  int id;
  String title;
  var code;
  String currencyCode;
  var rateToSar;
  List<Cities> cities;

  CountriesData(
      {this.id,
        this.title,
        this.code,
        this.currencyCode,
        this.rateToSar,
        this.cities});

  CountriesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    code = json['code'];
    currencyCode = json['currency_code'];
    rateToSar = json['rate_to_sar'];
    if (json['cities'] != null) {
      cities = new List<Cities>();
      json['cities'].forEach((v) {
        cities.add(new Cities.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['code'] = this.code;
    data['currency_code'] = this.currencyCode;
    data['rate_to_sar'] = this.rateToSar;
    if (this.cities != null) {
      data['cities'] = this.cities.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Cities {
  int id;
  String title;

  Cities({this.id, this.title});

  Cities.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    return data;
  }
}

// class Cities {
//   int id;
//   String title;
//
//   Cities({this.id, this.title});
//
//   Cities.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     title = json['title'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['title'] = this.title;
//     return data;
//   }
// }

