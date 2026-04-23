import 'package:fixly/core/theme/app_color.dart';
import 'package:fixly/core/utils/custom_elevated_button.dart';
import 'package:fixly/core/utils/custom_text_field.dart';
import 'package:fixly/core/utils/user_role.dart';
import 'package:fixly/features/auth/model/app_user.dart';
import 'package:fixly/features/auth/model/repository/form_notifier.dart';
import 'package:fixly/features/auth/model/repository/form_state.dart';
import 'package:fixly/features/auth/widget/user_role.dart';
import 'package:fixly/features/provider/auth_mode_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController? emailController;
  final TextEditingController? passwordController;
  final TextEditingController? nameController;
  final FocusNode? emailFocus;
  final FocusNode? passwordFocus;
  final FocusNode? nameFocus;
  final AuthMode mode;
  final UserRole userRole;
  final void Function(UserRole) onChanged;
  final LogRegFormState status;
  final LogRegFormNotifier notifier;
  final AuthMode authMode;
  final AsyncValue<AppUser?> authAction;

  const AuthForm({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.nameController,
    required this.emailFocus,
    required this.passwordFocus,
    required this.nameFocus,
    required this.mode,
    required this.userRole,
    required this.onChanged,
    required this.status,
    required this.notifier,
    required this.authMode,
    required this.authAction,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomTextFormField(
            controller: emailController,
            focusNode: emailFocus,
            icon: Icons.email,
            label: 'Email',
            keyboardType: TextInputType.emailAddress,
            errorText: status.emailError,
            onChanged: (value) {
              notifier.validateEmail(value);
            },
          ),
          const SizedBox(height: 10),
          mode == AuthMode.register
              ? CustomTextFormField(
                  controller: nameController,
                  focusNode: nameFocus,
                  icon: Icons.person,
                  label: 'Name',
                  errorText: status.nameError,
                  onChanged: (value) {
                    notifier.validateName(value);
                  },
                )
              : const SizedBox.shrink(),
          mode == AuthMode.register
              ? const SizedBox(height: 10)
              : const SizedBox.shrink(),

          CustomTextFormField(
            controller: passwordController,
            focusNode: passwordFocus,
            icon: Icons.lock,
            label: 'Password',
            obscureText: true,
            errorText: status.passwordError,
            onChanged: (value) {
              notifier.validatePassword(value);
            },
          ),
          mode == AuthMode.register
              ? const SizedBox(height: 10)
              : const SizedBox.shrink(),
          mode == AuthMode.register
              ? UserRoleSelector(
                  selectedRole: userRole,
                  onChanged: (value) => onChanged(value),
                )
              : const SizedBox.shrink(),
          const SizedBox(height: 10),
          CustomElevatedButton(
            buttonTextColor:
                AppColor.kLogRegButtonForegroundColor,

            onPressed: () async {},
            text: authMode == AuthMode.register
                ? 'Sign up'
                : 'Login',
            icon: authMode == AuthMode.register
                ? Icons.person_add
                : Icons.login_rounded,
            iconSize: 20,
            iconColor:
                AppColor.kLogRegButtonForegroundColor,
            backgroundColor: AppColor.kLoginButtonBgColor,
            foregroundColor: AppColor.kTextPrimary,
            height: 50,
            width: MediaQuery.of(context).size.width,
          ),
        ],
      ),
    );
  }
}
