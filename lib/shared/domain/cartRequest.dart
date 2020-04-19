class LocalCart {
  int sellerId;
  List<Products> products;

  LocalCart({this.sellerId = -1, this.products}) {
    this.products = List<Products>();
  }

  addToProducts(Products product) => products.add(product);
  removeFromProducts(Products product) => products.add(product);

  LocalCart.fromJson(Map<String, dynamic> json) {
    sellerId = json['seller_id'];
    if (json['products'] != null) {
      products = new List<Products>();
      json['products'].forEach((v) {
        products.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['seller_id'] = this.sellerId;
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  int productId;
  int count;
  String options;
  String notes;

  Products({this.productId, this.count, this.options, this.notes});

  Products.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    count = json['count'];
    options = json['options'];
    notes = json['notes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['count'] = this.count;
    data['options'] = this.options;
    data['notes'] = this.notes;
    return data;
  }
}

// class LocalCart {
//   int sellerId;
//   List<Products> products;
//   //  = List<Products>();

//   LocalCart({this.sellerId, this.products}) {
//     this.products = List<Products>();
//   }

//   addToProducts(Products product) => products.add(product);
//   removeFromProducts(Products product) => products.add(product);

//   LocalCart.fromJson(Map<String, dynamic> json) {
//     sellerId = json['seller_id'];
//     if (json['products'] != null) {
//       products = new List<Products>();
//       json['products'].forEach((v) {
//         products.add(new Products.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['seller_id'] = this.sellerId;
//     if (this.products != null) {
//       data['products'] = this.products.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class Products {
//   int productId;
//   int count;
//   List<int> options;
//   // int options;
//   String notes;

//   Products({this.productId, this.count, this.options, this.notes}) {
//     this.options = List<int>();
//   }

//   Products.fromJson(Map<String, dynamic> json) {
//     productId = json['product_id'];
//     count = json['count'];
//     // options = json['options'];
//     options = json['options'].cast<int>();
//     notes = json['notes'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['product_id'] = this.productId;
//     data['count'] = this.count;
//     data['options'] = this.options;
//     data['notes'] = this.notes;
//     return data;
//   }
// }

// class LocalCart {
//   int sellerId;
//   List<Products> products;

//   LocalCart({this.sellerId, this.products}) {
//     this.products = List<Products>();
//   }

//   LocalCart.fromJson(Map<String, dynamic> json) {
//     sellerId = json['seller_id'];
//     if (json['products'] != null) {
//       products = new List<Products>();
//       json['products'].forEach((v) {
//         products.add(new Products.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['seller_id'] = this.sellerId;
//     if (this.products != null) {
//       data['products'] = this.products.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class Products {
//   int productId;
//   int count;
//   OptionsIds options;
//   String notes;

//   Products({this.productId, this.count, this.options, this.notes}) {
//     this.options = OptionsIds(ids: []);
//   }

//   Products.fromJson(Map<String, dynamic> json) {
//     productId = json['product_id'];
//     count = json['count'];
//     options = json['options'] != null
//         ? new OptionsIds.fromJson(json['options'])
//         : null;
//     notes = json['notes'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['product_id'] = this.productId;
//     data['count'] = this.count;
//     if (this.options != null) {
//       data['options'] = this.options.toJson();
//     }
//     data['notes'] = this.notes;
//     return data;
//   }
// }

// class OptionsIds {
//   List<int> ids;

//   OptionsIds({this.ids}) {
//     this.ids = [-1];
//   }

//   OptionsIds.fromJson(Map<String, dynamic> json) {
//     ids = json['ids'].cast<int>();
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['ids'] = this.ids;
//     return data;
//   }
// }
