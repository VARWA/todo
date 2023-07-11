import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/generated/locale_keys.g.dart';

import '../../../models/new_task_model.dart';
import '../../../src/themes/src/custom_extension.dart';

class ChangeDateWidget extends StatefulWidget {
  const ChangeDateWidget({Key? key}) : super(key: key);

  @override
  State<ChangeDateWidget> createState() => _ChangeDateWidgetState();
}

class _ChangeDateWidgetState extends State<ChangeDateWidget> {
  late Text subtitle;

  @override
  Widget build(BuildContext context) {
    final model = context.read<NewTaskModel>();
    final localization = context.deviceLocale;
    final customColors = Theme.of(context).extension<CustomColors>()!;

    Future<void> selectDate(BuildContext context) async {
      final DateTime? pickedDate = await showDatePicker(
        locale: localization,
        context: context,
        initialDate: model.currentDate,
        firstDate: DateTime(2020),
        lastDate: DateTime(2050),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: customColors.blue!,
                onSecondary: customColors.backSecondary!,
                onPrimary: customColors.white!,
                surface: Colors.transparent,
                onSurface: customColors.labelPrimary!,
                secondary: Colors.transparent,
              ),
              dialogBackgroundColor: customColors.backSecondary,
            ),
            child: child!,
          );
        },
      );
      if (pickedDate != null) {
        model.setDeadlineStatus(true);
        if (model.deadlineDate != pickedDate) {
          model.deadlineDate = pickedDate;
        }
      }
    }

    if (model.haveDeadline == true && model.deadlineDate != null) {
      subtitle = Text(
        DateFormat('d MMMM yyyy', localization.toString())
            .format(model.deadlineDate!),
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: customColors.blue,
            ),
      );
    } else {
      subtitle = Text(
        LocaleKeys.withoutDeadlineText.tr(),
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: customColors.labelTertiary,
            ),
      );
    }
    return SwitchListTile(
      inactiveThumbColor: customColors.backElevated,
      activeColor: customColors.blue,
      title: Text(
        LocaleKeys.deadline.tr(),
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: customColors.labelPrimary,
            ),
      ),
      subtitle: subtitle,
      value: context.watch<NewTaskModel>().haveDeadline &&
          subtitle.data != LocaleKeys.withoutDeadlineText.tr(),
      onChanged: (bool value) {
        setState(
          () {
            value ? selectDate(context) : model.setDeadlineStatus(false);
          },
        );
      },
    );
  }
}
