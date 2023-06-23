import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/generated/locale_keys.g.dart';
import 'package:todo/models/new_task_model.dart';
import 'package:todo/ui/change_task_screen/elements/importance_values.dart';

import '../../../themes/src/light_theme.dart';

class ChangeImportanceWidget extends StatelessWidget {
  const ChangeImportanceWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, String> localeValues = {
      'high': LocaleKeys.highImportance.tr(),
      'basic': LocaleKeys.basicImportance.tr(),
      'low': LocaleKeys.lowImportance.tr(),
    };
    String convertGlobalToLocale(String value) {
      return switch (value) {
        ImportanceValues.highGlobal => localeValues['high']!,
        ImportanceValues.basicGlobal => localeValues['basic']!,
        ImportanceValues.lowGlobal => localeValues['low']!,
        _ => localeValues['basic']!
      };
    }

    String convertLocaleToGlobal(String value) {
      if (localeValues['high'] == value) return ImportanceValues.highGlobal;
      if (localeValues['basic'] == value) return ImportanceValues.basicGlobal;
      if (localeValues['low'] == value) return ImportanceValues.lowGlobal;
      return ImportanceValues.basicGlobal;
    }

    return DropdownButton<String>(
      value: convertGlobalToLocale(
          context.watch<NewTaskModel>().newTask.importance),
      onChanged: (String? value) {
        context
            .read<NewTaskModel>()
            .setPriorityLevel(convertLocaleToGlobal(value!));
      },
      items: [
        localeValues['basic']!,
        localeValues['low']!,
        localeValues['high']!,
      ].map<DropdownMenuItem<String>>(
        (String value) {
          if (value == localeValues['high']) {
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
