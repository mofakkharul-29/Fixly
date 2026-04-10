import 'package:fixly/core/theme/app_color.dart';
import 'package:fixly/core/utils/custom_elevated_button.dart';
import 'package:fixly/core/utils/onboarding_page.dart';
import 'package:fixly/features/onboarding/data/onboarding_data.dart';
import 'package:fixly/features/onboarding/widget/page_indicator.dart';
import 'package:fixly/features/onboarding/widget/skip_button.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() =>
      _OnboardingScreenState();
}

class _OnboardingScreenState
    extends State<OnboardingScreen> {
  final PageController _controller = PageController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pages = onboardingPages;

    return Scaffold(
      backgroundColor: AppColor.kAppBarBackground,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _controller,
                    itemCount: pages.length,
                    itemBuilder: (context, index) {
                      return OnboardingPage(
                        page: pages[index],
                      );
                    },
                    onPageChanged: (value) {
                      _controller.animateToPage(
                        value,
                        duration: const Duration(
                          milliseconds: 300,
                        ),
                        curve: Curves.ease,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                const PageIndicator(),
                const SizedBox(height: 10),
                CustomElevatedButton(
                  onPressed: () {},
                  text: 'Get Started',
                  icon: Icons.arrow_right_alt,
                  foregroundColor: AppColor.kTextPrimary,
                  backgroundColor:
                      AppColor.kElevatedButtonBgColor,
                  width:
                      MediaQuery.of(context).size.width *
                      0.92,
                ),
              ],
            ),
            Positioned(
              top: 1.0,
              right: 16.0,
              child: SkipButton(
                text: 'Skip',
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
