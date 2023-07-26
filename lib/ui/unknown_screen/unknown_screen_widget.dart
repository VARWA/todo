import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo/generated/locale_keys.g.dart';

class UnknownScreen extends StatelessWidget {
  const UnknownScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    final minSize = min(size.width, size.height);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocaleKeys.unknownPage,
          style: Theme.of(context).textTheme.titleMedium,
        ).tr(),
      ),
      body: Center(
        child: SizedBox(
          height: minSize / 3,
          child: Image.asset('assets/other/unknown_page.png'),
        ),
      ),
    );
  }
}
