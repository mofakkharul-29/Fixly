import 'package:fixly/core/theme/app_color.dart';
import 'package:fixly/core/utils/custom_text_format.dart';
import 'package:flutter/material.dart';

class SkipButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final Color? backgroundColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  const SkipButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.backgroundColor = const Color(0x63AB9EF5),
    this.fontSize = 16.0,
    this.fontWeight = FontWeight.bold,
    this.color = Colors.black87,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: AppColor.kTextPrimary,
      ),
      child: CustomTextFormat(
        text: text,
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }
}
