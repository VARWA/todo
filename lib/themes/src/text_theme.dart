import 'package:flutter/material.dart';
import 'package:todo/themes/src/constants.dart';

TextTheme createTextTheme() {
  return const TextTheme(
      titleLarge: largeTitleTextStyle,
      bodyMedium: bodyTextStyle,
      titleSmall: subheadTextStyle,
      labelLarge: buttonTextStyle,
      labelMedium: buttonTextStyle);
}
