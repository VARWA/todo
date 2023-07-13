import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:todo/ui/change_task_screen/change_task_screen_widget.dart';
import 'package:todo/ui/main_screen/main_screen_widget.dart';

import '../unknown_screen/unknown_screen_widget.dart';
import 'navigation_state.dart';

class MyRouterDelegate extends RouterDelegate<NavigationState>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<NavigationState> {
  Logger logger = Logger(printer: PrettyPrinter());
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  MyRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  NavigationState? state;

  @override
  NavigationState get currentConfiguration {
    return state ?? NavigationState.tasksListScreen();
  }

  @override
  Widget build(BuildContext context) {
    logger.d('''state?.isTaskDetailsScreen = ${state?.isTaskDetailsScreen}
    state?.isUnknown = ${state?.isUnknown}
    ''');
    return Navigator(
      key: navigatorKey,
      pages: [
        MaterialPage(
          child: MainScreenWidget(
            onChangeTaskTap: _showTaskDetails,
          ),
        ),
        if (state?.isTaskDetailsScreen == true)
          MaterialPage(
            child: ChangeTaskScreenWidget(
              taskId: state?.selectedTaskId,
            ),
          ),
        if (state?.isUnknown == true)
          const MaterialPage(
            child: UnknownScreen(),
          ),
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }
        state = NavigationState.tasksListScreen();
        notifyListeners();
        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(NavigationState configuration) async {
    state = configuration;
    notifyListeners();
  }

  void _showTaskDetails(String? taskId) {
    logger.i('Request to _showTaskDetails with taskId = $taskId');
    state = NavigationState.taskDetailsScreen(taskId,
        createNewTask: taskId == null);
    notifyListeners();
  }
}
