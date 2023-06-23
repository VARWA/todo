import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/generated/locale_keys.g.dart';

import '../../../models/new_task_model.dart';
import '../../../models/task_list_model.dart';
import '../../../models/task_model.dart';
import '../../../themes/src/light_theme.dart';

class RechangeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const RechangeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    void addTask() {
      final newModel = context.read<NewTaskModel>();
      DateTime? deadlineLastValue;
      if (newModel.haveDeadline && newModel.deadlineDate != null) {
        deadlineLastValue = newModel.deadlineDate;
      }
      Task newTask = Task(
        localId: newModel.newTask.localId,
        text: newModel.taskText,
        deadline: deadlineLastValue,
        done: newModel.newTask.done,
        importance: newModel.newTask.importance,
        createdAt: newModel.isNew ? DateTime.now() : newModel.newTask.createdAt,
        changedAt: DateTime.now(),
      );
      context.read<TasksListModel>().addTask(newTask, newModel.isNew);
    }

    return AppBar(
      leading: IconButton(
        icon: const Icon(
          Icons.close,
        ),
        color: LightThemeColors.labelPrimary,
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: TextButton(
            onPressed: () {
              addTask();
              Navigator.of(context).pop();
            },
            child: const Text(LocaleKeys.save).tr(),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
