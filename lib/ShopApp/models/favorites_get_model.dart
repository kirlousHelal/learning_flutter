class FavoritesGetModel {
  bool status;
  String? message;
  FavoritesData data;

  FavoritesGetModel.fromJson(Map<String, dynamic> json)
      : status = json['status'],
        message = json['message'],
        data = FavoritesData.fromJson(json['data']);
}

class FavoritesData {
  int? currentPage;
  List<FavoriteItem> data;
  String firstPageUrl;
  int? from;
  int? lastPage;
  String lastPageUrl;
  String? nextPageUrl;
  String path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  FavoritesData.fromJson(Map<String, dynamic> json)
      : currentPage = json['current_page'],
        data = (json['data'] as List)
            .map((i) => FavoriteItem.fromJson(i))
            .toList(),
        firstPageUrl = json['first_page_url'],
        from = json['from'],
        lastPage = json['last_page'],
        lastPageUrl = json['last_page_url'],
        nextPageUrl = json['next_page_url'],
        path = json['path'],
        perPage = json['per_page'],
        prevPageUrl = json['prev_page_url'],
        to = json['to'],
        total = json['total'];
}

class FavoriteItem {
  int id;
  Product product;

  FavoriteItem.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        product = Product.fromJson(json['product']);
}

class Product {
  int id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String image;
  String name;
  String description;

  Product.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        price = json['price'],
        oldPrice = json['old_price'],
        discount = json['discount'],
        image = json['image'],
        name = json['name'],
        description = json['description'];
}
