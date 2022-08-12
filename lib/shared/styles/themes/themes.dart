import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:salla/shared/imports/exports.dart';
import 'package:salla/shared/styles/colors/colors.dart';
ThemeData lightTheme = ThemeData(

    primarySwatch: generateMaterialColor(color: lightModeColor),
    appBarTheme: const AppBarTheme(

      elevation: 0.0,
      backgroundColor: lightModeColor,
      backwardsCompatibility: false ,
      foregroundColor: Colors.black,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: lightModeColor ,
          statusBarIconBrightness: Brightness.dark
      ) ,
    ) ,
    scaffoldBackgroundColor: Colors.white ,
    textTheme: const TextTheme(
      bodyText1: TextStyle(
          color: Colors.black,
          fontSize: 16.0 ,
          fontWeight: FontWeight.w700
      ) ,
      bodyText2: TextStyle(
        color: Colors.grey ,
        
      ),
      headline5: TextStyle(
          fontSize: 30.0 ,
          letterSpacing: 1,
          fontFamily: 'Anton'
      ),
      headline1: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w700 ,
        fontSize: 24.0 ,
      ) ,
    ) ,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      unselectedItemColor: Colors.grey,
    )
);

ThemeData darkTheme = ThemeData(
  primarySwatch: Colors.deepOrange ,
  appBarTheme: AppBarTheme(

    elevation: 0.0,
    backgroundColor: darkModeColor,
    backwardsCompatibility: false ,
    foregroundColor: Colors.white,
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: darkModeColor ,
        statusBarIconBrightness: Brightness.light
    ) ,
  ) ,
  scaffoldBackgroundColor: darkModeColor ,
  textTheme: const TextTheme(
    bodyText1: TextStyle(
        color: Colors.white,
        fontSize: 16.0 ,
        fontWeight: FontWeight.w700
    ) ,
    headline1: TextStyle(
      color: Colors.grey,
      fontWeight: FontWeight.w700 ,
      fontSize: 16.0 ,
    ) ,
  ) ,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: darkModeColor ,
      elevation: 10.0 ,
      unselectedItemColor: Colors.grey
  ) ,

);


