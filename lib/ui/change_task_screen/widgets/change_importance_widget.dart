import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/generated/locale_keys.g.dart';
import 'package:todo/models/new_task_model.dart';
import 'package:todo/ui/change_task_screen/elements/importance_values.dart';

import '../../../di/service_locator.dart';
import '../../../firebase/firebase_remote_values.dart';
import '../../../firebase/firebase_worker.dart';
import '../../../src/logger.dart';
import '../../../src/themes/src/custom_extension.dart';

class ChangeImportanceWidget extends StatefulWidget {
  const ChangeImportanceWidget({Key? key}) : super(key: key);

  @override
  State<ChangeImportanceWidget> createState() => _ChangeImportanceWidgetState();
}

class _ChangeImportanceWidgetState extends State<ChangeImportanceWidget> {
  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>()!;
    final remoteConfig = locator<FirebaseWorker>().remoteConfig;
    final bool useNewImportantColor = remoteConfig.useNewImportantTaskColor;
    final MyLogger logger = locator<MyLogger>();
    remoteConfig.remoteConfig.onConfigUpdated
        .listen((RemoteConfigUpdate event) async {
      logger
          .i('RemoteConfigUpdate.updatedKeys: ${event.updatedKeys.join(', ')}');

      await remoteConfig.remoteConfig.activate();
      setState(() {});
    });
    final Color importantColor = useNewImportantColor
        ? RemoteValues.newImportantTaskColor
        : customColors.red!;
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
                  ? importantColor
                  : customColors.labelTertiary,
            ),
      );
    }

    return PopupMenuButton<String>(
      color: customColors.backSecondary,
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
                  color: importantColor,
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
