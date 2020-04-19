class ContactUsGetModel {
  int status;
  String message;
  Data data;

  ContactUsGetModel({this.status, this.message, this.data});

  ContactUsGetModel.fromJson(Map<String, dynamic> json) {
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
  List<ComplaintTypes> complaintTypes;

  Data({this.complaintTypes});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['complaint_types'] != null) {
      complaintTypes = new List<ComplaintTypes>();
      json['complaint_types'].forEach((v) {
        complaintTypes.add(new ComplaintTypes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.complaintTypes != null) {
      data['complaint_types'] =
          this.complaintTypes.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ComplaintTypes {
  int id;
  String name;

  ComplaintTypes({this.id, this.name});

  ComplaintTypes.fromJson(Map<String, dynamic> json) {
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