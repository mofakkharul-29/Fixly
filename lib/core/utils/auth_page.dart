import 'package:fixly/core/utils/custom_text_field.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  final bool isRegisterPage;
  const AuthPage({super.key, required this.isRegisterPage});

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
            onChanged: (value) {},
          ),
          const SizedBox(height: 10),
          widget.isRegisterPage
              ? CustomTextFormField(
                  controller: _nameController,
                  focusNode: _nameFocus,
                  icon: Icons.person,
                  label: 'username',
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
          ),
        ],
      ),
    );
  }
}
