import 'dart:developer';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:todo/src/logger.dart';

import '../di/service_locator.dart';
import '../models/task_model.dart';

class FirebaseWorker {
  final MyLogger _logger = locator<MyLogger>();
  final FirebaseAnalyticsEvents _analytics = FirebaseAnalyticsEvents();

  FirebaseWorker() {
    _logger.i('INIT FIREBASE WORKER');
    _initCrashlytics();
  }

  FirebaseAnalyticsEvents get analytics => _analytics;

  void _initCrashlytics() {
    FlutterError.onError = (errorDetails) {
      _logger.d('Caught error in FlutterError.onError');
      FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
    };

    PlatformDispatcher.instance.onError = (error, stack) {
      _logger.d('Caught error in PlatformDispatcher.onError');
      FirebaseCrashlytics.instance.recordError(
        error,
        stack,
        fatal: false,
      );
      return true;
    };
    _logger.d('Crashlytics initialized');
  }
}

class FirebaseAnalyticsEvents {
  final _instance = FirebaseAnalytics.instance;

  FirebaseAnalyticsEvents();

  static _parseToJson({required Task task}) {
    final parsedData = task.toJsonAnalytics();
    log(parsedData.toString());
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
