import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo/generated/locale_keys.g.dart';

import '../../../themes/src/light_theme.dart';
import '../../navigation/routes.dart';

class NewListTileWidget extends StatelessWidget {
  const NewListTileWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.add, color: Colors.transparent),
      title: Text(
        LocaleKeys.createNewTaskFromList.tr(),
        style: const TextStyle(color: LightThemeColors.labelTertiary),
      ),
      onTap: () {
        Navigator.pushNamed(context, RouteNames.changeTask);
      },
    );
  }
}
