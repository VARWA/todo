import 'package:flutter/material.dart';

import '../../../navigation/routes.dart';
import '../../../themes/src/light_theme.dart';

class NewListTileWidget extends StatelessWidget {
  const NewListTileWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.add, color: Colors.transparent),
      title: const Text(
        'Новое',
        style: TextStyle(color: LightThemeColors.labelTertiary),
      ),
      onTap: () {
        Navigator.pushNamed(context, RouteNames.changeTask);
      },
    );
  }
}
