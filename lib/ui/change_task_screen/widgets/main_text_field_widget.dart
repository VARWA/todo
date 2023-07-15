import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/generated/locale_keys.g.dart';

import '../../../models/new_task_model.dart';
import '../../../src/themes/src/custom_extension.dart';

class MainTextField extends StatefulWidget {
  const MainTextField({super.key});

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
    final customColors = Theme.of(context).extension<CustomColors>()!;
    return Container(
      decoration: ShapeDecoration(
        color: customColors.backSecondary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x1E000000),
            blurRadius: 2,
            offset: Offset(0, 2),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Color(0x0F000000),
          ),
        ],
      ),
      child: TextField(
        autofocus: true,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: customColors.labelPrimary,
            ),
        controller: _nameController,
        onChanged: model.setTaskText,
        minLines: 4,
        maxLines: 50,
        decoration: InputDecoration(
          filled: true,
          fillColor: customColors.backSecondary,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
          hintText: LocaleKeys.textForEmptyTaskField.tr(),
          hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: customColors.labelTertiary,
              ),
        ),
      ),
    );
  }
}
