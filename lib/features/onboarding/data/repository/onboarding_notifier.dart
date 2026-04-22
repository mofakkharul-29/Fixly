import 'package:fixly/core/services/local_storage_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnboardingNotifier extends AsyncNotifier<bool> {
  final LocalStorageServices localStorage =
      LocalStorageServices();

  @override
  Future<bool> build() async {
    return await localStorage.isOnboardingDone();
  }

  Future<void> setOnboardingDone() async {
    await localStorage.setOnboardingDone();
    state = const AsyncValue.data(true);
  }
}
