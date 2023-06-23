import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/task_list_model.dart';
import 'package:todo/themes/src/light_theme.dart';

import '../ui/navigation/routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ListenableProvider(
      create: (context) => TasksListModel(),
      child: MaterialApp(
        title: 'To-do',
        debugShowCheckedModeBanner: false,
        initialRoute: RouteNames.initialRoute,
        routes: RoutesBuilder.routes,
        theme: lightThemeData(),
      ),
    );
  }
}