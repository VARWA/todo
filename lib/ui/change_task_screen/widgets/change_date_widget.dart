import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/generated/locale_keys.g.dart';

import '../../../models/new_task_model.dart';

class ChangeDateWidget extends StatefulWidget {
  const ChangeDateWidget({Key? key}) : super(key: key);

  @override
  State<ChangeDateWidget> createState() => _ChangeDateWidgetState();
}

class _ChangeDateWidgetState extends State<ChangeDateWidget> {
  late String subtitle;

  @override
  Widget build(BuildContext context) {
    final model = context.read<NewTaskModel>();
    final localization = context.deviceLocale;

    Future<void> selectDate(BuildContext context) async {
      final DateTime? pickedDate = await showDatePicker(
          locale: localization,
          context: context,
          initialDate: model.currentDate,
          firstDate: DateTime(2020),
          lastDate: DateTime(2050));
      if (pickedDate != null) {
        model.setDeadlineStatus(true);
        if (model.deadlineDate != pickedDate) {
          model.deadlineDate = pickedDate;
        }
      }
    }

    if (model.haveDeadline == true && model.deadlineDate != null) {
      subtitle = DateFormat('d MMMM yyyy', localization.toString())
          .format(model.deadlineDate!);
    } else {
      subtitle = LocaleKeys.withoutDeadlineText.tr();
    }
    return SwitchListTile(
      title: const Text(LocaleKeys.deadline).tr(),
      subtitle: Text(subtitle),
      value: context.watch<NewTaskModel>().haveDeadline &&
          subtitle != LocaleKeys.withoutDeadlineText.tr(),
      onChanged: (bool value) {
        setState(
          () {
            if (value == false) {
              model.setDeadlineStatus(false);
            } else {
              selectDate(context);
            }
          },
        );
      },
    );
  }
}
