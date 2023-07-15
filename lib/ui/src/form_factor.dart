import 'package:flutter/material.dart';

double establishGlobalPadding({required BuildContext context}) {
  final double deviceWidth = MediaQuery.of(context).size.shortestSide;
  final bool isPortrait =
      MediaQuery.of(context).orientation == Orientation.portrait;
  const int minWidthWithoutResizing = 600;
  if (deviceWidth < minWidthWithoutResizing) {
    return 0;
  } else if (isPortrait) {
    return deviceWidth / 10;
  } else {
    return deviceWidth / 5;
  }
}
