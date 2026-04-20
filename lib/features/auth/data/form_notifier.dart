import 'package:fixly/features/auth/model/form_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LogRegFormNotifier extends Notifier<LogRegFormState> {
  @override
  LogRegFormState build() {
    return const LogRegFormState();
  }

  void resetForm() {
    state = const LogRegFormState();
  }

  void validateEmail(String email) {
    final String? emailError = _validateEmail(email);
    state = state.copyWith(
      email: email,
      emailError: emailError,
      isValid: _isFormValid(
        emailError: emailError,
        passwordError: state.passwordError,
        nameError: state.nameError,
      ),
    );
  }

  void validatePassword(String password) {
    final String? passwordError = _validatePassword(
      password,
    );
    state = state.copyWith(
      password: password,
      passwordError: passwordError,
      isValid: _isFormValid(
        emailError: state.emailError,
        passwordError: passwordError,
        nameError: state.nameError,
      ),
    );
  }

  void validateName(String name) {
    final String? nameError = _validateName(name);
    state = state.copyWith(
      name: name,
      nameError: nameError,
      isValid: _isFormValid(
        emailError: state.emailError,
        passwordError: state.passwordError,
        nameError: nameError,
      ),
    );
  }

  void setSubmitting(bool value) {
    state = state.copyWith(isSubmitting: value);
  }

  String? _validateName(String name) {
    if (name.isEmpty) {
      return 'Name is required';
    }
    if (name.length < 2) {
      return 'Name must be at least two characters';
    }
    return null;
  }

  String? _validatePassword(String password) {
    if (password.isEmpty) {
      return 'Password is required';
    } else if (password.length < 6) {
      return 'password must be at lease 6 characters';
    } else {
      return null;
    }
  }

  String? _validateEmail(String email) {
    if (email.isEmpty) {
      return 'Email is Required';
    } else {
      final emailRegex = RegExp(
        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
      );
      if (!emailRegex.hasMatch(email)) {
        return 'Enter a valid email';
      }
    }
    return null;
  }

  bool _isFormValid({
    required String? emailError,
    required String? passwordError,
    required String? nameError,
  }) {
    return emailError == null &&
        passwordError == null &&
        nameError == null;
  }
}
