import 'package:fixly/core/theme/app_color.dart';
import 'package:fixly/core/utils/custom_elevated_button.dart';
import 'package:fixly/core/utils/onboarding_page.dart';
import 'package:fixly/features/onboarding/data/onboarding_data.dart';
import 'package:fixly/features/onboarding/model/onboarding_pages.dart';
import 'package:fixly/features/onboarding/widget/page_indicator.dart';
import 'package:fixly/features/onboarding/widget/skip_button.dart';
import 'package:fixly/features/provider/onboarding_notifier_provider.dart';
import 'package:fixly/features/provider/page_repo_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() =>
      _OnboardingScreenState();
}

class _OnboardingScreenState
    extends ConsumerState<OnboardingScreen> {
  final PageController _controller = PageController();
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<OnboardingPages> pages = onboardingPages;
    final currentPage = ref.watch(pageRepoNotifierProvider);

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
                      ref
                          .read(
                            pageRepoNotifierProvider
                                .notifier,
                          )
                          .onPageChange(value);
                    },
                  ),
                ),
                const SizedBox(height: 10),
                PageIndicator(currentPage: currentPage),
                const SizedBox(height: 10),
                CustomElevatedButton(
                  onPressed: currentPage < pages.length - 1
                      ? () {
                          customAnimateTo(
                            page: currentPage + 1,
                          );
                        }
                      : () async {
                          await ref
                              .read(
                                onboardingNotifierProfiver
                                    .notifier,
                              )
                              .setOnboardingDone();
                        },
                  text: currentPage < pages.length - 1
                      ? 'Next'
                      : 'Get Started',
                  icon: Icons.arrow_right_alt,
                  foregroundColor: AppColor.kTextPrimary,
                  backgroundColor:
                      currentPage < pages.length - 1
                      ? AppColor.kTextSecondary
                      : AppColor.kElevatedButtonBgColor,
                  width:
                      MediaQuery.of(context).size.width *
                      0.92,
                ),
              ],
            ),
            currentPage < pages.length - 1
                ? Positioned(
                    top: 1.0,
                    right: 16.0,
                    child: SkipButton(
                      text: 'Skip',
                      onPressed: () {
                        final lastPage = pages.length - 1;
                        customAnimateTo(page: lastPage);
                      },
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  void customAnimateTo({
    required int page,
    int time = 300,
    Curve curve = Curves.easeIn,
  }) {
    _controller.animateToPage(
      page,
      duration: Duration(milliseconds: time),
      curve: curve,
    );
  }
}
