import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:todo/change_task_screen/widgets/change_importance_widget.dart';
import 'package:todo/change_task_screen/widgets/change_time_widget.dart';
import 'package:todo/change_task_screen/widgets/delete_task_widget.dart';
import 'package:todo/change_task_screen/widgets/main_text_field_widget.dart';
import 'package:todo/change_task_screen/widgets/rechange_app_bar_widget.dart';
import 'package:todo/models/new_task_model.dart';
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
        taskName: oldTask.taskName,
        priorityLevel: oldTask.priorityLevel,
        dateDeadline: oldTask.dateDeadline,
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
        taskName: '',
        priorityLevel: 0,
        dateDeadline: DateTime.now(),
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
        if (createdPreTask.dateDeadline != null) {
          context.read<NewTaskModel>().deadlineDate =
              createdPreTask.dateDeadline;
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
                  children:  [
                     MainTextField(),
                     SizedBox(height: 16),
                     Text('Важность'),
                     ChangeImportanceWidget(),
                    // const SizedBox(height: 16),
                  ],
                ),
              ),
               Column(
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

