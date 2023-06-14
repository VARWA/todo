import 'package:flutter/material.dart';
import 'package:todo/themes/src/constants.dart';
import 'package:todo/themes/src/text_theme.dart';

ThemeData lightThemeData() {
  return ThemeData(
    brightness: Brightness.light,
    // useMaterial3: true,
    primaryColor: LightThemeColors.blue,
    fontFamily: 'Roboto',
    textTheme: createTextTheme(),
    scaffoldBackgroundColor: LightThemeColors.backPrimary,
    cardColor: LightThemeColors.white,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: LightThemeColors.blue,
      shape: CircleBorder(),
    ),
    checkboxTheme: CheckboxThemeData(
      checkColor: MaterialStateProperty.all<Color>(
        LightThemeColors.green,
      ),
    ),
    appBarTheme: const AppBarTheme(backgroundColor: LightThemeColors.backPrimary)
  );
}

abstract class LightThemeColors {
  static const supportSeparator = Color(0x33000000);
  static const supportOverlay = Color(0x0F000000);

  static const labelPrimary = Color(0xFF000000);
  static const labelSecondary = Color(0x99000000);
  static const labelTertiary = Color(0x4D000000);
  static const labelDisable = Color(0x26000000);

  static const red = Color(0xFFFF3B30);
  static const green = Color(0xFF34C759);
  static const blue = Color(0xFF007AFF);
  static const gray = Color(0xFF8E8E93);
  static const lightGray = Color(0xFFD1D1D6);
  static const white = Color(0xFFFFFFFF);

  static const backPrimary = Color(0xFFF7F6F2);
  static const backSecondary = Color(0xFFFFFFFF);
  static const backElevated = Color(0xFFFFFFFF);
}
