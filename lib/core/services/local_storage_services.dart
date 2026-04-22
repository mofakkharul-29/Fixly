import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageServices {
  Future<bool> isOnboardingDone() async {
    final SharedPreferences pref =
        await SharedPreferences.getInstance();
    return pref.getBool('isOnboardingDone') ?? false;
  }

  Future<void> setOnboardingDone() async {
    final SharedPreferences pref =
        await SharedPreferences.getInstance();
    pref.setBool('isOnboardingDone', true);
  }
}
