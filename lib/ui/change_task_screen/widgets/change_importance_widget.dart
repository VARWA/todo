import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/generated/locale_keys.g.dart';
import 'package:todo/models/new_task_model.dart';
import 'package:todo/ui/change_task_screen/elements/importance_values.dart';

import '../../../src/themes/src/custom_extension.dart';

class ChangeImportanceWidget extends StatelessWidget {
  const ChangeImportanceWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>()!;
    Map<String, String> localeValues = {
      'important': LocaleKeys.highImportance.tr(),
      'basic': LocaleKeys.basicImportance.tr(),
      'low': LocaleKeys.lowImportance.tr(),
    };
    String convertGlobalToLocale(String value) {
      return switch (value) {
        ImportanceValues.importantGlobal => localeValues['important']!,
        ImportanceValues.basicGlobal => localeValues['basic']!,
        ImportanceValues.lowGlobal => localeValues['low']!,
        _ => localeValues['basic']!
      };
    }

    Text setTextWithStyle(value) {
      return Text(
        value,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: value == localeValues['important']
                  ? customColors.red
                  : customColors.labelTertiary,
            ),
      );
    }

    return PopupMenuButton<String>(color: customColors.backSecondary,
      initialValue: convertGlobalToLocale(
          context.read<NewTaskModel>().newTask.importance),
      itemBuilder: (_) => [
        PopupMenuItem<String>(
          value: ImportanceValues.basicGlobal,
          child: Text(
            localeValues['basic']!,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: customColors.labelPrimary,
                ),
          ),
        ),
        PopupMenuItem<String>(
          value: ImportanceValues.lowGlobal,
          child: Text(
            localeValues['low']!,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: customColors.labelPrimary,
                ),
          ),
        ),
        PopupMenuItem<String>(
          value: ImportanceValues.importantGlobal,
          child: Text(
            localeValues['important']!,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: customColors.red,
                ),
          ),
        )
      ],
      onSelected: (value) {
        context.read<NewTaskModel>().setPriorityLevel(value);
      },
      child: ListTile(
        title: Text(
          LocaleKeys.importance.tr(),
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: customColors.labelPrimary,
              ),
        ),
        subtitle: setTextWithStyle(
          convertGlobalToLocale(
            context.watch<NewTaskModel>().newTask.importance,
          ),
        ),
      ),
    );
  }
}
