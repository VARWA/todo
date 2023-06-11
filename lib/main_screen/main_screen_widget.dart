import 'package:flutter/material.dart';

class MainScreenWidget extends StatelessWidget {
  const MainScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final list =
        List<TaskInListWidget>.generate(20, (i) => TaskInListWidget(index: i));
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            const SliverAppBar(
              pinned: true,
              snap: false,
              floating: false,
              expandedHeight: 124,
              flexibleSpace: FlexibleSpaceBar(
                title: Text('Мои дела'),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 20,
                child: Center(
                  child: Text('Выполнено - 0'),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: list,
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add, weight: 56),
        ),
      ),
    );
  }
}

class TaskInListWidget extends StatelessWidget {
  final int index;

  const TaskInListWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: false,
        onChanged: (bool? value) {},
      ),
      title: Text(
        '$index',
      ),
      trailing: const Icon(Icons.info_outline_rounded),
    );
  }
}
