import 'package:flutter/material.dart';
import 'package:todo/repository/data_client.dart';
import 'package:todo/src/logger.dart';
import 'package:todo/ui/navigation/routes.dart';

import '../../di/service_locator.dart';
import '../../firebase/firebase_worker.dart';
import 'navigation_state.dart';

class MyRouteInformationParser extends RouteInformationParser<NavigationState> {
  final MyLogger _logger = locator<MyLogger>();
  final _firebaseWorker = locator<FirebaseWorker>();

  @override
  Future<NavigationState> parseRouteInformation(
      RouteInformation routeInformation) async {
    final location = routeInformation.location;

    if (location == null) {
      return NavigationState.unknownScreen();
    }

    final uri = Uri.parse(location);
    _logger.i('Got uri: $uri');

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
      return NavigationState.tasksListScreen();
    }

    return NavigationState.tasksListScreen();
  }

  @override
  RouteInformation? restoreRouteInformation(NavigationState configuration) {
    if (configuration.isTaskDetailsScreen) {
      final taskId = configuration.selectedTaskId ?? 'new';
      final location = '/${Routes.changeTask}/$taskId';
      _firebaseWorker.analytics.screenRoutes(
        route: location,
      );
      return RouteInformation(location: location);
    }
    if (configuration.isUnknown) {
      return null;
    }
    _firebaseWorker.analytics.screenRoutes(
      route: '/',
    );
    return const RouteInformation(location: '/');
  }
}
