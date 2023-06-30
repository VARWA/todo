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

    Text setTextWithStyle(value) {
      if (value == localeValues['high']) {
        return Text(
          value,
          style: const TextStyle(color: LightThemeColors.red),
        );
      } else {
        return Text(value);
      }
    }

    return PopupMenuButton<String>(
      initialValue: convertGlobalToLocale(
          context.read<NewTaskModel>().newTask.importance),
      itemBuilder: (_) => [
        PopupMenuItem<String>(
          value: ImportanceValues.basicGlobal,
          child: Text(localeValues['basic']!),
        ),
        PopupMenuItem<String>(
          value: ImportanceValues.lowGlobal,
          child: Text(localeValues['low']!),
        ),
        PopupMenuItem<String>(
          value: ImportanceValues.highGlobal,
          child: Text(
            localeValues['high']!,
            style: const TextStyle(color: LightThemeColors.red),
          ),
        )
      ],
      onSelected: (value) {
        context.read<NewTaskModel>().setPriorityLevel(value);
      },
      child: ListTile(
        title: Text(
          LocaleKeys.importance.tr(),
        ),
        subtitle: setTextWithStyle(
          convertGlobalToLocale(
              context.watch<NewTaskModel>().newTask.importance),
        ),
      ),
    );
  }
}
