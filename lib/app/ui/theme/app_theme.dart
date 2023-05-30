import 'package:adcast/app/ui/theme/app_colors.dart';
import 'package:flutter/material.dart';

const _fontFamily = 'NotoSansKR';
/*
final ThemeData appLightTheme = ThemeData(
  fontFamily: _fontFamily,
  brightness: Brightness.light,
  primaryColor: Colors.purple,
  buttonTheme: const ButtonThemeData(
    buttonColor: Colors.purple,
    disabledColor: Colors.grey,
  ),
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: Colors.purple,
    brightness: Brightness.light,
    secondary: Colors.pink,
    background: const Color.fromRGBO(0, 0, 0, 1),
  ),
);
 */

final ThemeData appTheme = ThemeData.dark().copyWith(
  scaffoldBackgroundColor: mobileBackGroundColor,
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
);

final Map<String, dynamic> navigationDefaultSet = {
  "showSelectedLabels": false,
  "showUnselectedLabels": false,
  "selectedItemColor": whiteColor,
  "unselectedItemColor": liteWhiteColor,
  "backgroundColor": mobileBackGroundColor,
  "type": BottomNavigationBarType.fixed,
};
