import 'package:continuelearning/ShopApp/layout/shop_layout.dart';
import 'package:continuelearning/ShopApp/modules/login/login_screen.dart';
import 'package:continuelearning/ShopApp/modules/on_board_screen.dart';
import 'package:continuelearning/ShopApp/shared/constatns/constants.dart';
import 'package:continuelearning/ShopApp/shared/network/local/cache_helper.dart';
import 'package:continuelearning/ShopApp/shared/network/remote/dio_helper.dart';
import 'package:continuelearning/ShopApp/shared/styles/themes.dart';
// import 'package:continuelearning/TODO%20APP/layout/home_layout.dart';
import 'package:continuelearning/bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();

  DioHelper.init();
  await CacheHelper.init();

  var tokenObject = await CacheHelper.getData(key: "token");
  token = tokenObject is String ? tokenObject : "No Token";

  var valueOnBoarding = await CacheHelper.getData(key: "onboarding");
  bool onBoard = valueOnBoarding is bool ? valueOnBoarding : false;

  var valueLogin = await CacheHelper.getData(key: "login");
  bool login = valueLogin is bool ? valueLogin : false;
  Widget startScreen = OnBoardScreen();

  if (onBoard) {
    startScreen = LoginScreen();
    if (login) {
      startScreen = const ShopLayout();
    }
  }

  runApp(MyApp(startScreen: startScreen));
  // runApp(
  //   DevicePreview(
  //     enabled: !kReleaseMode,
  //     builder: (context) => MyApp(), // Wrap your app
  //   ),
  // );
}

class MyApp extends StatelessWidget {
  final Widget startScreen;

  const MyApp({
    required this.startScreen,
  });

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return
        // BlocProvider(
        // create: (context) => ShopCubit()
        // // ..getHomeData()
        // // ..getCategoryData()
        // // ..getFavoriteData()
        // // ..getProfileData()
        // ,
        // child:
        //   BlocConsumer<ShopCubit, ShopStates>(
        // listener: (context, state) {},
        // builder: (context, state) {
        //   return
        MaterialApp(
      theme: lightTheme(),
      darkTheme: darkTheme(),
      home: startScreen,
      debugShowCheckedModeBanner: false,
    );
    // },
    // );
    // );
  }
}
