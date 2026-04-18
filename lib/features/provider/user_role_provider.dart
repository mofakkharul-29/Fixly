import 'package:fixly/features/auth/widget/user_role.dart';
import 'package:flutter_riverpod/legacy.dart';

final userRoleProvider = StateProvider<UserRole>(
  (ref) => UserRole.consumer,
);
