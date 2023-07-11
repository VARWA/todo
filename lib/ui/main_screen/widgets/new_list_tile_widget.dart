import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo/generated/locale_keys.g.dart';

import '../../../src/themes/src/custom_extension.dart';

class NewListTileWidget extends StatelessWidget {
  final void Function(String?) onChangeTaskTap;

  const NewListTileWidget({Key? key, required this.onChangeTaskTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>()!;
    return ListTile(
      leading: const Icon(
        Icons.add,
        color: Colors.transparent,
      ),
      title: Text(
        LocaleKeys.createNewTaskFromList.tr(),
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: customColors.labelTertiary,
            ),
      ),
      onTap: () => onChangeTaskTap(null),
    );
  }
}
