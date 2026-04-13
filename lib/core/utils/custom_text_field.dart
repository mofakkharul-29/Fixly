import 'package:fixly/core/theme/app_color.dart';
import 'package:fixly/core/utils/custom_text_format.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final int? maxLines;
  final void Function(String)? onChanged;
  final void Function(PointerDownEvent)? onTapOutside;
  final String? Function(String?)? validator;
  final IconData icon;
  final String label;
  final String? errorText;
  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.focusNode,
    this.keyboardType = TextInputType.emailAddress,
    this.textInputAction = TextInputAction.done,
    this.obscureText = false,
    this.maxLines = 1,
    this.onChanged,
    this.onTapOutside,
    this.validator,
    required this.icon,
    required this.label,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      obscureText: obscureText,
      maxLines: maxLines,
      onChanged: onChanged,
      onTapOutside:
          onTapOutside ?? (event) => focusNode?.unfocus(),
      validator: validator,
      style: const TextStyle(
        color: AppColor.kTextPrimary,
        fontSize: 17,
        fontWeight: FontWeight.w700,
      ),
      decoration: InputDecoration(
        label: CustomTextFormat(text: label),
        labelStyle: const TextStyle(
          color: AppColor.kTextPrimary,
          fontWeight: FontWeight.w600,
          fontSize: 15,
        ),
        filled: true,
        fillColor: Colors.transparent,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: Colors.black,
            width: 1.1,
          ),
        ),
        floatingLabelStyle: const TextStyle(
          color: AppColor.kTextPrimary,
          fontWeight: FontWeight.w700,
          fontSize: 17,
        ),
        prefixIcon: Icon(icon, size: 25),
        prefixIconColor: AppColor.kTextPrimary,
        errorText: errorText,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(width: 2.0),
        ),
        focusColor: AppColor.kTextPrimary,
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            width: 1.5,
            color: Colors.redAccent,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            width: 2.0,
            color: Colors.redAccent,
          ),
        ),
      ),
    );
  }
}
