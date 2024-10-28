class CategoryModel {
  bool? status;
  CategoryData? data;

  CategoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? CategoryData.fromJson(json['data']) : null;
  }
}

class CategoryData {
  int? currentPage;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;
  List<DataCategoryModel?> data = [];

  CategoryData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];

    json['data'].forEach((element) {
      data?.add(element != null ? DataCategoryModel.fromJson(element) : null);
      // banners.add(element);
    });
  }
}

class DataCategoryModel {
  dynamic id;
  String? image;
  String? name;

  DataCategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    name = json['name'];
  }
}
