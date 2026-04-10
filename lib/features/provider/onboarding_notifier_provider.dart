import 'package:fixly/features/onboarding/data/repository/onboarding_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final onboardingNotifierProfiver =
    AsyncNotifierProvider<OnboardingNotifier, bool>(
      OnboardingNotifier.new,
    );
