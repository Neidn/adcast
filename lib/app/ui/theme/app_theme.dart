import 'package:adcast/app/ui/theme/app_colors.dart';
import 'package:flutter/material.dart';

const _fontFamily = 'NotoSansKR';

final ThemeData appTheme = ThemeData.dark(
  useMaterial3: true,
).copyWith(
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
  textTheme: ThemeData.dark().textTheme.apply(
        fontFamily: _fontFamily,
      ),
  primaryTextTheme: ThemeData.dark().textTheme.apply(
        fontFamily: _fontFamily,
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
