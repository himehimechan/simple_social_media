import 'package:flutter/material.dart';

import 'colors.dart';

class ThemeConfig {

  static ThemeData lightTheme = ThemeData(
    backgroundColor: ColorsValue.lightBG,
    primaryColor: ColorsValue.lightPrimary,
    scaffoldBackgroundColor: ColorsValue.lightBG,
    appBarTheme: AppBarTheme(
      color: ColorsValue.lightPrimary,
      elevation: 0.0,
      titleTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.w800,
      ),
      iconTheme: const IconThemeData(
        color: Colors.black,
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    backgroundColor: ColorsValue.darkBG,
    primaryColor: ColorsValue.darkPrimary,
    scaffoldBackgroundColor: ColorsValue.darkBG,
    appBarTheme: AppBarTheme(
      color: ColorsValue.darkPrimary,
      elevation: 0.0,
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w800,
      ),
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
    ),
  );
}