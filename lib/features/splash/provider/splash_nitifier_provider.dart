import 'package:fixly/features/splash/repository/splash_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final splashNotifierProvider = NotifierProvider<SplashNotifier, bool>(
  SplashNotifier.new,
);
