import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/new_task_model.dart';
import 'package:todo/models/task_list_model.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/ui/change_task_screen/elements/importance_values.dart';
import 'package:todo/ui/change_task_screen/widgets/change_date_widget.dart';
import 'package:todo/ui/change_task_screen/widgets/change_importance_widget.dart';
import 'package:todo/ui/change_task_screen/widgets/delete_task_widget.dart';
import 'package:todo/ui/change_task_screen/widgets/main_text_field_widget.dart';
import 'package:todo/ui/change_task_screen/widgets/rechange_app_bar_widget.dart';
import 'package:uuid/uuid.dart';

class ChangeTaskScreenWidget extends StatefulWidget {
  final String? taskId;

  const ChangeTaskScreenWidget({Key? key, this.taskId}) : super(key: key);

  @override
  State<ChangeTaskScreenWidget> createState() => _ChangeTaskScreenWidgetState();
}

class _ChangeTaskScreenWidgetState extends State<ChangeTaskScreenWidget> {
  Logger logger = Logger(printer: PrettyPrinter());

  @override
  Widget build(BuildContext context) {
    final model = context.read<TasksListModel>();
    Task? newTaskFromList;
    bool isNew = false;

    if (widget.taskId != null) {
      final oldTask =
          model.tasksList[model.searchTaskIndexById(widget.taskId as String)];
      newTaskFromList = Task(
        id: oldTask.id,
        text: oldTask.text,
        importance: oldTask.importance,
        deadline: oldTask.deadline,
        done: oldTask.done,
        createdAt: oldTask.createdAt,
        changedAt: oldTask.changedAt,
      );
    } else {
      isNew = true;
    }
    logger.i('Args results: $newTaskFromList');
    Task createNewTask() {
      DateTime dateTimeNow = DateTime.now();
      return Task(
        id: const Uuid().v4(),
        text: '',
        importance: ImportanceValues.basicGlobal,
        deadline: null,
        createdAt: dateTimeNow,
        changedAt: dateTimeNow,
      );
    }

    Task createPreTask(Task? newTaskFromList) {
      logger.i(' task for recreating : $newTaskFromList');
      if (newTaskFromList != null) {
        return newTaskFromList;
      } else {
        return createNewTask();
      }
    }

    final createdPreTask = createPreTask(newTaskFromList);

    return ListenableProvider(
      create: (_) => NewTaskModel(newTask: createdPreTask, isNew: isNew),
      builder: (context, child) {
        if (createdPreTask.deadline != null) {
          context.read<NewTaskModel>().deadlineDate = createdPreTask.deadline!;
          context.read<NewTaskModel>().setInitHaveDeadline(true);
        }

        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: const RechangeAppBar(),
          body: ListView(
            children: const [
              Padding(
                padding: EdgeInsets.only(top: 20, right: 16, left: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    MainTextField(),
                  ],
                ),
              ),
              Column(
                children: [
                  SizedBox(height: 16),
                  ChangeImportanceWidget(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Divider(thickness: 1),
                  ),
                  ChangeDateWidget(),
                  Divider(thickness: 1),
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
