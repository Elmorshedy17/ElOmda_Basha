import 'package:momentoo/shared/domain/user.dart';

class RegisterModel {
  int status;
  String message;
  Data data;

  RegisterModel({this.status, this.message, this.data});

  RegisterModel.fromJson(Map<String, dynamic> json) {
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
  User user;

  Data({this.user});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}

// class User {
//   int id;
//   String firstName;
//   String lastName;
//   String middleName;
//   String email;
//   String phone;
//   String authorization;
//   String address;

//   User(
//       {this.id,
//       this.firstName,
//       this.lastName,
//       this.middleName,
//       this.email,
//       this.phone,
//       this.authorization,
//       this.address});

//   User.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     firstName = json['first_name'];
//     lastName = json['last_name'];
//     middleName = json['middle_name'];
//     email = json['email'];
//     phone = json['phone'];
//     authorization = json['authorization'];
//     address = json['address'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['first_name'] = this.firstName;
//     data['last_name'] = this.lastName;
//     data['middle_name'] = this.middleName;
//     data['email'] = this.email;
//     data['phone'] = this.phone;
//     data['authorization'] = this.authorization;
//     data['address'] = this.address;
//     return data;
//   }
// }
