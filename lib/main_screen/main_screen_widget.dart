import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/main_screen/main_screen_model.dart';
import 'package:todo/navigation/routes.dart';
import 'package:todo/themes/src/constants.dart';
import 'package:todo/themes/src/light_theme.dart';

class MainScreenWidget extends StatelessWidget {
  const MainScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            const MainAppBarWidget(),
            const CompletedCountWidget(),
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
  final _tasks_list = <Task>[
    Task(index: 1, task_name: 'Наконец-то сделать экран'),
    Task(index: 2, task_name: 'Наконец-то сделать кнопки'),
    Task(index: 3, task_name: 'Наконец-то сделать все остальное'),
    Task(index: 4, task_name: 'Наконец-то сделать верстку'),
    Task(index: 5, task_name: 'Наконец-то сделать фон Приоритет у дела'),
  ];

  @override
  Widget build(BuildContext context) {
    // final _tasks_list = context.read<MainScreenModel>().global_list_tasks;
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(right: 8,left: 8, top: 18),
        child: Card(
          elevation: 4,
          shadowColor: Colors.black,
          color: Theme.of(context).cardColor,
          child: Column(
            children: [
              ListView.builder(
                itemCount: _tasks_list.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(vertical: 16),
                itemBuilder: (BuildContext context, int index) {
                  return Dismissible(
                    key: UniqueKey(
                        // 'key_${context.read<MainScreenModel>().global_list_tasks[index]}',
                        ),
                    background: Container(
                      color: LightThemeColors.green,
                    ),
                    secondaryBackground: Container(
                      color: LightThemeColors.red,
                    ),
                    onDismissed: (DismissDirection direction) {
                      if (direction == DismissDirection.startToEnd) {
                        print("Add to favorite");
                      } else {
                        print('Remove item');
                      }

                      setState(() {
                        // updateList(context);
                        // context.read<MainScreenModel>().deleteTask(index);
                        _tasks_list.removeAt(index);
                      });
                    },
                    child: TaskInListWidget(
                      task: _tasks_list[index],
                    ),
                  );
                },
              ),
              Material(
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, RouteNames.changeTask);
                  },
                  child: const ListTile(
                    leading: Icon(
                      Icons.add,
                      color: Colors.transparent,
                    ),
                    title: Text('Новое'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CompletedCountWidget extends StatelessWidget {
  const CompletedCountWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(
          left: 60,
          right: 25,
        ),
        child: SizedBox(
          height: 20,
          child: ListTile(
            title: Text('Выполнено - 0'),
            trailing: Icon(Icons.remove_red_eye, color: LightThemeColors.blue,),
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
      trailing: const Icon(
        Icons.info_outline_rounded,
      ),
    );
  }
}
