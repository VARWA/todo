import 'package:flutter/material.dart';

import '../../../src/themes/src/custom_extension.dart';

class MainAuthFormWidget extends StatelessWidget {
  const MainAuthFormWidget({
    super.key,
    required this.customColors,
  });

  final CustomColors customColors;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      color: Theme.of(context).cardColor,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 10.0,
          bottom: 10,
          left: 20,
          right: 20,
        ),
        child: Column(
          children: [
            Text(
              'Login & Register',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: customColors.labelPrimary,
                  ),
            ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Login',
              ),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: customColors.labelPrimary,
                  ),
            ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Password',
              ),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: customColors.labelPrimary,
                  ),
              obscureText: true,
            ),
            const SizedBox(
              height: 8,
            ),
            Stack(
              children: [
                Row(
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: const Text('Register'),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Forgot password?'),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('Login'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
