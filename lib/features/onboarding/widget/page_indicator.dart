import 'package:fixly/features/onboarding/data/onboarding_data.dart';
import 'package:flutter/material.dart';

class PageIndicator extends StatelessWidget {
  const PageIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(onboardingPages.length, (
        index,
      ) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          height: 8,
          width: 15,
          decoration: BoxDecoration(
            // when use logic then also use this color
            //const Color(0x63AB9EF5),
            color: Colors.deepPurpleAccent,
            borderRadius: BorderRadius.circular(5),
          ),
        );
      }),
    );
  }
}
