import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/generated/locale_keys.g.dart';

import '../../../models/new_task_model.dart';
import '../../../models/task_list_model.dart';
import '../../../models/task_model.dart';
import '../../../src/themes/src/custom_extension.dart';

class RechangeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const RechangeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>()!;
    Future<void> addTask() async {
      final newModel = context.read<NewTaskModel>();
      DateTime? deadlineLastValue;
      if (newModel.haveDeadline && newModel.deadlineDate != null) {
        deadlineLastValue = newModel.deadlineDate;
      }
      Task newTask = Task(
        id: newModel.newTask.id,
        text: newModel.taskText,
        deadline: deadlineLastValue,
        done: newModel.newTask.done,
        importance: newModel.newTask.importance,
        createdAt: newModel.isNew ? DateTime.now() : newModel.newTask.createdAt,
        changedAt: DateTime.now(),
      );
      await context.read<TasksListModel>().addTask(
            task: newTask,
            isNew: newModel.isNew,
          );
    }

    return AppBar(
      backgroundColor: customColors.backPrimary,
      leading: IconButton(
        icon: const Icon(
          Icons.close,
        ),
        color: customColors.labelPrimary,
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
            child: Text(
              LocaleKeys.save,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: customColors.blue,
                  ),
            ).tr(),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
