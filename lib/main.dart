import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo/internal/my_app.dart';

import 'generated/codegen_loader.g.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('ru'),
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale('ru'),
      assetLoader: const CodegenLoader(),
      child: const MyApp(),
    ),
  );
}
