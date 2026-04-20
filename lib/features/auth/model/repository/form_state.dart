import 'package:fixly/features/auth/widget/user_role.dart';

class LogRegFormState {
  final String email;
  final String password;
  final String? name;
  final UserRole role;
  final String? emailError;
  final String? passwordError;
  final String? nameError;
  final bool isSubmitting;
  final bool isValid;

  const LogRegFormState({
    this.email = '',
    this.password = '',
    this.name = '',
    this.role = UserRole.consumer,
    this.emailError,
    this.nameError,
    this.passwordError,
    this.isSubmitting = false,
    this.isValid = false,
  });

  LogRegFormState copyWith({
    String? email,
    String? password,
    String? name,
    UserRole? role,
    Object? emailError = _noChange,
    Object? passwordError = _noChange,
    Object? nameError = _noChange,
    bool? isSubmitting,
    bool? isValid,
  }) {
    return LogRegFormState(
      email: email ?? this.email,
      password: password ?? this.password,
      name: name ?? this.name,
      role: role ?? this.role,
      emailError: emailError == _noChange
          ? this.emailError
          : emailError as String?,
      passwordError: passwordError == _noChange
          ? this.passwordError
          : passwordError as String?,
      nameError: nameError == _noChange
          ? this.nameError
          : nameError as String?,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isValid: isValid ?? this.isValid,
    );
  }

  static const _noChange = Object();
}
