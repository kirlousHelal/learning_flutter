class FavoritesPostModel {
  bool? status;
  String? message;

  FavoritesPostModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}
