import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../generated/locale_keys.g.dart';
import '../../../models/new_task_model.dart';
import '../../../models/task_list_model.dart';
import '../../../src/themes/src/custom_extension.dart';

class DeleteTaskWidget extends StatelessWidget {
  const DeleteTaskWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final String text = LocaleKeys.delete.tr();
    final customColors = Theme.of(context).extension<CustomColors>()!;
    final bool isNew = context.read<NewTaskModel>().isNew;
    final textColor = isNew ? customColors.labelDisable : customColors.red;
    return ListTile(
      onTap: () {
        if (!isNew) {
          context
              .read<TasksListModel>()
              .deleteTaskWithId(context.read<NewTaskModel>().newTask.id);
          Navigator.of(context).pop();
        }
      },
      leading: Icon(
        Icons.delete,
        color: textColor,
      ),
      minLeadingWidth: 0,
      title: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: textColor,
            ),
      ),
    );
  }
}
