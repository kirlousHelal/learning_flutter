class HomeModel {
  bool? status;
  HomeData? data;

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? HomeData.fromJson(json['data']) : null;
  }
}

class HomeData {
  List<BannerModel?> banners = [];
  List<ProductModel?> products = [];

  HomeData.fromJson(Map<String, dynamic> json) {
    json['banners'].forEach((element) {
      banners?.add(element != null ? BannerModel.fromJson(element) : null);
      // banners.add(element);
    });
    json['products'].forEach((element) {
      products?.add(element != null ? ProductModel.fromJson(element) : null);
      // products.add(element);
    });
    // banners = json['banners'];
    // products = json['products'];
  }
}

class BannerModel {
  int? id;
  String? image;

  BannerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class ProductModel {
  dynamic id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  bool? inFavorites;
  bool? inCart;

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}
