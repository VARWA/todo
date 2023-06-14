import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:todo/navigation/routes.dart';
import 'package:todo/task_list_model.dart';
import 'package:todo/themes/src/light_theme.dart';

class MainScreenWidget extends StatefulWidget {
  const MainScreenWidget({Key? key}) : super(key: key);

  @override
  State<MainScreenWidget> createState() => _MainScreenWidgetState();
}

class _MainScreenWidgetState extends State<MainScreenWidget> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            const MainAppBarWidget(),
            // SizedBox(height: 18),
            TasksListWidget(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, RouteNames.changeTask);
          },
          child: const Icon(
            Icons.add,
            weight: 56,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class TasksListWidget extends StatefulWidget {
  TasksListWidget({
    super.key,
  });

  @override
  State<TasksListWidget> createState() => _TasksListWidgetState();
}

class _TasksListWidgetState extends State<TasksListWidget> {
  Logger logger = Logger(printer: PrettyPrinter());

  @override
  Widget build(BuildContext context) {
    final model = TasksListModel();
    return SliverToBoxAdapter(
        child: Column(
      children: [
        CompletedCountWidget(model: model),
        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.only(right: 8, left: 8, bottom: 20),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 4,
            shadowColor: Colors.black,
            color: Theme.of(context).cardColor,
            child: Column(
              children: [
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: model.tasks_list.length + 1,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  itemBuilder: (BuildContext context, int index) {
                    if (index != model.tasks_list.length) {
                      return Dismissible(
                        key: UniqueKey(),
                        background: Container(
                          color: LightThemeColors.green,
                          child: const Icon(
                            Icons.done,
                            color: LightThemeColors.white,
                          ),
                        ),
                        secondaryBackground: Container(
                          color: LightThemeColors.red,
                          child: const Icon(
                            Icons.delete,
                            color: LightThemeColors.white,
                          ),
                        ),
                        onDismissed: (DismissDirection direction) {
                          if (direction == DismissDirection.startToEnd) {
                            logger.i('Task with id $index completed');
                            model.makeCompleted(model.tasks_list[index].id);
                          } else {
                            logger.i('Task with id $index removed');
                          }

                          setState(() {
                            model.removeTask(index);
                          });
                        },
                        child: TaskInListWidget(
                          model: model,
                          id: model.tasks_list[index].id,
                        ),
                      );
                    } else {
                      return ListTile(
                        leading: const Icon(
                          Icons.add,
                          color: Colors.transparent,
                        ),
                        title: const Text('Новое'),
                        onTap: () {
                          Navigator.pushNamed(context, RouteNames.changeTask);
                        },
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}

class CompletedCountWidget extends StatefulWidget {
  final TasksListModel model;

  CompletedCountWidget({Key? key, required this.model}) : super(key: key);

  @override
  State<CompletedCountWidget> createState() => _CompletedCountWidgetState();
}

class _CompletedCountWidgetState extends State<CompletedCountWidget> {
  @override
  Widget build(BuildContext context) {
    final model = widget.model;
    return Padding(
      padding: const EdgeInsets.only(
        left: 60,
        right: 25,
      ),
      child: SizedBox(
        height: 20,
        child: ListTile(
          title: Text('Выполнено - ${model.completed_count}'),
          trailing: IconButton(
            icon: Icon(
              Icons.visibility_off,
              color: LightThemeColors.blue,
            ),
            onPressed: () {
              setState(() {
              model.rechangeShowCompleted;
              // print(widget.model.showCompleted);

            });
            },
          ),
        ),
      ),
    );
  }
}

class MainAppBarWidget extends StatelessWidget {
  const MainAppBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SliverAppBar(
      backgroundColor: LightThemeColors.backPrimary,
      pinned: true,
      snap: false,
      floating: false,
      expandedHeight: 124,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          'Мои дела',
          style: TextStyle(color: LightThemeColors.labelPrimary),
          // style: largeTitleTextStyle,
        ),
      ),
    );
  }
}

class TaskInListWidget extends StatefulWidget {
  final int id;
  final TasksListModel model;

  const TaskInListWidget({super.key, required this.model, required this.id});

  @override
  State<TaskInListWidget> createState() => _TaskInListWidgetState();
}

class _TaskInListWidgetState extends State<TaskInListWidget> {
  @override
  Widget build(BuildContext context) {
    final model = widget.model;
    final id = widget.id;
    final task = model.tasks_list[id];
    // final deadlineText = task.date_deadline
    return ListTile(
      horizontalTitleGap: 0,
      leading: Checkbox(
        value: task.completed,
        checkColor: LightThemeColors.green,
        onChanged: (bool? value) {
          print('СМЕНА ЗНАЧЕНИЯ');
          if (value!) {
            widget.model.makeCompleted(id);
          } else {
            widget.model.makeUncompleted(id);
          }
        },
      ),
      title: Text(
        task.task_name,
      ),
      subtitle: Text(task.date_deadline.toString()),
      trailing: IconButton(
        icon: const Icon(
          Icons.info_outline_rounded,
        ),
        onPressed: () {
          // Navigator.pushNamed(context, RouteNames.changeTask);
          Navigator.pushNamed(
              context,
              RouteNames.changeTask,
              arguments: [model, task]);
        }
      ),
    );
  }
}
