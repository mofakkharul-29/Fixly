import 'package:fixly/core/utils/custom_text_field.dart';
import 'package:fixly/features/auth/data/form_notifier.dart';
import 'package:fixly/features/auth/model/repository/form_state.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  final LgoRegFormNotifier notifier;
  final LogRegFormState status;
  final bool isRegisterPage;
  const AuthPage({
    super.key,
    required this.isRegisterPage,
    required this.notifier,
    required this.status,
  });

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _key = GlobalKey<FormState>();
  final TextEditingController _emailController =
      TextEditingController();
  final TextEditingController _passwordController =
      TextEditingController();
  final TextEditingController _nameController =
      TextEditingController();

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _nameFocus = FocusNode();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();

    _emailFocus.dispose();
    _passwordFocus.dispose();
    _nameFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomTextFormField(
            controller: _emailController,
            focusNode: _emailFocus,
            label: 'email',
            icon: Icons.email_outlined,
            errorText: widget.status.emailError,
            onChanged: (value) {
              widget.notifier.validateEmail(value);
            },
          ),
          const SizedBox(height: 10),
          widget.isRegisterPage
              ? CustomTextFormField(
                  controller: _nameController,
                  focusNode: _nameFocus,
                  icon: Icons.person,
                  label: 'username',
                  errorText: widget.status.nameError,
                  onChanged: (value) {
                    widget.notifier.validateName(value);
                  },
                )
              : SizedBox(),
          widget.isRegisterPage
              ? const SizedBox(height: 10)
              : SizedBox(),
          CustomTextFormField(
            controller: _passwordController,
            focusNode: _passwordFocus,
            icon: Icons.lock,
            label: 'password',
            obscureText: true,
            errorText: widget.status.passwordError,
            onChanged: widget.notifier.validatePassword,
          ),
        ],
      ),
    );
  }
}
