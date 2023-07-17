import 'package:firebase_analytics/firebase_analytics.dart';

import '../models/task_model.dart';

class FirebaseAnalyticsEvents {
  final _instance = FirebaseAnalytics.instance;

  FirebaseAnalyticsEvents();

  void addTask({required Task task}) {
    _instance.logEvent(
      name: 'new_task_added',
      parameters: {
        'task_id': task.id,
      },
    );
  }

  void updateTask({required Task task}) {
    _instance.logEvent(
      name: 'task_updated',
      parameters: {
        'task_id': task.id,
      },
    );
  }

  void deleteTask({required Task task}) {
    _instance.logEvent(
      name: 'task_deleted',
      parameters: {
        'task_id': task.id,
      },
    );
  }

  void completedStatusUpdate({required Task task}) {
    _instance.logEvent(
      name: 'task_completed_status_updated',
      parameters: {
        'task_id': task.id,
      },
    );
  }

  void screenRoutes({required String route}) {
    _instance.logEvent(
      name: 'go_to_route',
      parameters: {
        'route': route,
      },
    );
  }
}
