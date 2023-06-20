import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:todo/main_screen/widgets/task_in_list_widget.dart';
import 'package:todo/navigation/routes.dart';
import 'package:todo/models/task_list_model.dart';
import 'package:todo/themes/src/light_theme.dart';

class MainScreenWidget extends StatefulWidget {
  const MainScreenWidget({Key? key}) : super(key: key);

  @override
  State<MainScreenWidget> createState() => _MainScreenWidgetState();
}

class _MainScreenWidgetState extends State<MainScreenWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const CustomScrollView(
        slivers: [
          MainAppBarWidget(),
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
    );
  }
}

class TasksListWidget extends StatefulWidget {
  const TasksListWidget({
    super.key,
  });

  @override
  State<TasksListWidget> createState() => _TasksListWidgetState();
}

class _TasksListWidgetState extends State<TasksListWidget> {
  Logger logger = Logger(printer: PrettyPrinter());

  @override
  Widget build(BuildContext context) {
    final model = context.watch<TasksListModel>();
    final lenList = model.tasksListForMenu.length;
    logger.d('Downloaded to main list $lenList tasks');
    final items = List<Widget>.generate(
      lenList + 1,
      (index) {
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
            },
            child: TaskInListWidget(
              id: model.tasksListForMenu[index].id,
            ),
          );
        } else {
          return ListTile(
            leading: const Icon(Icons.add, color: Colors.transparent),
            title: const Text('Новое',
                style: TextStyle(color: LightThemeColors.labelTertiary)),
            onTap: () {
              Navigator.pushNamed(context, RouteNames.changeTask);
            },
          );
        }
      },
    );
    return SliverToBoxAdapter(
        child: Column(
      children: [
        const CompletedCountWidget(),
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

class CompletedCountWidget extends StatelessWidget {
  const CompletedCountWidget({Key? key}) : super(key: key);

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
          trailing: InkWell(
            onTap: () => print("2"), //todo: fix untapping
            child: const Padding(
              padding: EdgeInsets.all(2.0),
              child: Icon(Icons.visibility),
            ),
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
