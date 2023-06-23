import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/generated/locale_keys.g.dart';

import '../../../models/new_task_model.dart';
import '../../../themes/src/light_theme.dart';

class MainTextField extends StatefulWidget {
  const MainTextField({
    super.key,
  });

  @override
  State<MainTextField> createState() => _MainTextFieldState();
}

class _MainTextFieldState extends State<MainTextField> {
  late TextEditingController _nameController;

  @override
  void initState() {
    final model = Provider.of<NewTaskModel>(context, listen: false);
    model.setInitText(model.newTask.text);
    super.initState();
    _nameController = TextEditingController(text: model.taskText);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final model = context.read<NewTaskModel>();
    return Material(
      elevation: 2,
      child: TextField(
        controller: _nameController,
        onChanged: model.setTaskText,
        minLines: 4,
        maxLines: 50,
        decoration: InputDecoration(
            filled: true,
            fillColor: LightThemeColors.white,
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(
                color: Colors.grey,
                width: 0.0,
                style: BorderStyle.none,
              ),
            ),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            hintText: LocaleKeys.textForEmptyTaskField.tr()),
      ),
    );
  }
}
