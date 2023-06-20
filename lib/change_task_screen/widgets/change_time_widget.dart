import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../models/new_task_model.dart';

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

    Future<void> selectDate(BuildContext context) async {
      final DateTime? pickedDate = await showDatePicker(
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
      subtitle = DateFormat('d MMMM yyyy').format(model.deadlineDate!);
    } else {
      subtitle = 'Нет';
    }
    return SwitchListTile(
      title: const Text('Сделать до'),
      subtitle: Text(subtitle),
      value: context.watch<NewTaskModel>().haveDeadline,
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
