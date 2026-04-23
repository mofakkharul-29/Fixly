import 'package:fixly/core/utils/auth_form.dart';
import 'package:fixly/core/utils/custom_divider.dart';
import 'package:fixly/core/utils/log_reg_text.dart';
import 'package:fixly/features/auth/model/repository/form_notifier.dart';
import 'package:fixly/features/auth/model/repository/form_state.dart';
import 'package:fixly/features/auth/widget/body_container.dart';
import 'package:fixly/features/auth/widget/get_login_optiond.dart';
import 'package:fixly/features/auth/widget/user_role.dart';
import 'package:fixly/features/provider/auth_action_provider.dart';
import 'package:fixly/features/provider/auth_mode_provider.dart';
import 'package:fixly/features/provider/form_status.dart';
import 'package:fixly/features/provider/user_role_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthenticationScreen extends ConsumerStatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  ConsumerState<AuthenticationScreen> createState() =>
      _AuthenticationScreenState();
}

class _AuthenticationScreenState
    extends ConsumerState<AuthenticationScreen> {
  final GlobalKey<FormState> formKey =
      GlobalKey<FormState>();

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

  void _resetControllers() {
    _emailController.clear();
    _passwordController.clear();
    _nameController.clear();
  }

  void onRoleChange(UserRole value) {
    debugPrint('recent user role: ${value.name}');
    ref.read(userRoleProvider.notifier).state = value;
  }

  @override
  Widget build(BuildContext context) {
    final AuthMode authMode = ref.watch(authModeProvider);
    final UserRole userRole = ref.watch(userRoleProvider);
    final LogRegFormState formStatus = ref.watch(
      formStatusProvider,
    );
    final LogRegFormNotifier formNotifier = ref.read(
      formStatusProvider.notifier,
    );
    final authNotifier = ref.watch(authNotiferProvider);

    return Scaffold(
      body: BodyContainer(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              top: 15.0,
              left: 15.0,
              right: 15.0,
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(
                  context,
                ).size.height,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AuthForm(
                    formKey: formKey,
                    emailController: _emailController,
                    passwordController: _passwordController,
                    nameController: _nameController,
                    emailFocus: _emailFocus,
                    passwordFocus: _passwordFocus,
                    nameFocus: _nameFocus,
                    mode: authMode,
                    userRole: userRole,
                    onChanged: onRoleChange,
                    status: formStatus,
                    notifier: formNotifier,
                    authMode: authMode,
                    authAction: authNotifier,
                  ),
                  LogRegText(
                    firstText: authMode == AuthMode.login
                        ? 'Don\'t have an account? '
                        : 'Already have an account? ',
                    lastText: authMode == AuthMode.register
                        ? 'Login'
                        : 'Sign up',
                    onTap: () {
                      _resetControllers();
                      formNotifier.resetForm();
                      ref
                              .read(
                                authModeProvider.notifier,
                              )
                              .state =
                          authMode == AuthMode.login
                          ? AuthMode.register
                          : AuthMode.login;
                    },
                  ),
                  const SizedBox(height: 15),
                  const CustomDivider(),
                  const SizedBox(height: 15),
                  const GetLoginOptiond(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
