import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../../../models/task_list_model.dart';
import '../../../themes/src/light_theme.dart';

import 'completed_count_widget.dart';
import 'new_list_tile_widget.dart';
import 'task_in_list_widget.dart';

class TasksListWidget extends StatefulWidget {
  const TasksListWidget({
    super.key,
  });

  @override
  State<TasksListWidget> createState() => _TasksListWidgetState();
}

class _TasksListWidgetState extends State<TasksListWidget> {
  Logger logger = Logger(printer: PrettyPrinter());

  @override
  Widget build(BuildContext context) {
    final model = context.watch<TasksListModel>();
    final lenList = model.tasksListForMenu.length;
    logger.d('Downloaded to main list $lenList tasks');
    final items = List<Widget>.generate(
      lenList + 1,
      (index) {
        if (index != lenList) {
          return Dismissible(
            key: UniqueKey(),
            background: Container(
              color: LightThemeColors.green,
              child: const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 28),
                  child: Icon(
                    Icons.done,
                    color: LightThemeColors.white,
                    size: 18,
                  ),
                ),
              ),
            ),
            secondaryBackground: Container(
              color: LightThemeColors.red,
              child: const Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 28),
                  child: Icon(
                    Icons.delete,
                    color: LightThemeColors.white,
                    size: 18,
                  ),
                ),
              ),
            ),
            confirmDismiss: (DismissDirection direction) async {
              if (direction == DismissDirection.startToEnd) {
                model.switchCompleted(model.tasksListForMenu[index].localId);
              } else {
                model.deleteTaskWithLocalId(
                    model.tasksListForMenu[index].localId);
              }
              return;
            },
            child: TaskInListWidget(
              id: model.tasksListForMenu[index].localId,
            ),
          );
        } else {
          return const NewListTileWidget();
        }
      },
    );
    return SliverToBoxAdapter(
      child: Column(
        children: [
          const CompletedCountWidget(),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.only(right: 8, left: 8, bottom: 20),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 4,
              shadowColor: Colors.black,
              color: Theme.of(context).cardColor,
              child: Column(
                children: items,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
