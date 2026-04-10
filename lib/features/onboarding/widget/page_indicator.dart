import 'package:fixly/features/onboarding/data/onboarding_data.dart';
import 'package:flutter/material.dart';

class PageIndicator extends StatelessWidget {
  final int currentPage;
  const PageIndicator({
    super.key,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(onboardingPages.length, (
        index,
      ) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 5),
          height: 8,
          width: index == currentPage ? 25 : 15,
          decoration: BoxDecoration(
            color: index == currentPage
                ? Colors.deepPurpleAccent
                : const Color(0x63AB9EF5),
            borderRadius: BorderRadius.circular(5),
          ),
        );
      }),
    );
  }
}
