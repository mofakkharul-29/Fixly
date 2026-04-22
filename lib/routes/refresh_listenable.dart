import 'package:fixly/features/provider/auth_notifier_provider.dart';
import 'package:fixly/features/provider/onboarding_notifier_provider.dart';
import 'package:fixly/features/provider/splash_status.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppRouterListenable extends ChangeNotifier {
  final Ref ref;

  AppRouterListenable(this.ref) {
    ref.listen(splashStatus, (_, _) => notifyListeners());
    ref.listen(
      authStateProvider,
      (_, _) => notifyListeners(),
    );

    ref.listen(
      onboardingNotifierProfiver,
      (_, _) => notifyListeners(),
    );
  }
}
