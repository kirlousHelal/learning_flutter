import 'package:continuelearning/NewsApp/cubit/states.dart';
import 'package:continuelearning/NewsApp/modules/business_screen.dart';
import 'package:continuelearning/NewsApp/modules/science_screen.dart';
import 'package:continuelearning/NewsApp/modules/settings_screen.dart';
import 'package:continuelearning/NewsApp/modules/sports_screen.dart';
import 'package:continuelearning/NewsApp/shared/network/local/cache_helper.dart';
import 'package:continuelearning/NewsApp/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);
  TextEditingController searchController = TextEditingController();
  int currentIndex = 0;
  ThemeMode appMode = CacheHelper.getBool(key: "isDark") ?? false
      ? ThemeMode.dark
      : ThemeMode.light;

  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(
        icon: Icon(Icons.business), label: "Business"),
    const BottomNavigationBarItem(icon: Icon(Icons.sports), label: "Sports"),
    const BottomNavigationBarItem(icon: Icon(Icons.science), label: "Science"),
    const BottomNavigationBarItem(
        icon: Icon(Icons.settings), label: "Settings"),
  ];

  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
    SettingsScreen(),
  ];

  void changeBottomNav(int index) {
    currentIndex = index;
    if (index == 1 && sports.isEmpty) getSportsData();
    if (index == 2 && science.isEmpty) getScienceData();
    emit(NewsBottomNavState());
  }

  void changeModeApp() {
    if (appMode == ThemeMode.dark) {
      appMode = ThemeMode.light;
      CacheHelper.setBool(key: "isDark", value: false);
    } else {
      appMode = ThemeMode.dark;
      CacheHelper.setBool(key: "isDark", value: true);
    }
    emit(NewsAppModeState());
  }

  List<dynamic> business = [];

  Future<void> getBusinessData() async {
    emit(NewsGetBusinessLoadingState());
    // country=us&category=business&apiKey=7bcc1559a5b74d6cbb996877d0e80df0
    DioHelper.get(url: "v2/top-headlines", query: {
      "country": "us",
      "category": "business",
      "apiKey": "7bcc1559a5b74d6cbb996877d0e80df0",
    }).then(
      (value) {
        business = value.data['articles'];
        print(" The Title is '${business[0]['title']}'");
        emit(NewsGetBusinessSuccessState());
      },
    ).catchError((error) {
      emit(NewsGetBusinessErrorState(error.toString()));
      print(error.toString());
    });
  }

  List<dynamic> sports = [];

  Future<void> getSportsData() async {
    emit(NewsGetSportsLoadingState());
    // country=us&category=business&apiKey=7bcc1559a5b74d6cbb996877d0e80df0

    DioHelper.get(url: "v2/top-headlines", query: {
      "country": "us",
      "category": "sports",
      "apiKey": "7bcc1559a5b74d6cbb996877d0e80df0",
    }).then(
      (value) {
        sports = value.data['articles'];
        print(" The Title is '${business[0]['title']}'");
        emit(NewsGetSportsSuccessState());
      },
    ).catchError((error) {
      emit(NewsGetSportsErrorState(error.toString()));
      print(error.toString());
    });
  }

  List<dynamic> science = [];

  Future<void> getScienceData() async {
    emit(NewsGetScienceLoadingState());
    // country=us&category=business&apiKey=7bcc1559a5b74d6cbb996877d0e80df0
    DioHelper.get(url: "v2/top-headlines", query: {
      "country": "us",
      "category": "science",
      "apiKey": "7bcc1559a5b74d6cbb996877d0e80df0",
    }).then(
      (value) {
        science = value.data['articles'];
        print(" The Title is '${business[0]['title']}'");
        emit(NewsGetScienceSuccessState());
      },
    ).catchError((error) {
      emit(NewsGetScienceErrorState(error.toString()));
      print(error.toString());
    });
  }

  List<dynamic> search = [];

  Future<void> getSearchData({required dynamic value}) async {
    emit(NewsGetSearchLoadingState());
    // country=us&category=business&apiKey=7bcc1559a5b74d6cbb996877d0e80df0
    DioHelper.get(url: "v2/everything", query: {
      "q": value,
      "apiKey": "7bcc1559a5b74d6cbb996877d0e80df0",
    }).then(
      (value) {
        search = value.data['articles'];
        print(" The Title is '${business[0]['title']}'");
        emit(NewsGetSearchSuccessState());
      },
    ).catchError((error) {
      emit(NewsGetSearchErrorState(error.toString()));
      print(error.toString());
    });
  }
}
