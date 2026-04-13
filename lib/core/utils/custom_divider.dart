import 'package:fixly/core/theme/app_color.dart';
import 'package:fixly/core/utils/custom_text_format.dart';
import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: getDivider(
            color: AppColor.kTextPrimary,
            thickness: 2.0,
            height: 5,
            endIndent: 3.0,
            indent: 5.5,
          ),
        ),
        const CustomTextFormat(
          text: 'OR',
          color: AppColor.kTextPrimary,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
        Expanded(
          child: getDivider(
            color: AppColor.kTextPrimary,
            indent: 3.0,
            endIndent: 5.5,
            height: 5,
            thickness: 2.0,
          ),
        ),
      ],
    );
  }

  Widget getDivider({
    Color? color,
    double? endIndent,
    double? indent,
    double? height,
    double? thickness,
  }) {
    return Divider(
      color: color,
      endIndent: endIndent,
      indent: indent,
      height: height,
      radius: BorderRadius.circular(5),
      thickness: thickness,
    );
  }
}
