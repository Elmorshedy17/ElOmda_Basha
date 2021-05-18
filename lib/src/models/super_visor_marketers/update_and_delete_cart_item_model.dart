class UpdateDeleteModel {
  String key;
  String msg;
  Data data;

  UpdateDeleteModel({this.key, this.msg, this.data});

  UpdateDeleteModel.fromJson(Map<String, dynamic> json) {
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
  int sectionId;
  String sectionTitle;
  String sectionDesc;
  int sectionPrice;
  int sectionQuantity;
  String sectionImage;
  int quantity;
  int total;

  Data(
      {this.id,
        this.sectionId,
        this.sectionTitle,
        this.sectionDesc,
        this.sectionPrice,
        this.sectionQuantity,
        this.sectionImage,
        this.quantity,
        this.total});

  Data.fromJson(Map<String, dynamic> json) {
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