import 'package:flutter/material.dart';

import '../../../src/themes/src/custom_extension.dart';

class LogoAuthButtonWidget extends StatelessWidget {
  final String logoPath;
  final Function? onPressed;

  const LogoAuthButtonWidget({
    super.key,
    required this.logoPath,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>()!;

    return SizedBox(
      width: 40,
      height: 50,
      child: ElevatedButton(
        onPressed: () => onPressed!(),
        style: ElevatedButton.styleFrom(
          backgroundColor: customColors.backElevated!,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Image.asset(logoPath),
        ),
      ),
    );
  }
}
