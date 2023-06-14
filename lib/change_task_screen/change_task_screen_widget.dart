import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/themes/src/light_theme.dart';

import '../data/db_helper.dart';

class ChangeTaskScreenWidget extends StatefulWidget {
  const ChangeTaskScreenWidget({Key? key}) : super(key: key);

  @override
  State<ChangeTaskScreenWidget> createState() => _ChangeTaskScreenWidgetState();
}

class _ChangeTaskScreenWidgetState extends State<ChangeTaskScreenWidget> {
  // DBHelper? dbHelper;
  // late List<Task> _tasks_list;

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
  // @override
  // void initState() {
  //   super.initState();
  //   dbHelper = DBHelper();
  //   loadData();
  // }
  //
  // loadData() async {
  //   _tasks_list = await dbHelper!.getDataList();
  // }


  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    // if (args != null){
    //   final old_task = (args as List)[1];
    //   Task new_task = old_task;
    // } else {
    //   Task new_task =
    // }
    print(args);

    Logger logging = Logger(printer: PrettyPrinter());
    var textController = TextEditingController();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(
              Icons.close,
            ),
            color: LightThemeColors.labelPrimary,
            onPressed: () {
              Navigator.of(context).pop();
            }),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: TextButton(
              onPressed: () {
                Task newTask = Task(
                  id: 4,
                  task_name: textController.text,
                  date_deadline: deadlineDate,
                  priority_level: 0,
                );
                logging.i('$newTask');
                Navigator.of(context).pop();
              },
              child: const Text('Сохранить'),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, right: 16, left: 16),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Material(
                  elevation: 2,
                  child: TextField(
                    controller: textController,
                    minLines: 4,
                    maxLines: 50,
                    decoration: const InputDecoration(
                        filled: true,
                        fillColor: LightThemeColors.white,
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 0.0),
                        ),
                        border: OutlineInputBorder(
                          gapPadding: 8,
                        ),
                        hintText: 'Что надо сделать...'),
                  ),
                ),
                const SizedBox(height: 16),
                ListTile(
                  title: const Text('Важность'),
                  subtitle: DropdownButton<String>(
                    value: priorityValue,
                    // isExpanded: true,
                    onChanged: (String? value) {
                      setState(() {
                        priorityValue = value!;
                      });
                    },
                    items: ['Нет', 'Низкий', '!! Высокий']
                        .map<DropdownMenuItem<String>>(
                      (String value) {
                        if (value == '!! Высокий') {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(color: LightThemeColors.red),
                            ),
                          );
                        } else {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }
                      },
                    ).toList(),
                  ),
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
