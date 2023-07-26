import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/ui/auth_screen/login_screen_widget.dart';
import 'package:todo/ui/change_task_screen/change_task_screen_widget.dart';
import 'package:todo/ui/main_screen/main_screen_widget.dart';
import 'package:todo/ui/navigation/routes.dart';
import 'package:todo/ui/unknown_screen/unknown_screen_widget.dart';

class AppRouter {
  GoRouter get router => _router;
  late final GoRouter _router = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: AppPage.mainList.routePath,
    routes: <GoRoute>[
      GoRoute(
        name: AppPage.mainList.routeName,
        path: AppPage.mainList.routePath,
        builder: (context, state) => const MainScreenWidget(),
      ),
      GoRoute(
        name: AppPage.login.routeName,
        path: AppPage.login.routePath,
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: const LoginScreenWidget(),
        ),
      ),
      GoRoute(
        name: AppPage.newTask.routeName,
        path: AppPage.newTask.routePath,
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: const ChangeTaskScreenWidget(),
        ),
      ),
      GoRoute(
        name: AppPage.changeTask.routeName,
        path: AppPage.changeTask.routePath,
        pageBuilder: (context, state) {
          final String? id = state.pathParameters['id'];
          return MaterialPage<void>(
            key: state.pageKey,
            child: ChangeTaskScreenWidget(taskId: id),
          );
        },
      ),
    ],
    errorPageBuilder: (context, state) => MaterialPage<void>(
      key: state.pageKey,
      child: const UnknownScreen(),
    ),
  );
}
