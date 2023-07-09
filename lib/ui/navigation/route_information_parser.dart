import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:todo/repository/data_client.dart';
import 'package:todo/ui/navigation/routes.dart';

import 'navigation_state.dart';

class MyRouteInformationParser extends RouteInformationParser<NavigationState> {
  Logger logger = Logger();
  @override
  Future<NavigationState> parseRouteInformation(
      RouteInformation routeInformation) async {
    final location = routeInformation.location;
    if (location == null) {
      return NavigationState.unknownScreen();
    }

    final uri = Uri.parse(location);
    logger.i('Got uri: $uri');

    if (uri.pathSegments.isEmpty) {
      return NavigationState.tasksListScreen();
    }

    if (uri.pathSegments.length == 2) {
      final taskId = uri.pathSegments[1];
      final dataRepository = DataClient();
      if (uri.pathSegments[0] == Routes.changeTask &&
          await dataRepository.checkTaskById(taskId)) {
        return NavigationState.taskDetailsScreen(taskId);
      }

      return NavigationState.unknownScreen();
    }

    if (uri.pathSegments.length == 1) {
      // final path = uri.pathSegments[0];
      return NavigationState.tasksListScreen();
    }

    return NavigationState.tasksListScreen();
  }

  @override
  RouteInformation? restoreRouteInformation(NavigationState configuration) {
    if (configuration.isTaskDetailsScreen) {
      final taskId = configuration.selectedTaskId ?? 'new';

      return RouteInformation(location: '/${Routes.changeTask}/$taskId');
    }

    if (configuration.isUnknown) {
      return null;
    }

    return const RouteInformation(location: '/');
  }
}
