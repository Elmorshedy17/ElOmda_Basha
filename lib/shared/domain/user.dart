class User {
  int id;
  String firstName;
  String lastName;
  String middleName;
  String email;
  String phone;
  String authorization;
  String address;

  User(
      {this.id,
      this.firstName,
      this.lastName,
      this.middleName,
      this.email,
      this.phone,
      this.authorization,
      this.address});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    middleName = json['middle_name'];
    email = json['email'];
    phone = json['phone'];
    authorization = json['authorization'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['middle_name'] = this.middleName;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['authorization'] = this.authorization;
    data['address'] = this.address;
    return data;
  }
}
