import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/task_list_model.dart';
import '../../../src/themes/src/light_theme.dart';

class CompletedCountWidget extends StatelessWidget {
  const CompletedCountWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 60,
          right: 25,
          bottom: 16,
        ),
        child: SizedBox(
          height: 34,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 14.0),
                child: const Text('completed').tr(
                  args: [
                    context.watch<TasksListModel>().completedCount.toString(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: IconButton(
                  color: LightThemeColors.blue,
                  onPressed: () =>
                      context.read<TasksListModel>().rechangeShowCompleted(),
                  icon: context.read<TasksListModel>().showCompleted
                      ? const Icon(Icons.visibility)
                      : const Icon(Icons.visibility_off),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
