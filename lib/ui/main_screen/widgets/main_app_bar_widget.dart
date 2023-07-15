import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo/generated/locale_keys.g.dart';
import 'package:todo/ui/src/form_factor.dart';

import '../../../src/themes/src/custom_extension.dart';

class MainAppBarWidget extends StatelessWidget {
  const MainAppBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>()!;
    final globalPadding = establishGlobalPadding(context: context);
    return SliverAppBar(
      backgroundColor: customColors.backPrimary,
      pinned: true,
      snap: false,
      floating: false,
      expandedHeight: 124,
      flexibleSpace: Padding(
        padding: EdgeInsets.symmetric(horizontal: globalPadding),
        child: FlexibleSpaceBar(
          title: Text(
            LocaleKeys.myTasks.tr(),
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: customColors.labelPrimary,
                ),
            // style: largeTitleTextStyle,
          ),
        ),
      ),
    );
  }
}
