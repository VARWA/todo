import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../models/task_list_model.dart';
import '../../../models/task_model.dart';
import '../../../themes/src/light_theme.dart';
import '../../change_task_screen/elements/importance_values.dart';

class TaskInListWithDeadlineWidget extends StatelessWidget {
  final void Function(String?) onChangeTaskTap;

  const TaskInListWithDeadlineWidget({
    super.key,
    required this.task,
    required this.model,
    required this.id,
    required this.formattedTitle,
    required this.deadline,
    required this.onChangeTaskTap,
  });

  final Task task;
  final TasksListModel model;
  final String id;
  final Widget formattedTitle;
  final DateTime? deadline;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      horizontalTitleGap: 0,
      leading: Checkbox(
        value: task.done,
        activeColor: LightThemeColors.green,
        checkColor: LightThemeColors.white,
        fillColor: MaterialStateProperty.resolveWith(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return task.importance == ImportanceValues.importantGlobal
                  ? OtherColors.redCheckboxFillColor
                  : Theme.of(context).cardColor;
            }
            return null;
          },
        ),
        side: task.importance == ImportanceValues.importantGlobal
            ? const BorderSide(color: LightThemeColors.red)
            : BorderSide(color: Theme.of(context).unselectedWidgetColor),
        onChanged: (bool? value) {
          model.switchCompleted(id);
        },
      ),
      title: formattedTitle,
      subtitle: (deadline != null)
          ? Text(
              DateFormat('d MMMM yyyy', context.deviceLocale.toString())
                  .format(deadline!),
            )
          : null,
      trailing: IconButton(
        icon: const Icon(
          Icons.info_outline_rounded,
        ),
        onPressed: () => onChangeTaskTap(task.id),
      ),
    );
  }
}
