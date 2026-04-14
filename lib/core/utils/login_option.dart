import 'package:fixly/core/theme/app_color.dart';
import 'package:flutter/material.dart';

class LoginOption extends StatelessWidget {
  final void Function()? onPressed;
  final String image;
  const LoginOption({
    super.key,
    required this.onPressed,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        backgroundColor: Colors.transparent,
        foregroundColor: AppColor.kTextPrimary,
        overlayColor: Colors.transparent,
        shape: const CircleBorder(),
      ),
      child: Image.asset(
        image,
        alignment: Alignment.center,
        fit: BoxFit.cover,
        width: 50,
        height: 50,
      ),
    );
  }
}
