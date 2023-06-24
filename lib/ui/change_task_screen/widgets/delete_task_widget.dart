import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../generated/locale_keys.g.dart';
import '../../../models/new_task_model.dart';
import '../../../models/task_list_model.dart';
import '../../../themes/src/light_theme.dart';

class DeleteTaskWidget extends StatelessWidget {
  const DeleteTaskWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final String text = LocaleKeys.delete.tr();
    if (!context.read<NewTaskModel>().isNew) {
      return ListTile(
        onTap: () {
          context.read<TasksListModel>().deleteTaskWithLocalId(
              context.read<NewTaskModel>().newTask.localId);
          Navigator.of(context).pop();
        },
        leading: const Icon(
          Icons.delete,
          color: LightThemeColors.red,
        ),
        minLeadingWidth: 0,
        title: Text(
          text,
          style: const TextStyle(
            color: LightThemeColors.red,
          ),
        ),
      );
    } else {
      return ListTile(
        leading: const Icon(
          Icons.delete,
          color: LightThemeColors.labelDisable,
        ),
        minLeadingWidth: 0,
        title: Text(
          text,
          style: const TextStyle(
            color: LightThemeColors.labelDisable,
          ),
        ),
      );
    }
  }
}