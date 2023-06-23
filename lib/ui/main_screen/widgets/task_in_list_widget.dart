import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../models/task_list_model.dart';
import '../../../models/task_model.dart';
import '../../../themes/src/light_theme.dart';
import '../../change_task_screen/elements/importance_values.dart';
import '../../navigation/routes.dart';

class TaskInListWidget extends StatefulWidget {
  final int id;

  const TaskInListWidget({super.key, required this.id});

  @override
  State<TaskInListWidget> createState() => _TaskInListWidgetState();
}

class _TaskInListWidgetState extends State<TaskInListWidget> {
  Text setTextStyle(Task task) {
    if (task.done == true) {
      if (task.importance == ImportanceValues.basicGlobal) {
        return Text(
          task.text,
          style: const TextStyle(
              decoration: TextDecoration.lineThrough,
              color: OtherColors.comlitedTaskInList),
        );
      }
      return Text(
        task.text,
        style: const TextStyle(
            decoration: TextDecoration.lineThrough,
            color: OtherColors.comlitedTaskInList),
      );
    }
    return Text(task.text);
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<TasksListModel>();
    final id = widget.id;
    final Task task = model.tasksList[model.searchTaskIndexById(id)];
    final Text formattedText = setTextStyle(task);
    final DateTime? deadline = task.deadline;
    if (deadline != null) {
      return ListTile(
        horizontalTitleGap: 0,
        leading: Checkbox(
          value: task.done,
          activeColor: LightThemeColors.green,
          checkColor: LightThemeColors.white,
          fillColor: MaterialStateProperty.resolveWith(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return task.importance == ImportanceValues.highGlobal
                    ? OtherColors.redCheckboxFillColor
                    : Theme.of(context).cardColor;
              }
              return null;
            },
          ),
          side: task.importance == ImportanceValues.highGlobal
              ? const BorderSide(color: LightThemeColors.red)
              : BorderSide(color: Theme.of(context).unselectedWidgetColor),
          onChanged: (bool? value) {
            if (value!) {
              model.makeCompleted(id);
            } else {
              model.makeUncompleted(id);
            }
          },
        ),
        title: formattedText,
        subtitle: Text(DateFormat('d MMMM yyyy').format(deadline)),
        trailing: IconButton(
            icon: const Icon(
              Icons.info_outline_rounded,
            ),
            onPressed: () {
              // Navigator.pushNamed(context, RouteNames.changeTask);
              Navigator.pushNamed(context, RouteNames.changeTask,
                  arguments: task.localId);
            }),
      );
    } else {
      return ListTile(
        horizontalTitleGap: 0,
        leading: Checkbox(
          value: task.done,
          activeColor: LightThemeColors.green,
          checkColor: LightThemeColors.white,
          fillColor: MaterialStateProperty.resolveWith(
            (Set<MaterialState> states) {
              if (!states.contains(MaterialState.selected)) {
                return task.importance == ImportanceValues.highGlobal
                    ? OtherColors.redCheckboxFillColor
                    : Theme.of(context).cardColor;
              }
              return null;
            },
          ),
          side: task.importance == ImportanceValues.highGlobal
              ? const BorderSide(color: LightThemeColors.red)
              : BorderSide(color: Theme.of(context).unselectedWidgetColor),
          onChanged: (bool? value) {
            if (value!) {
              model.makeCompleted(id);
            } else {
              model.makeUncompleted(id);
            }
          },
        ),
        title: formattedText,
        trailing: IconButton(
          icon: const Icon(
            Icons.info_outline_rounded,
          ),
          onPressed: () {
            // Navigator.pushNamed(context, RouteNames.changeTask);
            Navigator.pushNamed(context, RouteNames.changeTask,
                arguments: task.localId);
          },
        ),
      );
    }
  }
}
