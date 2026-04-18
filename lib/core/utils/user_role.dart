import 'package:fixly/core/theme/app_color.dart';
import 'package:fixly/core/utils/custom_text_format.dart';
import 'package:fixly/features/auth/widget/user_role.dart';
import 'package:flutter/material.dart';

class UserRoleSelector extends StatelessWidget {
  final UserRole selectedRole;
  final void Function(UserRole) onChanged;

  const UserRoleSelector({
    super.key,
    required this.selectedRole,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio<UserRole>(
          activeColor: AppColor.kLoginButtonBgColor,
          materialTapTargetSize:
              MaterialTapTargetSize.shrinkWrap,
          visualDensity: const VisualDensity(
            horizontal: -4,
            vertical: -4,
          ),
          value: UserRole.consumer,
          // ignore: deprecated_member_use
          groupValue: selectedRole,
          // ignore: deprecated_member_use
          onChanged: (value) {
            if (value != null) {
              onChanged(value);
            }
          },
        ),
        const CustomTextFormat(
          text: 'Consumer',
          color: AppColor.kTextPrimary,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),

        const SizedBox(width: 10),

        Radio<UserRole>(
          activeColor: AppColor.kLoginButtonBgColor,
          materialTapTargetSize:
              MaterialTapTargetSize.shrinkWrap,
          visualDensity: const VisualDensity(
            horizontal: 4,
            vertical: -4,
          ),
          value: UserRole.provider,
          // ignore: deprecated_member_use
          groupValue: selectedRole,
          // ignore: deprecated_member_use
          onChanged: (value) {
            if (value != null) {
              onChanged(value);
            }
          },
        ),
        const CustomTextFormat(
          text: 'Provider',
          color: AppColor.kTextPrimary,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ],
    );
  }
}
