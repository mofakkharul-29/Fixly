import 'package:fixly/core/theme/app_color.dart';
import 'package:fixly/core/utils/custom_text_format.dart';
import 'package:flutter/material.dart';

class LogRegText extends StatelessWidget {
  final String firstText;
  final String lastText;
  final void Function()? onTap;
  const LogRegText({
    super.key,
    required this.firstText,
    required this.lastText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CustomTextFormat(
            text: firstText,
            color: AppColor.kTextPrimary,
            fontWeight: FontWeight.w700,
            fontSize: 14,
          ),
          GestureDetector(
            onTap: onTap,
            child: CustomTextFormat(
              text: lastText,
              color: AppColor.kTextPrimary,
              fontWeight: FontWeight.w800,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
