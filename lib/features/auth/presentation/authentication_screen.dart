import 'package:fixly/core/theme/app_color.dart';
import 'package:fixly/core/utils/auth_page.dart';
import 'package:fixly/core/utils/custom_divider.dart';
import 'package:fixly/core/utils/custom_elevated_button.dart';
import 'package:fixly/core/utils/log_reg_text.dart';
import 'package:fixly/core/utils/login_option.dart';
import 'package:fixly/features/auth/widget/body_container.dart';
import 'package:fixly/features/provider/firebase_all_provider.dart';
import 'package:fixly/features/provider/form_status_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthenticationScreen extends ConsumerWidget {
  const AuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formStatus = ref.watch(formStatusProvider);
    final formNotifier = ref.read(
      formStatusProvider.notifier,
    );
    final authNotifier = ref.read(
      authNotifierProvidr.notifier,
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
                  AuthPage(
                    isRegisterPage: true,
                    notifier: formNotifier,
                    status: formStatus,
                  ),
                  LogRegText(
                    firstText: 'don\'t have an account? ',
                    lastText: 'Signup',
                    onTap: () {},
                  ),
                  const SizedBox(height: 10),
                  CustomElevatedButton(
                    buttonTextColor: AppColor
                        .kLogRegButtonForegroundColor,
                    onPressed: () async {},
                    text: 'login',
                    icon: Icons.login_rounded,
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
