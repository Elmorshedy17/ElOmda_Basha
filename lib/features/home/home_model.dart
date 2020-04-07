class HomeModel {
  int status;
  String message;
  Data data;

  HomeModel({this.status, this.message, this.data});

  HomeModel.fromJson(Map<String, dynamic> json) {
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
  List<Categories> categories;
  List<Ads> ads;
  List<TrandingSellers> trandingSellers;
  List<TrandingProducts> trandingProducts;
  List<Sellers> sellers;
  ActiveCategory activeCategory;
  List<SocialMedia> socialMedia;

  Data(
      {this.categories,
      this.ads,
      this.trandingSellers,
      this.trandingProducts,
      this.sellers,
      this.activeCategory,
      this.socialMedia});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      categories = new List<Categories>();
      json['categories'].forEach((v) {
        categories.add(new Categories.fromJson(v));
      });
    }
    if (json['ads'] != null) {
      ads = new List<Ads>();
      json['ads'].forEach((v) {
        ads.add(new Ads.fromJson(v));
      });
    }
    if (json['tranding_sellers'] != null) {
      trandingSellers = new List<TrandingSellers>();
      json['tranding_sellers'].forEach((v) {
        trandingSellers.add(new TrandingSellers.fromJson(v));
      });
    }
    if (json['tranding_products'] != null) {
      trandingProducts = new List<TrandingProducts>();
      json['tranding_products'].forEach((v) {
        trandingProducts.add(new TrandingProducts.fromJson(v));
      });
    }
    if (json['sellers'] != null) {
      sellers = new List<Sellers>();
      json['sellers'].forEach((v) {
        sellers.add(new Sellers.fromJson(v));
      });
    }
    activeCategory = json['active_category'] != null
        ? new ActiveCategory.fromJson(json['active_category'])
        : null;
    if (json['social_media'] != null) {
      socialMedia = new List<SocialMedia>();
      json['social_media'].forEach((v) {
        socialMedia.add(new SocialMedia.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.categories != null) {
      data['categories'] = this.categories.map((v) => v.toJson()).toList();
    }
    if (this.ads != null) {
      data['ads'] = this.ads.map((v) => v.toJson()).toList();
    }
    if (this.trandingSellers != null) {
      data['tranding_sellers'] =
          this.trandingSellers.map((v) => v.toJson()).toList();
    }
    if (this.trandingProducts != null) {
      data['tranding_products'] =
          this.trandingProducts.map((v) => v.toJson()).toList();
    }
    if (this.sellers != null) {
      data['sellers'] = this.sellers.map((v) => v.toJson()).toList();
    }
    if (this.activeCategory != null) {
      data['active_category'] = this.activeCategory.toJson();
    }
    if (this.socialMedia != null) {
      data['social_media'] = this.socialMedia.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Categories {
  int sort;
  int id;
  String name;
  String image;
  String active;

  Categories({this.sort, this.id, this.name, this.image, this.active});

  Categories.fromJson(Map<String, dynamic> json) {
    sort = json['sort'];
    id = json['id'];
    name = json['name'];
    image = json['image'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sort'] = this.sort;
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['active'] = this.active;
    return data;
  }
}

class Ads {
  int id;
  int sellerId;
  String name;
  String image;

  Ads({this.id, this.sellerId, this.name, this.image});

  Ads.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sellerId = json['seller_id'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['seller_id'] = this.sellerId;
    data['name'] = this.name;
    data['image'] = this.image;
    return data;
  }
}

class TrandingSellers {
  int id;
  String name;
  String image;
  int rate;
  String cuisine;
  String favourite;

  TrandingSellers(
      {this.id,
      this.name,
      this.image,
      this.rate,
      this.cuisine,
      this.favourite});

  TrandingSellers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    rate = json['rate'];
    cuisine = json['cuisine'];
    favourite = json['favourite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['rate'] = this.rate;
    data['cuisine'] = this.cuisine;
    data['favourite'] = this.favourite;
    return data;
  }
}

class TrandingProducts {
  int id;
  String name;
  String image;
  String price;
  String currency;
  String section;
  String favourite;

  TrandingProducts(
      {this.id,
      this.name,
      this.image,
      this.price,
      this.currency,
      this.section,
      this.favourite});

  TrandingProducts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    price = json['price'];
    currency = json['currency'];
    section = json['section'];
    favourite = json['favourite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['price'] = this.price;
    data['currency'] = this.currency;
    data['section'] = this.section;
    data['favourite'] = this.favourite;
    return data;
  }
}

class ActiveCategory {
  int id;
  String trandingSellersName;
  String trandingProductName;
  String sellersName;

  ActiveCategory(
      {this.id,
      this.trandingSellersName,
      this.trandingProductName,
      this.sellersName});

  ActiveCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    trandingSellersName = json['tranding_sellers_name'];
    trandingProductName = json['tranding_product_name'];
    sellersName = json['sellers_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tranding_sellers_name'] = this.trandingSellersName;
    data['tranding_product_name'] = this.trandingProductName;
    data['sellers_name'] = this.sellersName;
    return data;
  }
}

class SocialMedia {
  int id;
  String name;
  String link;
  String image;

  SocialMedia({this.id, this.name, this.link, this.image});

  SocialMedia.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    link = json['link'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['link'] = this.link;
    data['image'] = this.image;
    return data;
  }
}

class Sellers {
  int id;
  String name;
  String image;
  int rate;
  String cuisine;
  String favourite;

  Sellers(
      {this.id,
      this.name,
      this.image,
      this.rate,
      this.cuisine,
      this.favourite});

  Sellers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    rate = json['rate'];
    cuisine = json['cuisine'];
    favourite = json['favourite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['rate'] = this.rate;
    data['cuisine'] = this.cuisine;
    data['favourite'] = this.favourite;
    return data;
  }
}
