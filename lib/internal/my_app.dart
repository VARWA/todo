import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/task_list_model.dart';
import 'package:todo/src/themes/src/custom_extension.dart';
import 'package:todo/ui/navigation/router_delegate.dart';

import '../src/themes/theme.dart';
import '../ui/navigation/route_information_parser.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final routerDelegate = MyRouterDelegate();
    final routeInformationParser = MyRouteInformationParser();

    return ListenableProvider(
      create: (context) => TasksListModel(),
      child: MaterialApp.router(
        title: 'To-do',
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        routerDelegate: routerDelegate,
        routeInformationParser: routeInformationParser,
        theme: lightTheme.copyWith(
          extensions: <ThemeExtension<dynamic>>[
            CustomColors.light,
          ],
        ),
        darkTheme: darkTheme.copyWith(
          extensions: <ThemeExtension<dynamic>>[
            CustomColors.dark,
          ],
        ),
        themeMode: ThemeMode.system,
      ),
    );
  }
}
