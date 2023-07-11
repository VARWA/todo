part of '../theme.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.light,
  // useMaterial3: true,
  // colorScheme: _shrineColorScheme,
  fontFamily: 'Roboto',
  textTheme: createTextTheme(
    themeStyle: ThemeStyles.dark,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    shape: CircleBorder(),
  ),

);

abstract class OtherColors {
  static const redCheckboxFillColor = Color(0xFFFF3B30);
  static const complitedTaskInList = Color.fromRGBO(0, 0, 0, 0.3);
}
