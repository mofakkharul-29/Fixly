class LogRegFormState {
  final String email;
  final String password;
  final String? name;

  final String? emailError;
  final String? passwordError;
  final String? nameError;

  final bool isFormValid;
  final bool isSubmitting;

  const LogRegFormState({
    this.email = '',
    this.password = '',
    this.name = '',
    this.emailError,
    this.passwordError,
    this.nameError,
    this.isFormValid = false,
    this.isSubmitting = false,
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
    );
  }

  static const _noChange = Object();
}
