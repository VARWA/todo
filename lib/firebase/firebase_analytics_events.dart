import 'package:firebase_analytics/firebase_analytics.dart';

import '../models/task_model.dart';

class FirebaseAnalyticsEvents {
  final _instance = FirebaseAnalytics.instance;

  FirebaseAnalyticsEvents();

  static _parseToJson({required Task task}) {
    final parsedData = task.toJsonAnalytics();
    return parsedData;
  }

  void addTask({required Task task}) {
    _instance.logEvent(
        name: 'new_task_added', parameters: _parseToJson(task: task));
  }

  void updateTask({required Task task}) {
    _instance.logEvent(
        name: 'task_updated', parameters: _parseToJson(task: task));
  }

  void deleteTask({required Task task}) {
    _instance.logEvent(
        name: 'task_deleted', parameters: _parseToJson(task: task));
  }

  void completedStatusUpdate({required Task task}) {
    _instance.logEvent(
        name: 'task_completed_status_updated',
        parameters: _parseToJson(task: task));
  }

  void screenRoutes({required String route}) {
    _instance.logEvent(name: 'go_to_route', parameters: {'route': route});
  }
}
