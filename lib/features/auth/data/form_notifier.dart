import 'package:fixly/features/auth/model/repository/form_state.dart';
import 'package:fixly/features/auth/widget/user_role.dart';
import 'package:fixly/features/provider/firebase_all_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LgoRegFormNotifier extends Notifier<LogRegFormState> {
  @override
  LogRegFormState build() {
    return const LogRegFormState();
  }

  void validateEmail(String email) {
    final String? emailError = _validateEmail(email);

    state = state.copyWith(
      email: email,
      emailError: emailError,
      isFormValid: _isFormValid(
        emailError: emailError,
        passwordError: state.passwordError,
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
      isFormValid: _isFormValid(
        emailError: state.emailError,
        passwordError: passwordError,
      ),
    );
  }

  void validateName(String name) {
    final String? nameError = _validateName(name);

    state = state.copyWith(
      name: name,
      nameError: nameError,
    );
  }

  String? _validatePassword(String password) {
    if (password.isEmpty) {
      return 'Password can\'t be empty';
    } else if (password.isNotEmpty && password.length < 6) {
      return 'Password must be at least 6 characthers';
    }
    return null;
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

  String? _validateName(String name) {
    if (name.isEmpty) {
      return 'Name is required';
    } else if (name.length < 2) {
      return 'Name too short';
    }
    return null;
  }

  bool _isFormValid({
    required String? emailError,
    required String? passwordError,
  }) {
    return emailError == null && passwordError == null;
  }

  void setSubmitting(bool value) {
    state = state.copyWith(isSubmitting: value);
  }

  Future<void> onSubmit({bool isSiginingIn = true}) async {
    final valid = _isFormValid(
      emailError: state.emailError,
      passwordError: state.passwordError,
    );
    if (!valid) return;
    setSubmitting(true);
    try {
      final authNotifier = ref.read(
        authNotifierProvidr.notifier,
      );

      if (isSiginingIn) {
        await authNotifier.loginWithEmailPassword(
          state.email,
          state.password,
        );
      } else {
        await authNotifier.registerWithEmailPassword(
          state.email,
          state.password,
          state.name ?? 'no name',
          state.role,
        );
      }
    } finally {
      setSubmitting(false);
    }
  }

  void setUserRole(UserRole role) {
    state = state.copyWith(role: role);
  }
}
