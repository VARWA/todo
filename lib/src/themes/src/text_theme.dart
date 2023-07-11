part of '../theme.dart';

TextTheme createTextTheme({required ThemeStyles themeStyle}) {
  return const TextTheme(
    titleLarge: largeTitleTextStyle,
    bodyMedium: bodyTextStyle,
    titleMedium: titleTextStyle,
    titleSmall: subheadTextStyle,
    labelLarge: buttonTextStyle,
    labelMedium: buttonTextStyle,
  );
}
