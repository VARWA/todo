import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo/generated/locale_keys.g.dart';

import '../../../src/themes/src/light_theme.dart';

class NewListTileWidget extends StatelessWidget {
  final void Function(String?) onChangeTaskTap;

  const NewListTileWidget({Key? key, required this.onChangeTaskTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.add, color: Colors.transparent),
      title: Text(
        LocaleKeys.createNewTaskFromList.tr(),
        style: const TextStyle(color: LightThemeColors.labelTertiary),
      ),
      onTap: () => onChangeTaskTap(null),
    );
  }
}
