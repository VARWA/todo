import 'package:flutter/material.dart';

class MainScreenWidget extends StatelessWidget {
  const MainScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return ListTile(
                    leading: Checkbox(
                      value: false,
                      onChanged: (bool? value) {},
                    ),
                    title: Text(
                      '$index',
                    ),
                    trailing: Icon(Icons.info_outline_rounded),
                  );
                },
                childCount: 20,
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
