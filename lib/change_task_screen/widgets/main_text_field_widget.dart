import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/new_task_model.dart';
import '../../themes/src/light_theme.dart';

class MainTextField extends StatelessWidget {
  const MainTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController(
        text: context.watch<NewTaskModel>().newTask.taskName);
    return Material(
      elevation: 2,
      child: TextField(
        controller: textController,
        minLines: 4,
        maxLines: 50,
        decoration: const InputDecoration(
            filled: true,
            fillColor: LightThemeColors.white,
            enabledBorder: OutlineInputBorder(
              borderRadius:
              BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(
                color: Colors.grey,
                width: 0.0,
                style: BorderStyle.none,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius:
              BorderRadius.all(Radius.circular(10.0)),
            ),
            hintText: 'Что надо сделать...'),
      ),
    );
  }
}
