import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/app/ui/theme/app_colors.dart';

const _fontFamily = 'NotoSansKR';

final ThemeData appDarkTheme = ThemeData(
  brightness: Brightness.dark,
  fontFamily: _fontFamily,
  useMaterial3: true,
  scaffoldBackgroundColor: mobileDarkBackGroundColor,
  primaryColor: primaryColor,
  secondaryHeaderColor: secondaryColor,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: whiteColor,
      backgroundColor: primaryColor,
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: whiteColor,
      backgroundColor: secondaryColor,
    ),
  ),
  textTheme: const TextTheme(
    displayMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: whiteColor,
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      color: whiteColor,
    ),
    titleSmall: TextStyle(
      color: Colors.grey,
      fontSize: 12,
    ),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: mobileDarkBackGroundColor,
    elevation: 0,
  ),
);

final ThemeData appLightTheme = ThemeData(
  brightness: Brightness.light,
  fontFamily: _fontFamily,
  useMaterial3: true,
  scaffoldBackgroundColor: mobileLightBackGroundColor,
  primaryColor: primaryColor,
  secondaryHeaderColor: secondaryColor,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: whiteColor,
      backgroundColor: primaryColor,
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: whiteColor,
      backgroundColor: secondaryColor,
    ),
  ),
  textTheme: const TextTheme(
    displayMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: blackColor,
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      color: blackColor,
    ),
    titleSmall: TextStyle(
      color: Colors.grey,
      fontSize: 12,
    ),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: mobileLightBackGroundColor,
    elevation: 0,
  ),
);
