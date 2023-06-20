import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/new_task_model.dart';
import '../../themes/src/light_theme.dart';

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
    super.initState();
    _nameController = TextEditingController(text: model.taskText);
  }

  @override
  void didChangeDependencies() {
    _nameController.text = context.watch<NewTaskModel>().taskText;
    super.didChangeDependencies();
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
        decoration: const InputDecoration(
            filled: true,
            fillColor: LightThemeColors.white,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(
                color: Colors.grey,
                width: 0.0,
                style: BorderStyle.none,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            hintText: 'Что надо сделать...'),
      ),
    );
  }
}
