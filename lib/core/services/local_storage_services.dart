import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageServices {
  Future<bool> isOnboardingDone() async {
    final SharedPreferences pref =
        await SharedPreferences.getInstance();
    debugPrint(
      'value is: ${pref.getBool('isOnboardingDone') ?? false}',
    );
    return pref.getBool('isOnboardingDone') ?? false;
  }

  Future<void> setOnboardingDone() async {
    final SharedPreferences pref =
        await SharedPreferences.getInstance();
    pref.setBool('isOnboardingDone', true);
  }
}
