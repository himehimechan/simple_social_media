import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_social_media/utils/prefs.dart';

import '../app.dart';
import '../config/colors.dart';
import '../config/strings.dart';
import '../config/themes.dart';

class ThemeController extends GetxController {

  var theme = ThemeConfig.lightTheme.obs;

  Future<void> toggleThemeMode() async {
    String r = await Prefs.getString(StringsAssets.theme) ?? 'light';

    if (r == 'dark') {
      setTheme(ThemeConfig.lightTheme, 'light');
    } else {
      setTheme(ThemeConfig.darkTheme, 'dark');
    }
    if (kDebugMode) {
      print("theme: $r");
    }
  }

  @override
  Future<void> onInit() async {
    checkTheme();
    super.onInit();
  }

  // Apply font to our app's theme
  ThemeData themeData(ThemeData theme) {
    return theme.copyWith(
      textTheme: GoogleFonts.robotoTextTheme(
        theme.textTheme,
      ),
      colorScheme: theme.colorScheme.copyWith(
        secondary: ColorsValue.lightAccent,
      ),
    );
  }

  // change the Theme in the provider and SharedPreferences
  void setTheme(value, c) {
    theme.value = value;
    Get.changeTheme(themeData(value));
    Prefs.setString(StringsAssets.theme, c);
  }

  Future<ThemeData> checkTheme() async {
    ThemeData t;
    String r = await Prefs.getString(StringsAssets.theme) ?? 'light';
    if (kDebugMode) {
      print("theme: $r");
    }

    if (r == 'light') {
      t = ThemeConfig.lightTheme;
      setTheme(t, 'light');
    } else {
      t = ThemeConfig.darkTheme;
      setTheme(t, 'dark');
    }

    return t;
  }
}