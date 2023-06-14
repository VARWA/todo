import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:todo/navigation/routes.dart';
import 'package:todo/themes/src/light_theme.dart';

import '../models/task_model.dart';

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

// List<Task> downloadList(BuildContext context) {
//   return context.read<MainScreenModel>().global_list_tasks;
// }

class _TasksListWidgetState extends State<TasksListWidget> {
  Logger logger = Logger(printer: PrettyPrinter());

  // DBHelper? dbHelper;
  // late Future<List<Task>> _tasks_list;

  final _tasks_list = <Task>[
    Task(id: 1, task_name: 'Наконец-то сделать экран', priority_level: 0),
    Task(id: 2, task_name: 'Наконец-то сделать кнопки', priority_level: 0),
    Task(
        id: 3,
        task_name: 'Наконец-то сделать все остальное',
        priority_level: 0),
    Task(id: 4, task_name: 'Наконец-то сделать верстку', priority_level: 0),
    Task(
        id: 5,
        task_name: 'Наконец-то сделать фон Приоритет у дела',
        priority_level: 0),
    Task(id: 1, task_name: 'Наконец-то сделать экран', priority_level: 0),
    Task(id: 2, task_name: 'Наконец-то сделать кнопки', priority_level: 0),
    Task(
        id: 3,
        task_name: 'Наконец-то сделать все остальное',
        priority_level: 0),
    Task(id: 4, task_name: 'Наконец-то сделать верстку', priority_level: 0),
    Task(
        id: 5,
        task_name: 'Наконец-то сделать фон Приоритет у дела',
        priority_level: 0),
    Task(id: 1, task_name: 'Наконец-то сделать экран', priority_level: 0),
    Task(id: 2, task_name: 'Наконец-то сделать кнопки', priority_level: 0),
    Task(
        id: 3,
        task_name: 'Наконец-то сделать все остальное',
        priority_level: 0),
    Task(id: 4, task_name: 'Наконец-то сделать верстку', priority_level: 0),
    Task(
        id: 5,
        task_name: 'Наконец-то сделать фон Приоритет у дела',
        priority_level: 0),
  ];

  // @override
  // void initState() {
  //   super.initState();
  //   // dbHelper = DBHelper();
  //   // loadData();
  // }
  //
  // loadData() async {
  //   // _tasks_list = dbHelper!.getDataList();
  //   // logger.i("GETTED LIST: $_tasks_list");
  // }

  @override
  Widget build(BuildContext context) {
    // final _tasks_list = context.read<MainScreenModel>().global_list_tasks;
    return SliverToBoxAdapter(
        child: Column(
      children: [
        const CompletedCountWidget(),
        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.only(right: 8, left: 8),
          child: Card(
            elevation: 4,
            shadowColor: Colors.black,
            color: Theme.of(context).cardColor,
            child: Column(
              children: [
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _tasks_list.length + 1,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  itemBuilder: (BuildContext context, int index) {
                    if (index != _tasks_list.length) {
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
                          } else {
                            logger.i('Task with id $index removed');
                          }

                          setState(() {
                            _tasks_list.removeAt(index);
                          });
                        },
                        child: TaskInListWidget(
                          task: _tasks_list[index],
                        ),
                      );
                    } else {
                      return ListTile(
                        horizontalTitleGap: 24,
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

class CompletedCountWidget extends StatelessWidget {
  const CompletedCountWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(
        left: 60,
        right: 25,
      ),
      child: SizedBox(
        height: 20,
        child: ListTile(
          title: Text('Выполнено - 0'),
          trailing: Icon(
            Icons.remove_red_eye,
            color: LightThemeColors.blue,
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
        title: Text('Мои дела'),
      ),
    );
  }
}

class TaskInListWidget extends StatelessWidget {
  final Task task;

  const TaskInListWidget({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        horizontalTitleGap: 0,
        leading: Checkbox(
          value: task.completed,
          checkColor: LightThemeColors.green,
          onChanged: (bool? value) {},
        ),
        title: Text(
          task.task_name,
        ),
        trailing: IconButton(
          icon: const Icon(
            Icons.info_outline_rounded,
          ),
          onPressed: () {
            Navigator.pushNamed(context, RouteNames.changeTask);
          },
        ));
  }
}
