import 'package:firebase_remote_config/firebase_remote_config.dart';

class MyFirebaseRemoteConfig {
  final _remoteConfig = FirebaseRemoteConfig.instance;

  MyFirebaseRemoteConfig() {
    setConfig();
  }
  Future<void> setConfig() async {
    _remoteConfig.setDefaults({
      _ConfigFields.useNewImportantTaskColor: false,
    });
    await _remoteConfig.fetchAndActivate();
  }

  FirebaseRemoteConfig get remoteConfig => _remoteConfig;

  bool get useNewImportantTaskColor =>
      _remoteConfig.getBool(_ConfigFields.useNewImportantTaskColor);
}

abstract class _ConfigFields {
  static const String useNewImportantTaskColor = 'useNewImportantTaskColor';
}
