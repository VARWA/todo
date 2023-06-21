import 'package:flutter/material.dart';
import 'package:todo/navigation/routes.dart';
import 'package:todo/ui/main_screen/widgets/main_app_bar_widget.dart';
import 'package:todo/ui/main_screen/widgets/tasks_list_widget.dart';

class MainScreenWidget extends StatefulWidget {
  const MainScreenWidget({Key? key}) : super(key: key);

  @override
  State<MainScreenWidget> createState() => _MainScreenWidgetState();
}

class _MainScreenWidgetState extends State<MainScreenWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const CustomScrollView(
        slivers: [
          MainAppBarWidget(),
          TasksListWidget(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, RouteNames.changeTask);
        },
        child: const Icon(
          Icons.add,
          weight: 56,
          color: Colors.white,
        ),
      ),
    );
  }
}
