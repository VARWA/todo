import 'package:flutter/material.dart';

import '../../../auth/auth_service.dart';
import 'logo_auth_button_widget.dart';

class OtherAuthMethodsWidget extends StatelessWidget {
  const OtherAuthMethodsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        // Expanded(
        //   child: LogoAuthButtonWidget(
        //     logoPath: 'assets/logos/yandex.png',
        //     onPressed: () {},
        //   ),
        // ),
        // const SizedBox(width: 10),
        Expanded(
          child: LogoAuthButtonWidget(
            logoPath: 'assets/logos/google.png',
            onPressed: AuthService().signInWithGoogle,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: LogoAuthButtonWidget(
            logoPath: 'assets/logos/github.png',
            onPressed: AuthService().signInWithGitHub,
          ),
        ),
      ],
    );
  }
}
