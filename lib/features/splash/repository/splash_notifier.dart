import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  void onComplete() {
    state = true;
    debugPrint('splash finished');
  }
}
