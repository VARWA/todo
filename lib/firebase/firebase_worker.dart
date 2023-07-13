import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:todo/src/logger.dart';

import '../di/service_locator.dart';
import 'firebase_analytics_events.dart';
import 'firebase_remote_config.dart';

class FirebaseWorker {
  final MyLogger _logger = locator<MyLogger>();
  final FirebaseAnalyticsEvents _analytics = FirebaseAnalyticsEvents();
  final MyFirebaseRemoteConfig _remoteConfig = MyFirebaseRemoteConfig();

  FirebaseWorker() {
    _logger.i('INIT FIREBASE WORKER');
    _initCrashlytics();
  }

  FirebaseAnalyticsEvents get analytics => _analytics;

  MyFirebaseRemoteConfig get remoteConfig => _remoteConfig;

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
