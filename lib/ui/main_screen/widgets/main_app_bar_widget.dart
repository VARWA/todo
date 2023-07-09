import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo/generated/locale_keys.g.dart';

import '../../../src/themes/src/light_theme.dart';

class MainAppBarWidget extends StatelessWidget {
  const MainAppBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: LightThemeColors.backPrimary,
      pinned: true,
      snap: false,
      floating: false,
      expandedHeight: 124,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          LocaleKeys.myTasks.tr(),
          style: const TextStyle(color: LightThemeColors.labelPrimary),
          // style: largeTitleTextStyle,
        ),
      ),
    );
  }
}
