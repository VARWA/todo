import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:todo/ui/main_screen/widgets/task_in_list_with_deadline_widget.dart';
import 'package:todo/ui/main_screen/widgets/task_in_list_without_deadline_widget.dart';

import '../../../models/task_list_model.dart';
import '../../../models/task_model.dart';
import '../../../themes/src/light_theme.dart';
import '../../change_task_screen/elements/importance_values.dart';

class TaskInListWidget extends StatefulWidget {
  final String id;
  final void Function(String?) onChangeTaskTap;

  const TaskInListWidget(
      {super.key, required this.id, required this.onChangeTaskTap});

  @override
  State<TaskInListWidget> createState() => _TaskInListWidgetState();
}

class _TaskInListWidgetState extends State<TaskInListWidget> {
  Text setTextStyle(Task task) {
    int maxLines = 3;
    TextOverflow myOverflow = TextOverflow.ellipsis;
    if (task.done == true) {
      if (task.importance == ImportanceValues.basicGlobal) {
        return Text(
          task.text,
          style: const TextStyle(
              decoration: TextDecoration.lineThrough,
              color: OtherColors.comlitedTaskInList),
          maxLines: maxLines,
          overflow: myOverflow,
        );
      }
      return Text(
        task.text,
        style: const TextStyle(
            decoration: TextDecoration.lineThrough,
            color: OtherColors.comlitedTaskInList),
        maxLines: maxLines,
        overflow: myOverflow,
      );
    }
    return Text(
      task.text,
      maxLines: maxLines,
      overflow: myOverflow,
    );
  }

  Widget setTitle({required Task task, required Text text}) {
    if (task.done || task.importance == ImportanceValues.basicGlobal) {
      return Row(
        children: [
          Expanded(child: text),
        ],
      );
    } else if (task.importance == ImportanceValues.highGlobal) {
      final Widget highImportanceIcon = SvgPicture.asset(
        'assets/priority_icons/high_importance_icon.svg',
        width: 16,
        height: 20,
      );
      return Row(
        children: [
          highImportanceIcon,
          const SizedBox(width: 3),
          Expanded(child: text),
        ],
      );
    } else {
      final Widget lowImportanceIcon = SvgPicture.asset(
        'assets/priority_icons/low_importance_icon.svg',
        width: 16,
        height: 20,
      );
      return Row(
        children: [
          lowImportanceIcon,
          const SizedBox(width: 3),
          Expanded(child: text),
        ],
      );
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<TasksListModel>();
    final id = widget.id;
    final Task task = model.tasksList[model.searchTaskIndexById(id)];

    final Text formattedText = setTextStyle(task);
    final formattedTitle = setTitle(task: task, text: formattedText);
    final DateTime? deadline = task.deadline;
    if (deadline != null) {
      return TaskInListWithDeadlineWidget(
        task: task,
        model: model,
        id: id,
        formattedTitle: formattedTitle,
        deadline: deadline,
        onChangeTaskTap: widget.onChangeTaskTap,
      );
    } else {
      return TaskInListWithoutDeadlineWidget(
        task: task,
        model: model,
        id: id,
        formattedTitle: formattedTitle,
        onChangeTaskTap: widget.onChangeTaskTap,
      );
    }
  }
}
