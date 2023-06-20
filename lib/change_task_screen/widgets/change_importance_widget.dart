import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/change_task_screen/widgets/priority_values.dart';
import 'package:todo/models/new_task_model.dart';

import '../../themes/src/light_theme.dart';

class ChangeImportanceWidget extends StatelessWidget {
  const ChangeImportanceWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: PriorityValue.convertFromIntToString(context.watch<NewTaskModel>().newTask.priorityLevel),
      onChanged: (String? value) {

        context.read<NewTaskModel>().setPriorityLevel(PriorityValue.convertFromStringToInt(value!));
      },
      items: [PriorityValue.no, PriorityValue.low, PriorityValue.high]
          .map<DropdownMenuItem<String>>(
        (String value) {
          if (value == PriorityValue.high) {
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
