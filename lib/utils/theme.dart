import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'custom_color.dart';

final Box themePref = Hive.box('themePreferences');

class Themes {
  // final _box = GetStorage();
  // final _key = 'isDarkMode';
  bool isDark = false;
  ThemeMode themeMode = ThemeMode.light;
  Themes() {
    _loadThemeFromBox();
  }

  _saveThemeToBox(bool tosave) {
    themePref.put('theme', tosave);
  }

  bool _loadThemeFromBox() {
    final savedTheme = themePref.get('theme') ?? false;
    return savedTheme ? true : false;
  }

  // ThemeData? get theme => _loadThemeFromBox() ? dark : light;
  ThemeMode get theme => _loadThemeFromBox() ? ThemeMode.dark : ThemeMode.light;

  void switchTheme() {
    bool currentTheme = _loadThemeFromBox();
    Get.changeThemeMode(currentTheme ? ThemeMode.light : ThemeMode.dark);
    _saveThemeToBox(!currentTheme);
  }

  static ThemeData light = ThemeData.light().copyWith(
      primaryColor: CustomColor.primaryLightColor,
      scaffoldBackgroundColor: CustomColor.primaryLightScaffoldBackgroundColor,
      brightness: Brightness.light,
      textTheme: ThemeData.dark().textTheme.apply(
          fontFamily: GoogleFonts.josefinSans().fontFamily,
          bodyColor: Colors.black),
      colorScheme: const ColorScheme.light(surface: CustomColor.whiteColor),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: CustomColor.primaryLightColor,
        selectionColor: CustomColor.primaryLightColor,
        selectionHandleColor: CustomColor.primaryLightColor,
      ),
      appBarTheme: const AppBarTheme(
        scrolledUnderElevation: 0,
      ));
  static ThemeData dark = ThemeData.dark().copyWith(
    primaryColor: CustomColor.primaryDarkColor,
    scaffoldBackgroundColor: CustomColor.primaryDarkScaffoldBackgroundColor,
    brightness: Brightness.dark,
    textTheme: ThemeData.dark().textTheme.apply(
          fontFamily: GoogleFonts.josefinSans().fontFamily,
          bodyColor: Colors.black,
        ),
    colorScheme: const ColorScheme.light(surface: CustomColor.blackColor),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: CustomColor.primaryLightColor,
      selectionColor: CustomColor.primaryLightColor,
      selectionHandleColor: CustomColor.primaryLightColor,
    ),
    appBarTheme: const AppBarTheme(
      scrolledUnderElevation: 0,
    ),
  );

  static void init({
    required ColorMode primary,
  }) {
    dark = ThemeData.dark().copyWith(
      primaryColor: primary.dark,
    );
    light = ThemeData.light().copyWith(
      primaryColor: primary.light,
    );
  }
}

class ColorMode {
  final Color light, dark;
  ColorMode({required this.light, required this.dark});
}
