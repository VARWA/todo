import 'package:flutter/material.dart';

import '../change_task_screen/change_task_screen_widget.dart';
import '../main_screen/main_screen_widget.dart';

abstract class RouteNames {

  static const initialRoute = mainList;

  static const mainList = '/';
  static const changeTask = '/change';
}

abstract class RoutesBuilder {
  static final routes = <String, Widget Function(BuildContext)>{
    RouteNames.mainList: (BuildContext) => const MainScreenWidget(),
    RouteNames.changeTask: (BuildContext) => const ChangeTaskScreenWidget(),
  };
}
