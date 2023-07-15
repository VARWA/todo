import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/ui/src/form_factor.dart';

import '../../../models/task_list_model.dart';
import '../../../src/themes/src/custom_extension.dart';

class CompletedCountWidget extends StatelessWidget {
  const CompletedCountWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>()!;
    final globalPadding = establishGlobalPadding(context: context);
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: globalPadding),
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
                  child: Text(
                    'completed',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: customColors.labelTertiary,
                        ),
                  ).tr(
                    args: [
                      context.watch<TasksListModel>().completedCount.toString(),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: IconButton(
                    splashRadius: 15,
                    color: customColors.blue,
                    onPressed: () =>
                        context.read<TasksListModel>().toggleShowCompleted(),
                    icon: context.read<TasksListModel>().showCompleted
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
