import 'package:flutter/material.dart';

import 'package:adcast/app/ui/theme/app_colors.dart';

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
  dataTableTheme: DataTableThemeData(
    dividerThickness: 0,
    headingRowHeight: 0,
    dataRowColor: MaterialStateProperty.all<Color>(
      mobileDarkTableBorderColor,
    ),
    dataTextStyle: const TextStyle(
      fontWeight: FontWeight.bold,
      color: whiteColor,
    ),
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
  dataTableTheme: DataTableThemeData(
    dividerThickness: 0,
    headingRowHeight: 0,
    dataRowColor: MaterialStateProperty.all<Color>(
      mobileLightTableBorderColor,
    ),
    dataTextStyle: const TextStyle(
      fontWeight: FontWeight.bold,
      color: blackColor,
    ),
  ),
);
