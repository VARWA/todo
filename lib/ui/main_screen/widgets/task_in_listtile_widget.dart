import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo/firebase/firebase_remote_values.dart';
import 'package:todo/firebase/firebase_worker.dart';

import '../../../di/service_locator.dart';
import '../../../models/task_list_model.dart';
import '../../../models/task_model.dart';
import '../../../src/themes/src/custom_extension.dart';
import '../../change_task_screen/elements/importance_values.dart';

class TaskInListtileWidget extends StatefulWidget {
  final void Function(String?) onChangeTaskTap;

  const TaskInListtileWidget({
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
  State<TaskInListtileWidget> createState() => _TaskInListtileWidgetState();
}

class _TaskInListtileWidgetState extends State<TaskInListtileWidget> {
  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>()!;
    final remoteConfig = locator<FirebaseWorker>().remoteConfig;
    final bool useNewImportantColor = remoteConfig.useNewImportantTaskColor;
    Color importantColor = useNewImportantColor
        ? RemoteValues.newImportantTaskColor
        : customColors.red!;

    return ListTile(
      horizontalTitleGap: 0,
      leading: Checkbox(
        value: widget.task.done,
        activeColor: customColors.green,
        checkColor: customColors.white,
        fillColor: MaterialStateProperty.resolveWith(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return widget.task.importance == ImportanceValues.importantGlobal
                  ? importantColor
                  : customColors.backSecondary;
            }
            return null;
          },
        ),
        side: widget.task.importance == ImportanceValues.importantGlobal
            ? BorderSide(
                color: importantColor,
              )
            : BorderSide(
                color: customColors.supportSeparator!,
              ),
        onChanged: (bool? value) {
          widget.model.switchCompleted(localId: widget.id);
        },
      ),
      title: widget.formattedTitle,
      subtitle: (widget.deadline != null)
          ? Text(
              DateFormat(
                'd MMMM yyyy',
                context.deviceLocale.toString(),
              ).format(widget.deadline!),
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
        onPressed: () => widget.onChangeTaskTap(
          widget.task.id,
        ),
      ),
    );
  }
}
