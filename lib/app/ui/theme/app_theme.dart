import 'package:flutter/material.dart';

const _fontFamily = 'NotoSansKR';

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
    background: Colors.black54,
  ),
);

final ThemeData appDarkTheme = ThemeData(
  fontFamily: _fontFamily,
  brightness: Brightness.dark,
  primaryColor: Colors.amber,
  buttonTheme: const ButtonThemeData(
    buttonColor: Colors.amber,
    disabledColor: Colors.grey,
  ),
  colorScheme: ColorScheme.fromSwatch().copyWith(
    brightness: Brightness.dark,
    secondary: Colors.red,
  ),
);

final Map<String, dynamic> navigationDefaultSet = {
  "showSelectedLabels": false,
  "showUnselectedLabels": false,
  "selectedItemColor": const Color(0xF3F3F3FF),
  "unselectedItemColor": Colors.white24,
  "backgroundColor": const Color(0x3F3F3FFF),
  "type": BottomNavigationBarType.fixed,
};
