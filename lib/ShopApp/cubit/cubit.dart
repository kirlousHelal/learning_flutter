import 'package:continuelearning/ShopApp/cubit/states.dart';
import 'package:continuelearning/ShopApp/models/category_model.dart';
import 'package:continuelearning/ShopApp/models/favorites_get_model.dart';
import 'package:continuelearning/ShopApp/models/favortie_post_model.dart';
import 'package:continuelearning/ShopApp/models/home_model.dart';
import 'package:continuelearning/ShopApp/models/profile_model.dart';
import 'package:continuelearning/ShopApp/models/search_model.dart';
import 'package:continuelearning/ShopApp/modules/categories_screen.dart';
import 'package:continuelearning/ShopApp/modules/favorites_screen.dart';
import 'package:continuelearning/ShopApp/modules/products_screen.dart';
import 'package:continuelearning/ShopApp/modules/settings_screen.dart';
import 'package:continuelearning/ShopApp/shared/constatns/constants.dart';
import 'package:continuelearning/ShopApp/shared/network/remote/dio_helper.dart';
import 'package:continuelearning/keep_alive_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialSate());

  static ShopCubit get(context) => BlocProvider.of(context);

  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
    const BottomNavigationBarItem(
        icon: Icon(Icons.category), label: "Categories"),
    const BottomNavigationBarItem(
        icon: Icon(Icons.favorite), label: "Favorites"),
    const BottomNavigationBarItem(
        icon: Icon(Icons.settings), label: "Settings"),
  ];

  int currentIndex = 0;

  // Define the PageController
  PageController pageController = PageController();

  // List<bool>? isFavorite;
  Map<int, bool?> favorites = {};

  List<Widget> bottomScreens = [
    const KeepAliveWidget(child: ProductsScreen()),
    const CategoriesScreen(),
    const FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeFocus() {
    emit(ShopChangeFocusSate());
  }

  void changeBottomItem(index) {
    currentIndex = index;
    emit(ShopBottomItemSate());
  }

  void setUP() {
    // currentIndex = 0;
    //
    // categoryModel = null;
    // favoritesPostModel = null;
    // favoritesGetModel = null;
    // userDataModel = null;
    // searchModel = null;

    getHomeData();
    getProfileData();
    getFavoriteData();
    getCategoryData();
  }

  HomeModel? homeModel;

  void getHomeData() {
    emit(ShopGetHomeDataLoadingSate());
    DioHelper.getData(path: 'home', token: token, isEnglish: true).then(
      (value) {
        homeModel = HomeModel.fromJson(value.data);
        homeModel?.data?.products.forEach(
          (element) {
            favorites.addAll({element?.id: element?.inFavorites});
            print('{${element?.id} : ${element?.inFavorites} }');
          },
        );
        print(token);
        emit(ShopGetHomeDataSuccessSate(homeModel: homeModel));
      },
    ).catchError((error) {
      print(error.toString());
      emit(ShopGetHomeDataErrorSate());
    });
  }

  CategoryModel? categoryModel;

  void getCategoryData() {
    emit(ShopGetCategoryDataLoadingSate());
    DioHelper.getData(path: 'categories', token: token, isEnglish: true).then(
      (value) {
        categoryModel = CategoryModel.fromJson(value.data);
        emit(ShopGetCategoryDataSuccessSate(categoryModel: categoryModel));
      },
    ).catchError((error) {
      print(error.toString());
      emit(ShopGetCategoryDataErrorSate());
    });
  }

  FavoritesPostModel? favoritesPostModel;

  void postFavoriteData({required int? productId}) {
    emit(ShopPostFavoriteDataLoadingSate());
    favorites[productId!] = !favorites[productId]!;
    DioHelper.postData(
        path: 'favorites',
        token: token,
        isEnglish: true,
        data: {"product_id": productId}).then(
      (value) {
        favoritesPostModel = FavoritesPostModel.fromJson(value.data);
        if (favoritesPostModel!.status == false) {
          favorites[productId] = !favorites[productId]!;
        } else {
          getFavoriteData();
        }
        print(favoritesPostModel?.status);
        print(favoritesPostModel?.message);
        emit(ShopPostFavoriteDataSuccessSate(
            favoritesPostModel: favoritesPostModel));
      },
    ).catchError((error) {
      favorites[productId] = !favorites[productId]!;
      print(error.toString());
      emit(ShopPostFavoriteDataErrorSate());
    });
  }

  FavoritesGetModel? favoritesGetModel;

  void getFavoriteData() {
    emit(ShopGetFavoriteDataLoadingSate());
    DioHelper.getData(path: 'favorites', token: token, isEnglish: true).then(
      (value) {
        favoritesGetModel = FavoritesGetModel.fromJson(value.data);
        print(favoritesGetModel != null);
        emit(ShopGetFavoriteDataSuccessSate(
            favoritesGetModel: favoritesGetModel));
      },
    ).catchError((error) {
      print(error.toString());
      emit(ShopGetFavoriteDataErrorSate());
    });
  }

  UserDataModel? userDataModel;

  void getProfileData() {
    emit(ShopGetProfileDataLoadingSate());
    DioHelper.getData(path: 'profile', token: token, isEnglish: true).then(
      (value) {
        userDataModel = UserDataModel.fromJson(value.data);

        emit(ShopGetProfileDataSuccessSate(userDataModel: userDataModel));
      },
    ).catchError((error) {
      print(error.toString());
      emit(ShopGetProfileDataErrorSate());
    });
  }

  void putProfileData({
    required name,
    required email,
    required phone,
  }) {
    emit(ShopPutProfileDataLoadingSate());
    DioHelper.putData(
            path: 'update-profile',
            data: {
              "name": "$name",
              "email": "$email",
              "phone": "$phone",
            },
            token: token,
            isEnglish: true)
        .then(
      (value) {
        userDataModel = UserDataModel.fromJson(value.data);

        emit(ShopPutProfileDataSuccessSate(userDataModel: userDataModel));
      },
    ).catchError((error) {
      print(error.toString());
      emit(ShopPutProfileDataErrorSate());
    });
  }

  SearchModel? searchModel;

  void postSearchData({required String value}) {
    emit(ShopPostSearchDataLoadingSate());
    DioHelper.postData(
            path: 'products/search',
            data: {
              "text": value,
            },
            token: token,
            isEnglish: true)
        .then(
      (value) {
        searchModel = SearchModel.fromJson(value.data);

        emit(ShopPostSearchDataSuccessSate(searchModel: searchModel));
      },
    ).catchError((error) {
      print(error.toString());
      emit(ShopPostSearchDataErrorSate());
    });
  }
}
