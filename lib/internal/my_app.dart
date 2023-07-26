import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/task_list_model.dart';
import 'package:todo/src/themes/src/custom_extension.dart';

import '../src/themes/theme.dart';
import '../ui/navigation/app_router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // final routerDelegate = MyRouterDelegate();
    // final routeInformationParser = MyRouteInformationParser();
    // final AppRouter appRouter = AppRouter();

    return MultiProvider(
      providers: [
        // ChangeNotifierProvider<AppService>(create: (_) => appService),
        Provider<AppRouter>(create: (_) => AppRouter()),
        // Provider<AuthService>(create: (_) => authService),
        ListenableProvider<TasksListModel>(
          create: (context) => TasksListModel(),
        ),
        // ChangeNotifierProvider<LoginState>(
        //   lazy: false,
        //   create: (BuildContext createContext) => loginState,
        // ),
        Provider<AppRouter>(
          lazy: false,
          create: (BuildContext createContext) => AppRouter(
              // loginState,
              ),
        ),
      ],
      child: Builder(
        builder: (BuildContext context) {
          final router = Provider.of<AppRouter>(context, listen: false).router;
          return MaterialApp.router(
            title: 'To-do',
            debugShowCheckedModeBanner: false,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            routerConfig: router,
            // routeInformationParser: router.routeInformationParser,
            // routerDelegate: router.routerDelegate,
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
          );
        },
      ),
    );
  }
}
