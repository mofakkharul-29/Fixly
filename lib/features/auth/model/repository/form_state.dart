import 'package:fixly/features/auth/widget/user_role.dart';

class LogRegFormState {
  final String email;
  final String password;
  final String? name;

  final String? emailError;
  final String? passwordError;
  final String? nameError;

  final bool isFormValid;
  final bool isSubmitting;
  final UserRole role;

  const LogRegFormState({
    this.email = '',
    this.password = '',
    this.name = '',
    this.emailError,
    this.passwordError,
    this.nameError,
    this.isFormValid = false,
    this.isSubmitting = false,
    this.role = UserRole.consumer,
  });

  LogRegFormState copyWith({
    String? email,
    String? password,
    String? name,
    Object? emailError = _noChange,
    Object? passwordError = _noChange,
    Object? nameError = _noChange,
    bool? isFormValid,
    bool? isSubmitting,
    UserRole? role,
  }) {
    return LogRegFormState(
      email: email ?? this.email,
      password: password ?? this.password,
      name: name ?? this.name,
      emailError: emailError == _noChange
          ? this.emailError
          : emailError as String?,
      passwordError: passwordError == _noChange
          ? this.passwordError
          : passwordError as String?,
      nameError: nameError == _noChange
          ? this.nameError
          : nameError as String?,
      isFormValid: isFormValid ?? this.isFormValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      role: role ?? this.role,
    );
  }

  static const _noChange = Object();
}
