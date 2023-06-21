import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/new_task_model.dart';
import '../../../models/task_list_model.dart';
import '../../../themes/src/light_theme.dart';

class DeleteTaskWidget extends StatelessWidget {
  const DeleteTaskWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (!context.read<NewTaskModel>().isNew) {
      return ListTile(
        onTap: () {
          context
              .read<TasksListModel>()
              .deleteTaskWithId(context.read<NewTaskModel>().newTask.localId);
          Navigator.of(context).pop();
        },
        leading: const Icon(
          Icons.delete,
          color: LightThemeColors.red,
        ),
        minLeadingWidth: 0,
        title: const Text(
          'Удалить',
          style: TextStyle(
            color: LightThemeColors.red,
          ),
        ),
      );
    } else {
      return const ListTile(
        leading: Icon(
          Icons.delete,
          color: LightThemeColors.labelDisable,
        ),
        minLeadingWidth: 0,
        title: Text(
          'Удалить',
          style: TextStyle(
            color: LightThemeColors.labelDisable,
          ),
        ),
      );
    }
  }
}
