import 'package:fixly/core/utils/login_option.dart';
import 'package:flutter/material.dart';

class GetLoginOptiond extends StatelessWidget {
  const GetLoginOptiond({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        LoginOption(
          onPressed: () {},
          image: 'assets/images/google.png',
        ),
        LoginOption(
          onPressed: () {},
          image: 'assets/images/facebook.png',
        ),
        LoginOption(
          onPressed: () {},
          image: 'assets/images/phone.png',
        ),
      ],
    );
  }
}
