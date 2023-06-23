import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/themes/src/light_theme.dart';

import '../../../models/task_list_model.dart';

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
          title: const Text('completed').tr(
            args: [
              context.watch<TasksListModel>().completedCount.toString(),
            ],
          ),
          trailing: InkWell(
            onTap: () => context.read<TasksListModel>().checkVizibility(),
            //todo: fix untapping
            child: const Padding(
              padding: EdgeInsets.all(2.0),
              child: Icon(
                Icons.visibility,
                color: LightThemeColors.blue,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
