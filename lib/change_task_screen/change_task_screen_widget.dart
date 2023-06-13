import 'package:flutter/material.dart';
import 'package:todo/themes/src/light_theme.dart';

class ChangeTaskScreenWidget extends StatefulWidget {
  const ChangeTaskScreenWidget({Key? key}) : super(key: key);

  @override
  State<ChangeTaskScreenWidget> createState() => _ChangeTaskScreenWidgetState();
}

class _ChangeTaskScreenWidgetState extends State<ChangeTaskScreenWidget> {
  String priorityValue = 'Нет';
  bool haveDeadline = false;
  DateTime currentDate = DateTime.now();
  DateTime? deadlineDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(2020),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != currentDate) {
      setState(() {
        haveDeadline = true;
        deadlineDate = pickedDate; // todo: remake with task
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Сохранить'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, right: 16, left: 16),
        child: Container(
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  DescriptionWriteTaskWidget(),
                  DropdownButton<String>(
                    value: priorityValue,
                    isExpanded: true,
                    onChanged: (String? value) {
                      setState(() {
                        priorityValue = value!;
                      });
                    },
                    items: ['Нет', 'Низкий', '!! Высокий']
                        .map<DropdownMenuItem<String>>((String value) {
                      if (value == '!! Высокий') {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(color: LightThemeColors.red),
                          ),
                        );
                      } else {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                  const Divider(),
                  SwitchListTile(
                    title: const Text('Сделать до'),
                    subtitle: Text('2 июня 2021'),
                    // todo: Rechange deadline
                    value: haveDeadline,
                    onChanged: (bool value) {
                      print(haveDeadline);
                      if (haveDeadline) {
                        haveDeadline = false;
                      } else {
                        _selectDate(context);
                      }
                    },
                  ),
                  const Divider(),
                  const DeleteTaskWidget(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DeleteTaskWidget extends StatelessWidget {
  const DeleteTaskWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: const ListTile(
        leading: Icon(
          Icons.delete,
          color: LightThemeColors.red,
        ),
        title: Text(
          'Удалить',
          style: TextStyle(
            color: LightThemeColors.red,
          ),
        ),
      ),
      onTap: () {
        Navigator.of(context).pop();
      },
    );
  }
}

class DescriptionWriteTaskWidget extends StatelessWidget {
  const DescriptionWriteTaskWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      minLines: 4,
      maxLines: 50,
      decoration: InputDecoration(
          border: OutlineInputBorder(), hintText: 'Что надо сделать...'),
    );
  }
}
