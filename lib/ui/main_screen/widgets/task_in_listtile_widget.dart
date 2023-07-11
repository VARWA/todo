import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../models/task_list_model.dart';
import '../../../models/task_model.dart';
import '../../../src/themes/src/custom_extension.dart';
import '../../../src/themes/theme.dart';
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
    final customColors = Theme.of(context).extension<CustomColors>()!;
    return ListTile(
      horizontalTitleGap: 0,
      leading: Checkbox(
        value: task.done,
        activeColor: customColors.green,
        checkColor: customColors.white,
        fillColor: MaterialStateProperty.resolveWith(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return task.importance == ImportanceValues.importantGlobal
                  ? customColors.red
                  : customColors.backSecondary;
            }
            return null;
          },
        ),
        side: task.importance == ImportanceValues.importantGlobal
            ? const BorderSide(
                color: LightThemeColors.red,
              )
            : BorderSide(
                color: customColors.supportSeparator!,
              ),
        onChanged: (bool? value) {
          model.switchCompleted(id);
        },
      ),
      title: formattedTitle,
      subtitle: (deadline != null)
          ? Text(
              DateFormat(
                'd MMMM yyyy',
                context.deviceLocale.toString(),
              ).format(deadline!),
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: customColors.labelTertiary,
                  ),
            )
          : null,
      trailing: IconButton(
        icon: Icon(
          Icons.info_outline_rounded,
          color: customColors.labelTertiary,
        ),
        onPressed: () => onChangeTaskTap(
          task.id,
        ),
      ),
    );
  }
}
