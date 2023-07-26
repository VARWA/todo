import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/ui/main_screen/widgets/completed_count_widget.dart';
import 'package:todo/ui/main_screen/widgets/main_app_bar_widget.dart';
import 'package:todo/ui/main_screen/widgets/tasks_list_widget.dart';

import '../../src/themes/src/custom_extension.dart';
import '../navigation/routes.dart';

class MainScreenWidget extends StatefulWidget {
  const MainScreenWidget({Key? key}) : super(key: key);

  @override
  State<MainScreenWidget> createState() => _MainScreenWidgetState();
}

class _MainScreenWidgetState extends State<MainScreenWidget> {
  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>()!;

    return Scaffold(
      backgroundColor: customColors.backPrimary,
      body: const CustomScrollView(
        slivers: [
          MainAppBarWidget(),
          CompletedCountWidget(),
          TasksListWidget(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(
          AppPage.newTask.routePath,
        ),
        backgroundColor: customColors.blue,
        child: Icon(
          Icons.add,
          weight: 56,
          color: customColors.white,
        ),
      ),
    );
  }
}
