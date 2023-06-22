import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/device_info_model.dart';
import 'package:todo/my_app.dart';


Future<void> main() async {

  var deviceInfo = DeviceInfoModel();
  // deviceInfo.setDeviceId();
  runApp(
    Provider(
      create: (BuildContext context) => deviceInfo,
      child: const MyApp(),
    ),
  );
}
