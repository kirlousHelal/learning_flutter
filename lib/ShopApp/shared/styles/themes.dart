import 'package:continuelearning/ShopApp/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData lightTheme() => ThemeData(
    // useMaterial3: false,
    colorScheme:
        ColorScheme.light(primary: defaultColor, onPrimary: Colors.white),
    appBarTheme: const AppBarTheme(
        color: Colors.white,
        titleTextStyle: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        )));

ThemeData darkTheme() => ThemeData(
    appBarTheme: const AppBarTheme(
        color: Colors.black54,
        titleTextStyle: TextStyle(color: Colors.white),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.black54,
          statusBarIconBrightness: Brightness.light,
        )));
