import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/new_task_model.dart';
import 'package:todo/src/importance_values.dart';

import '../../../themes/src/light_theme.dart';

class ChangeImportanceWidget extends StatelessWidget {
  const ChangeImportanceWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: ImportanceValues.convertFromIntToString(
          context.watch<NewTaskModel>().newTask.importance),
      onChanged: (String? value) {
        context.read<NewTaskModel>().setPriorityLevel(
            ImportanceValues.convertFromLocalToGlobal(value!));
      },
      items: [
        ImportanceValues.basic,
        ImportanceValues.low,
        ImportanceValues.high
      ].map<DropdownMenuItem<String>>(
        (String value) {
          if (value == ImportanceValues.high) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: const TextStyle(color: LightThemeColors.red),
              ),
            );
          } else {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }
        },
      ).toList(),
    );
  }
}
