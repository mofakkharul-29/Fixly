import 'package:fixly/core/theme/app_color.dart';
import 'package:fixly/core/utils/custom_divider.dart';
import 'package:fixly/core/utils/custom_elevated_button.dart';
import 'package:fixly/core/utils/log_reg_text.dart';
import 'package:fixly/core/utils/login_option.dart';
import 'package:fixly/features/auth/widget/body_container.dart';
import 'package:fixly/features/provider/register_mode_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthenticationScreen extends ConsumerWidget {
  const AuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isRegisterMode = ref.watch(
      isRegisterModeProvider,
    );

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
                  LogRegText(
                    firstText: isRegisterMode
                        ? 'Already have an account? '
                        : 'Don\'t have an account? ',
                    lastText: isRegisterMode
                        ? 'Login'
                        : 'Sign up',
                    onTap: () {
                      final current = ref.read(
                        isRegisterModeProvider,
                      );
                      ref
                              .read(
                                isRegisterModeProvider
                                    .notifier,
                              )
                              .state =
                          !current;
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomElevatedButton(
                    buttonTextColor: AppColor
                        .kLogRegButtonForegroundColor,

                    onPressed: () async {},
                    text: isRegisterMode
                        ? 'Sign up'
                        : 'Login',
                    icon: isRegisterMode
                        ? Icons.person_add
                        : Icons.login_rounded,
                    iconSize: 20,
                    iconColor: AppColor
                        .kLogRegButtonForegroundColor,
                    backgroundColor:
                        AppColor.kLoginButtonBgColor,
                    foregroundColor: AppColor.kTextPrimary,
                    height: 50,
                    width: MediaQuery.of(
                      context,
                    ).size.width,
                  ),
                  const SizedBox(height: 15),
                  const CustomDivider(),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      LoginOption(
                        onPressed: () {},
                        image: 'assets/images/google.png',
                      ),
                      LoginOption(
                        onPressed: () {},
                        image: 'assets/images/facebook.png',
                      ),
                      LoginOption(
                        onPressed: () {},
                        image: 'assets/images/phone.png',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
