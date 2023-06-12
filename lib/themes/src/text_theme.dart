import 'package:flutter/material.dart';
import 'package:todo/themes/src/constants.dart';

TextTheme createTextTheme() {
  return const TextTheme(titleLarge: largeTitleTextStyle,
    titleMedium: titleTextStyle,
    // button: buttonTextStyle,
    bodyMedium: bodyTextStyle,
    // subtitle1: subheadTextStyle,
  );
}