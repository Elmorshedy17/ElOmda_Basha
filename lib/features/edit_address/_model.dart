class AddressesInfoModel {
  int status;
  String message;
  Data data;

  AddressesInfoModel({this.status, this.message, this.data});

  AddressesInfoModel.fromJson(Map<String, dynamic> json) {
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
  Address address;
  List<Cities> cities;
  Country country;

  Data({this.address, this.cities, this.country});

  Data.fromJson(Map<String, dynamic> json) {
    address =
    json['address'] != null ? new Address.fromJson(json['address']) : null;
    if (json['cities'] != null) {
      cities = new List<Cities>();
      json['cities'].forEach((v) {
        cities.add(new Cities.fromJson(v));
      });
    }
    country =
    json['country'] != null ? new Country.fromJson(json['country']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.address != null) {
      data['address'] = this.address.toJson();
    }
    if (this.cities != null) {
      data['cities'] = this.cities.map((v) => v.toJson()).toList();
    }
    if (this.country != null) {
      data['country'] = this.country.toJson();
    }
    return data;
  }
}

class Address {
  int id;
  int cityId;
  String block;
  String street;
  String street2;
  String building;
  String floor;
  String jadda;
  String flat;
  String notes;

  Address(
      {this.id,
        this.cityId,
        this.block,
        this.street,
        this.street2,
        this.building,
        this.floor,
        this.jadda,
        this.flat,
        this.notes});

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cityId = json['city_id'];
    block = json['block'];
    street = json['street'];
    street2 = json['street_2'];
    building = json['building'];
    floor = json['floor'];
    jadda = json['jadda'];
    flat = json['flat'];
    notes = json['notes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['city_id'] = this.cityId;
    data['block'] = this.block;
    data['street'] = this.street;
    data['street_2'] = this.street2;
    data['building'] = this.building;
    data['floor'] = this.floor;
    data['jadda'] = this.jadda;
    data['flat'] = this.flat;
    data['notes'] = this.notes;
    return data;
  }
}

class Cities {
  int id;
  String name;

  Cities({this.id, this.name});

  Cities.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
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