
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
        name: 'New_task_added', parameters: _parseToJson(task: task));
  }

  void updateTask({required Task task}) {
    _instance.logEvent(
        name: 'Task_updated', parameters: _parseToJson(task: task));
  }

  void deleteTask({required Task task}) {
    _instance.logEvent(
        name: 'Task_deleted', parameters: _parseToJson(task: task));
  }

  void completedStatusUpdate({required Task task}) {
    _instance.logEvent(
        name: 'Task_completed_status_updated',
        parameters: _parseToJson(task: task));
  }
}