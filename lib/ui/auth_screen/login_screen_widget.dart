import 'package:flutter/material.dart';
import 'package:todo/ui/auth_screen/widgets/main_auth_form_widget.dart';
import 'package:todo/ui/auth_screen/widgets/other_auth_methods_widget.dart';

import '../../src/themes/src/custom_extension.dart';

class LoginScreenWidget extends StatelessWidget {
  const LoginScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>()!;

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: MainAuthFormWidget(customColors: customColors),
                  ),
                  const OtherAuthMethodsWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
