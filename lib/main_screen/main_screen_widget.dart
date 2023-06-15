import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:todo/navigation/routes.dart';
import 'package:todo/models/task_list_model.dart';
import 'package:todo/themes/src/light_theme.dart';
import 'package:intl/intl.dart';
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

class _TasksListWidgetState extends State<TasksListWidget> {
  Logger logger = Logger(printer: PrettyPrinter());

  @override
  Widget build(BuildContext context) {
    final model = context.read<TasksListModel>();
    final lenList = model.tasksListForMenu.length;
    logger.d('Downloaded to list $lenList tasks');
    final items = List<Widget>.generate(lenList + 1, (index) {
      if (index != lenList) {
        return Dismissible(
          key: UniqueKey(),
          background: Container(
            color: LightThemeColors.green,
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 28),
                child: Icon(
                  Icons.done,
                  color: LightThemeColors.white,
                  size: 18,
                ),
              ),
            ),
          ),
          secondaryBackground: Container(
            color: LightThemeColors.red,
            child: const Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(right: 28),
                child: Icon(
                  Icons.delete,
                  color: LightThemeColors.white,
                  size: 18,
                ),
              ),
            ),
          ),
          onDismissed: (DismissDirection direction) {
            if (direction == DismissDirection.startToEnd) {
              model.makeCompleted(model.tasksListForMenu[index].id);
            } else {
              model.removeTask(index);
            }

            // setState(
            //   () {
            //   },
            // );
          },
          child: TaskInListWidget(
            id: model.tasksListForMenu[index].id,
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
    });
    print(items);
    return SliverToBoxAdapter(
        child: Column(
      children: [
        CompletedCountWidget(),
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
              children: items,
            ),
          ),
        ),
      ],
    ));
  }
}

class CompletedCountWidget extends StatefulWidget {
  const CompletedCountWidget({Key? key}) : super(key: key);

  @override
  State<CompletedCountWidget> createState() => _CompletedCountWidgetState();
}

class _CompletedCountWidgetState extends State<CompletedCountWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 60,
        right: 25,
      ),
      child: SizedBox(
        height: 20,
        child: ListTile(
          title: Text(
              'Выполнено - ${context.watch<TasksListModel>().completedCount}'),
          trailing: IconButton(
            icon: const Icon(Icons.visibility),
            onPressed: () {
              print(222);
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

  const TaskInListWidget({super.key, required this.id});

  @override
  State<TaskInListWidget> createState() => _TaskInListWidgetState();
}

class _TaskInListWidgetState extends State<TaskInListWidget> {
  Text setTextStyle(Task task) {
    if (task.completed == true) {
      if (task.priority_level == 0) {
        return Text(
          task.task_name,
          style: const TextStyle(
              decoration: TextDecoration.lineThrough,
              color: OtherColors.comlitedTaskInList),
        );
      }
      return Text(
        task.task_name,
        style: const TextStyle(
            decoration: TextDecoration.lineThrough,
            color: OtherColors.comlitedTaskInList),
      );
    }
    return Text(task.task_name);
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<TasksListModel>();
    final id = widget.id;
    final Task task = model.tasksList[model.searchTaskIndexById(id)];
    final Text formattedText = setTextStyle(task);
    final DateTime? deadline = task.date_deadline;
    print('$deadline $task');
    if (deadline != null) {
      return ListTile(
        horizontalTitleGap: 0,
        leading: Checkbox(
          value: task.completed,
          activeColor: LightThemeColors.green,
          checkColor: LightThemeColors.white,
          fillColor:
              MaterialStateProperty.resolveWith((Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return task.priority_level == 2
                  ? OtherColors.redCheckboxFillColor
                  : Theme.of(context).cardColor;
            }
          }),
          side: task.priority_level == 2
              ? const BorderSide(color: LightThemeColors.red)
              : BorderSide(color: Theme.of(context).unselectedWidgetColor),
          onChanged: (bool? value) {
            if (value!) {
              model.makeCompleted(id);
            } else {
              model.makeUncompleted(id);
            }
          },
        ),
        title: formattedText,
        subtitle: Text(DateFormat('d MMMM yyyy').format(deadline)),
        trailing: IconButton(
            icon: const Icon(
              Icons.info_outline_rounded,
            ),
            onPressed: () {
              // Navigator.pushNamed(context, RouteNames.changeTask);
              Navigator.pushNamed(context, RouteNames.changeTask,
                  arguments: task.id);
            }),
      );
    } else {
      return ListTile(
        horizontalTitleGap: 0,
        leading: Checkbox(
          value: task.completed,
          activeColor: LightThemeColors.green,
          checkColor: LightThemeColors.white,
          fillColor: MaterialStateProperty.resolveWith(
            (Set<MaterialState> states) {
              if (!states.contains(MaterialState.selected)) {
                return task.priority_level == 2
                    ? OtherColors.redCheckboxFillColor
                    : Theme.of(context).cardColor;
              }
            },
          ),
          side: task.priority_level == 2
              ? const BorderSide(color: LightThemeColors.red)
              : BorderSide(color: Theme.of(context).unselectedWidgetColor),
          onChanged: (bool? value) {
            if (value!) {
              model.makeCompleted(id);
            } else {
              model.makeUncompleted(id);
            }
          },
        ),
        title: formattedText,
        trailing: IconButton(
          icon: const Icon(
            Icons.info_outline_rounded,
          ),
          onPressed: () {
            // Navigator.pushNamed(context, RouteNames.changeTask);
            Navigator.pushNamed(context, RouteNames.changeTask,
                arguments: task.id);
          },
        ),
      );
    }
  }
}
