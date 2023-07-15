import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:todo/ui/main_screen/widgets/task_in_listtile_widget.dart';

import '../../../models/task_list_model.dart';
import '../../../models/task_model.dart';
import '../../../src/themes/src/custom_extension.dart';
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
  Text setTextStyle({required Task task, required CustomColors customColors}) {
    int maxLines = 3;
    TextOverflow myOverflow = TextOverflow.ellipsis;
    final themeBodyMedium = Theme.of(context).textTheme.bodyMedium;
    return Text(
      task.text,
      style: task.done
          ? themeBodyMedium?.copyWith(
              decoration: TextDecoration.lineThrough,
              color: customColors.labelTertiary)
          : themeBodyMedium?.copyWith(
              color: customColors.labelPrimary,
            ),
      maxLines: maxLines,
      overflow: myOverflow,
    );
  }

  Widget setTitle({required Task task, required Text text}) {
    if (task.done || task.importance == ImportanceValues.basicGlobal) {
      return Row(
        children: [
          Expanded(
            child: text,
          ),
        ],
      );
    } else if (task.importance == ImportanceValues.importantGlobal) {
      final Widget highImportanceIcon = SvgPicture.asset(
        'assets/priority_icons/high_importance_icon.svg',
        width: 16,
        height: 20,
      );
      return Row(
        children: [
          highImportanceIcon,
          const SizedBox(
            width: 3,
          ),
          Expanded(
            child: text,
          ),
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
          const SizedBox(
            width: 3,
          ),
          Expanded(
            child: text,
          ),
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
    final customColors = Theme.of(context).extension<CustomColors>()!;
    final id = widget.id;
    final Task task = model.tasksList[model.searchTaskIndexById(id)];

    final Text formattedText = setTextStyle(
      task: task,
      customColors: customColors,
    );
    final formattedTitle = setTitle(
      task: task,
      text: formattedText,
    );
    final DateTime? deadline = task.deadline;
    return TaskInListtileWidget(
      task: task,
      model: model,
      id: id,
      formattedTitle: formattedTitle,
      deadline: deadline,
      onChangeTaskTap: widget.onChangeTaskTap,
    );
  }
}
