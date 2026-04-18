import 'package:flutter/material.dart';

enum UserRoleType { consumer, provider }

class UserRoleSelector extends StatelessWidget {
  final UserRoleType selectedRole;
  final void Function(UserRoleType) onChanged;

  const UserRoleSelector({
    super.key,
    required this.selectedRole,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio<UserRoleType>(
          value: UserRoleType.consumer,
          groupValue: selectedRole,
          onChanged: (value) {
            if (value != null) onChanged(value);
          },
        ),
        const Text('Consumer'),

        Radio<UserRoleType>(
          value: UserRoleType.provider,
          groupValue: selectedRole,
          onChanged: (value) {
            if (value != null) onChanged(value);
          },
        ),
        const Text('Provider'),
      ],
    );
  }
}