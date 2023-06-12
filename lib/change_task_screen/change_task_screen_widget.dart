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
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Сохранить'),
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
                    onChanged: (String? value) {
                      setState(() {
                        priorityValue = value!;
                      });
                    },
                    items: ['Нет', 'Низкий', 'Высокий']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                  const Divider(),
                  SizedBox(
                    height: 64,
                    child: SwitchListTile(
                        title: Text('Сделать до'),
                        visualDensity: VisualDensity(vertical: -3),
                        // to compact
                        subtitle: Text('2 июня 2021'),
                        value: haveDeadline,
                        onChanged: (bool value) {
                          _selectDate(context);
                        }),
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
