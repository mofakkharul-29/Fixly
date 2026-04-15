import 'package:fixly/core/theme/app_color.dart';
import 'package:fixly/core/utils/auth_page.dart';
import 'package:fixly/core/utils/custom_divider.dart';
import 'package:fixly/core/utils/custom_elevated_button.dart';
import 'package:fixly/core/utils/log_reg_text.dart';
import 'package:fixly/core/utils/login_option.dart';
import 'package:fixly/features/auth/widget/body_container.dart';
import 'package:flutter/material.dart';

class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                  const AuthPage(isRegisterPage: false),
                  LogRegText(
                    firstText: 'don\'t have an account? ',
                    lastText: 'Signup',
                    onTap: () {},
                  ),
                  const SizedBox(height: 10),
                  CustomElevatedButton(
                    buttonTextColor: AppColor
                        .kLogRegButtonForegroundColor,
                    onPressed: () {},
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
