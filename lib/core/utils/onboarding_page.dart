import 'package:fixly/core/theme/app_color.dart';
import 'package:fixly/core/utils/custom_text_format.dart';
import 'package:fixly/features/onboarding/model/onboarding_pages.dart';
import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  final OnboardingPages page;
  const OnboardingPage({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    final Radius radius = Radius.circular(5);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 14.5),
      decoration: BoxDecoration(
        color: AppColor.kScaffoldBackground,
        borderRadius: BorderRadius.only(
          topLeft: radius,
          topRight: radius,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            flex: 7,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: radius,
                topRight: radius,
              ),
              child: Image.asset(
                page.image,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            flex: 3,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 8.0,
                    right: 8.0,
                    top: 20.0,
                  ),
                  child: CustomTextFormat(
                    text: page.title,
                    color: Colors.white70,
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 8.0,
                    right: 8.0,
                    top: 10,
                  ),
                  child: CustomTextFormat(
                    text: page.descripTion,
                    color: Colors.white70,
                    fontSize: 16,
                    textAlign: TextAlign.justify,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
