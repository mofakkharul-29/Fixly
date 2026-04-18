import 'package:fixly/core/theme/app_color.dart';
import 'package:fixly/core/utils/custom_text_format.dart';
import 'package:fixly/core/utils/submit_indicator.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final IconData? icon;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final Color? overlayColor;
  final double width;
  final double height;
  final IconAlignment? iconAlignment;
  final Color? iconColor;
  final double? iconSize;
  final Color? buttonTextColor;
  final bool isSubmitting;
  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.icon,
    this.foregroundColor,
    this.backgroundColor,
    this.width = double.infinity,
    this.height = 53,
    this.overlayColor,
    this.iconAlignment = IconAlignment.end,
    this.iconColor = AppColor.kTextPrimary,
    this.iconSize = 28,
    this.buttonTextColor = AppColor.kTextPrimary,
    this.isSubmitting = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      label: CustomTextFormat(
        text: text,
        fontSize: 17,
        fontWeight: FontWeight.w800,
        color: buttonTextColor,
      ),
      icon: isSubmitting
          ? const SubmitIndicator()
          : Icon(icon, fontWeight: FontWeight.w800),
      style: ElevatedButton.styleFrom(
        foregroundColor: foregroundColor,
        backgroundColor: backgroundColor,
        overlayColor: overlayColor,
        iconAlignment: iconAlignment,
        iconColor: iconColor,
        iconSize: iconSize,
        fixedSize: Size(width, height),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(5),
        ),
      ),
    );
  }
}
