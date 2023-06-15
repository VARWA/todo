import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:todo/change_task_screen/new_task_model.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/models/task_list_model.dart';
import 'package:todo/themes/src/light_theme.dart';

class ChangeTaskScreenWidget extends StatefulWidget {
  const ChangeTaskScreenWidget({Key? key}) : super(key: key);

  @override
  State<ChangeTaskScreenWidget> createState() => _ChangeTaskScreenWidgetState();
}

class _ChangeTaskScreenWidgetState extends State<ChangeTaskScreenWidget> {
  Logger logger = Logger(printer: PrettyPrinter());

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    final model = context.read<TasksListModel>();
    int? maxId;
    Task? newTaskFromList;
    bool isNew = false;

    if (args != null) {
      final oldTask = model.tasksList[model.searchTaskIndexById(args as int)];
      newTaskFromList = Task(
        id: oldTask.id,
        task_name: oldTask.task_name,
        priority_level: oldTask.priority_level,
        date_deadline: oldTask.date_deadline,
        completed: oldTask.completed,
      );
    } else {
      maxId = context.read<TasksListModel>().maxId;
      isNew = true;
    }
    logger.i('Args results: $newTaskFromList, $maxId');
    Task createNewTask(id) {
      return Task(
        id: id + 1,
        task_name: '',
        priority_level: 0,
        date_deadline: DateTime.now(),
      );
    }

    Task createPreTask(int? maxId, Task? newTaskFromList) {
      logger.i('Data for create PreNewTask max_Id from task_list: $maxId,'
          ' task for recreating : $newTaskFromList');
      if (newTaskFromList != null) {
        return newTaskFromList;
      } else {
        return createNewTask(maxId);
      }
    }

    final createdPreTask = createPreTask(maxId, newTaskFromList);

    return ListenableProvider(
      create: (_) => NewTaskModel(newTask: createdPreTask, isNew: isNew),
      builder: (context, child) {
        final textController = TextEditingController(
            text: context.watch<NewTaskModel>().newTask.task_name);

        if (createdPreTask.date_deadline != null) {
          context.read<NewTaskModel>().setDeadlineStatus(true);
          context.read<NewTaskModel>().deadlineDate =
              createdPreTask.date_deadline;
        }
        void addTask() {
          final newModel = context.read<NewTaskModel>();
          DateTime? deadlineLastValue;
          if (newModel.haveDeadline && newModel.deadlineDate != null) {
            deadlineLastValue = newModel.deadlineDate;
          }

          Task newTask = Task(
              id: newModel.newTask.id,
              task_name: newModel.newTask.task_name,
              date_deadline: deadlineLastValue,
              priority_level: newModel.formatPriorityLevel());
          context.read<TasksListModel>().addTask(newTask, newModel.isNew);
        }

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
              },
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: TextButton(
                  onPressed: () {
                    addTask();
                    Navigator.of(context).pop();
                  },
                  child: const Text('Сохранить'),
                ),
              ),
            ],
          ),
          body: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, right: 16, left: 16),
                child: Column(
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
                    ),
                    const SizedBox(height: 16),
                    const Text('Важность'),
                    DropdownButton<String>(
                      value: context.read<NewTaskModel>().priorityLevelString,
                      // isExpanded: true,
                      onChanged: (String? value) {
                        setState(() {
                          context.read<NewTaskModel>().priorityLevelString =
                              value!;
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
                                style: const TextStyle(
                                    color: LightThemeColors.red),
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
                    // const SizedBox(height: 16),
                  ],
                ),
              ),
              const Column(
                children: [
                  Divider(),
                  ChangeDateWidget(),
                  Divider(),
                  DeleteTaskWidget(),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}

class ChangeDateWidget extends StatefulWidget {
  const ChangeDateWidget({Key? key}) : super(key: key);

  @override
  State<ChangeDateWidget> createState() => _ChangeDateWidgetState();
}

class _ChangeDateWidgetState extends State<ChangeDateWidget> {
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

    late String subtitle;
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
        setState(() {
          if (value == false) {
            model.setDeadlineStatus(false);
          } else {
            selectDate(context);
          }
        });
      },
    );
  }
}

class DeleteTaskWidget extends StatelessWidget {
  const DeleteTaskWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (!context.read<NewTaskModel>().isNew) {
      return ListTile(
        onTap: () {
          context
              .read<TasksListModel>()
              .deleteTaskWithId(context.read<NewTaskModel>().newTask.id);
          Navigator.of(context).pop(); // todo: complete this
        },
        leading: const Icon(
          Icons.delete,
          color: LightThemeColors.red,
        ),
        minLeadingWidth: 0,
        title: const Text(
          'Удалить',
          style: TextStyle(
            color: LightThemeColors.red,
          ),
        ),
      );
    } else {
      return const ListTile(
        leading: Icon(
          Icons.delete,
          color: LightThemeColors.labelDisable,
        ),
        minLeadingWidth: 0,
        title: Text(
          'Удалить',
          style: TextStyle(
            color: LightThemeColors.labelDisable,
          ),
        ),
      );
    }
  }
}
