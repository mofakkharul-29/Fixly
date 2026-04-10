import 'package:fixly/core/services/local_storage_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnboardingNotifier extends AsyncNotifier<bool> {
  final LocalStorageServices localStorage =
      LocalStorageServices();

  @override
  Future<bool> build() async {
    final isOnboardingDone = await localStorage
        .isOnboardingFinished();
    return isOnboardingDone ?? false;
  }
}
