import 'package:flutter_riverpod/legacy.dart';

enum AuthMode { login, register }

final authModeProvider = StateProvider<AuthMode>(
  (ref) => AuthMode.login,
);
