import 'package:flutter/material.dart';

class ChangeTaskScreenWidget extends StatelessWidget {
  const ChangeTaskScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        leading: Icon(Icons.close),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text('Сохранить'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, right: 16, left: 16),
        child: ListView(

          children: [
            Column(mainAxisSize: MainAxisSize.min,
              children: [TextField()],
            ),
            SizedBox(height: 28),
            // DropdownButton(
            //     items: ['Нет', 'Низкий', 'Высокий'],
            //     onChanged: (String? newValue) {}),
            SizedBox(height: 4),
            Text('Нет'),
            const SizedBox(height: 16),
            const Divider(),
            ListTile(
              title: Text('Сделать до'),
              subtitle: Text('2 июня 2021'),
              trailing: Switch(
                value: false,
                onChanged: (bool value) {},
              ),
            ),
            const SizedBox(height: 23),
            InkWell(
              child: const ListTile(
                leading: Icon(Icons.beach_access),
                title: Text('Удалить'),
              ),
              onTap: () {},
            )
          ],
        ),
      ),
    );
  }
}
