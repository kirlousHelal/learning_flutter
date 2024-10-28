import 'package:continuelearning/ShopApp/models/category_model.dart';
import 'package:continuelearning/ShopApp/models/favorites_get_model.dart';
import 'package:continuelearning/ShopApp/models/favortie_post_model.dart';
import 'package:continuelearning/ShopApp/models/profile_model.dart';
import 'package:continuelearning/ShopApp/models/search_model.dart';

import '../models/home_model.dart';

abstract class ShopStates {}

class ShopInitialSate extends ShopStates {}

class ShopChangeFocusSate extends ShopStates {}

class ShopChangeFavoriteState extends ShopStates {}

class ShopBottomItemSate extends ShopStates {}

class ShopGetHomeDataLoadingSate extends ShopStates {}

class ShopGetHomeDataSuccessSate extends ShopStates {
  final HomeModel? homeModel;

  ShopGetHomeDataSuccessSate({required this.homeModel});
}

class ShopGetHomeDataErrorSate extends ShopStates {}

class ShopGetCategoryDataLoadingSate extends ShopStates {}

class ShopGetCategoryDataSuccessSate extends ShopStates {
  final CategoryModel? categoryModel;

  ShopGetCategoryDataSuccessSate({required this.categoryModel});
}

class ShopGetCategoryDataErrorSate extends ShopStates {}

class ShopPostFavoriteDataLoadingSate extends ShopStates {}

class ShopPostFavoriteDataSuccessSate extends ShopStates {
  final FavoritesPostModel? favoritesPostModel;

  ShopPostFavoriteDataSuccessSate({required this.favoritesPostModel});
}

class ShopPostFavoriteDataErrorSate extends ShopStates {}

class ShopGetFavoriteDataLoadingSate extends ShopStates {}

class ShopGetFavoriteDataSuccessSate extends ShopStates {
  final FavoritesGetModel? favoritesGetModel;

  ShopGetFavoriteDataSuccessSate({required this.favoritesGetModel});
}

class ShopGetFavoriteDataErrorSate extends ShopStates {}

class ShopGetProfileDataLoadingSate extends ShopStates {}

class ShopGetProfileDataSuccessSate extends ShopStates {
  final UserDataModel? userDataModel;

  ShopGetProfileDataSuccessSate({required this.userDataModel});
}

class ShopGetProfileDataErrorSate extends ShopStates {}

class ShopPutProfileDataLoadingSate extends ShopStates {}

class ShopPutProfileDataSuccessSate extends ShopStates {
  final UserDataModel? userDataModel;

  ShopPutProfileDataSuccessSate({required this.userDataModel});
}

class ShopPutProfileDataErrorSate extends ShopStates {}

class ShopPostSearchDataLoadingSate extends ShopStates {}

class ShopPostSearchDataSuccessSate extends ShopStates {
  final SearchModel? searchModel;

  ShopPostSearchDataSuccessSate({required this.searchModel});
}

class ShopPostSearchDataErrorSate extends ShopStates {}
