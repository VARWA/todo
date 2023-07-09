import 'package:flutter/material.dart';

import 'constants.dart';

TextTheme createTextTheme() {
  return const TextTheme(
      titleLarge: largeTitleTextStyle,
      bodyMedium: bodyTextStyle,
      titleSmall: subheadTextStyle,
      labelLarge: buttonTextStyle,
      labelMedium: buttonTextStyle);
}
