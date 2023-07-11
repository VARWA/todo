import 'package:flutter/material.dart';

@immutable
class CustomColors extends ThemeExtension<CustomColors> {
  const CustomColors({
    required this.supportSeparator,
    required this.supportOverlay,
    required this.labelPrimary,
    required this.labelSecondary,
    required this.labelTertiary,
    required this.labelDisable,
    required this.red,
    required this.green,
    required this.blue,
    required this.gray,
    required this.lightGray,
    required this.white,
    required this.backPrimary,
    required this.backSecondary,
    required this.backElevated,
  });

  final Color? supportSeparator;
  final Color? supportOverlay;
  final Color? labelPrimary;
  final Color? labelSecondary;
  final Color? labelTertiary;
  final Color? labelDisable;
  final Color? red;
  final Color? green;
  final Color? blue;
  final Color? gray;
  final Color? lightGray;
  final Color? white;
  final Color? backPrimary;
  final Color? backSecondary;
  final Color? backElevated;

  @override
  CustomColors copyWith({
    Color? supportSeparator,
    Color? supportOverlay,
    Color? labelPrimary,
    Color? labelSecondary,
    Color? labelTertiary,
    Color? labelDisable,
    Color? red,
    Color? green,
    Color? blue,
    Color? gray,
    Color? lightGray,
    Color? white,
    Color? backPrimary,
    Color? backSecondary,
    Color? backElevated,
  }) {
    return CustomColors(
      supportSeparator: supportSeparator ?? supportSeparator,
      supportOverlay: supportOverlay ?? supportOverlay,
      labelPrimary: labelPrimary ?? labelPrimary,
      labelSecondary: labelSecondary ?? labelSecondary,
      labelTertiary: labelTertiary ?? labelTertiary,
      labelDisable: labelDisable ?? labelDisable,
      red: red ?? red,
      green: green ?? green,
      blue: blue ?? blue,
      gray: gray ?? gray,
      lightGray: lightGray ?? lightGray,
      white: white ?? white,
      backPrimary: backPrimary ?? backPrimary,
      backSecondary: backSecondary ?? backSecondary,
      backElevated: backElevated ?? backElevated,
    );
  }

  @override
  CustomColors lerp(ThemeExtension<CustomColors>? other, double t) {
    if (other is! CustomColors) {
      return this;
    }
    return CustomColors(
      supportSeparator: Color.lerp(supportSeparator, other.supportSeparator, t),
      supportOverlay: Color.lerp(supportOverlay, other.supportOverlay, t),
      labelPrimary: Color.lerp(labelPrimary, other.labelPrimary, t),
      labelSecondary: Color.lerp(labelSecondary, other.labelSecondary, t),
      labelTertiary: Color.lerp(labelTertiary, other.labelTertiary, t),
      labelDisable: Color.lerp(labelDisable, other.labelDisable, t),
      red: Color.lerp(red, other.red, t),
      green: Color.lerp(green, other.green, t),
      blue: Color.lerp(blue, other.blue, t),
      gray: Color.lerp(gray, other.gray, t),
      lightGray: Color.lerp(lightGray, other.lightGray, t),
      white: Color.lerp(white, other.white, t),
      backPrimary: Color.lerp(backPrimary, other.backPrimary, t),
      backSecondary: Color.lerp(backSecondary, other.backSecondary, t),
      backElevated: Color.lerp(backElevated, other.backElevated, t),
    );
  }

  static const light = CustomColors(
    supportSeparator: Color(0x33000000),
    supportOverlay: Color(0x0F000000),
    labelPrimary: Color(0xFF000000),
    labelSecondary: Color(0x99000000),
    labelTertiary: Color(0x4D000000),
    labelDisable: Color(0x26000000),
    red: Color(0xFFFF3B30),
    green: Color(0xFF34C759),
    blue: Color(0xFF007AFF),
    gray: Color(0xFF8E8E93),
    lightGray: Color(0xFFD1D1D6),
    white: Color(0xFFFFFFFF),
    backPrimary: Color(0xFFF7F6F2),
    backSecondary: Color(0xFFFFFFFF),
    backElevated: Color(0xFFFFFFFF),
  );

  // the dark theme
  static const dark = CustomColors(
    supportSeparator: Color(0x33FFFFFF),
    supportOverlay: Color(0x52000000),
    labelPrimary: Color(0xFFFFFFFF),
    labelSecondary: Color(0x99FFFFFF),
    labelTertiary: Color(0x66FFFFFF),
    labelDisable: Color(0x26FFFFFF),
    red: Color(0xFFFF3B3A),
    green: Color(0xFF34D74B),
    blue: Color(0xFF0A84FF),
    gray: Color(0xFF48484A),
    lightGray: Color(0xFFD1D1D6),
    white: Color(0xFFFFFFFF),
    backPrimary: Color(0xFF161618),
    backSecondary: Color(0xFF252528),
    backElevated: Color(0xFF3C3C3F),
  );
}
