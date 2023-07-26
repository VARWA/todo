enum AppPage {
  onboard,
  login,
  mainList,
  register,
  newTask,
  changeTask,
}

extension AppPageExtension on AppPage {
  String get routePath {
    switch (this) {
      case AppPage.mainList:
        return "/main-list";

      case AppPage.onboard:
        return "/onboard";

      case AppPage.login:
        return "/login";

      case AppPage.register:
        return '/register';

      case AppPage.changeTask:
        return '/main-list/task/:id';

      case AppPage.newTask:
        return '/main-list/task/new';

      default:
        return '/main-list';
    }
  }

  String get routeName {
    switch (this) {
      case AppPage.mainList:
        return "MAIN_LIST";

      case AppPage.onboard:
        return "ONBOARD";

      case AppPage.login:
        return "LOGIN";

      case AppPage.register:
        return 'REGISTER';

      case AppPage.changeTask:
        return 'CHANGE_TASK';

      case AppPage.newTask:
        return 'NEW_TASK';

      default:
        return "HOME";
    }
  }
}
