import 'package:flutter/material.dart';
import 'package:todo/ui/main_screen/widgets/completed_count_widget.dart';
import 'package:todo/ui/main_screen/widgets/main_app_bar_widget.dart';
import 'package:todo/ui/main_screen/widgets/tasks_list_widget.dart';

class MainScreenWidget extends StatefulWidget {
  final void Function(String?) onChangeTaskTap;

  const MainScreenWidget({Key? key, required this.onChangeTaskTap})
      : super(key: key);

  @override
  State<MainScreenWidget> createState() => _MainScreenWidgetState();
}

class _MainScreenWidgetState extends State<MainScreenWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const MainAppBarWidget(),
          const CompletedCountWidget(),
          TasksListWidget(onChangeTaskTap: widget.onChangeTaskTap),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => widget.onChangeTaskTap(null),
        child: const Icon(
          Icons.add,
          weight: 56,
          color: Colors.white,
        ),
      ),
    );
  }
}
