import 'package:flutter/material.dart';
import 'package:todo/themes/src/constants.dart';

TextTheme createTextTheme() {
  return const TextTheme(
    titleLarge: largeTitleTextStyle,
    // titleMedium: titleTextStyle,
    displayMedium: titleTextStyle,

    bodyMedium: bodyTextStyle,
    titleMedium: subheadTextStyle,

    titleSmall: subheadTextStyle,
    labelLarge: buttonTextStyle,
  );
}
