import 'package:device_info_plus/device_info_plus.dart';

class DeviceInfo {
  late final String? _deviceId;

  DeviceInfo() {
    getDeviceId();
  }

  getDeviceId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    _deviceId = androidInfo.id;
  }

  String get deviceId => _deviceId ?? 'empty';
}
