import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract final class SplashHelper {
  static const List<AssetImage> _splashAssets = [
    AssetImage('assets/images/logo.png'),
    AssetImage('assets/images/electrician.jpg'),
    AssetImage('assets/images/mechanic.jpg'),
    AssetImage('assets/images/plumber.jpg'),
    AssetImage('assets/images/body.jpg'),
    AssetImage('assets/images/google.png'),
    AssetImage('assets/images/facebook.png'),
    AssetImage('assets/images/phone.png'),
  ];

  static Future<void> precacheAssets(BuildContext context) async {
    await Future.wait(
      _splashAssets.map((image) => precacheImage(image, context)),
    );
  }

  static Future<void> onAnimationComplete({
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    await Future.wait([
      Future.delayed(const Duration(milliseconds: 500)),
      precacheAssets(context),
    ]);

    if (!context.mounted) return;
  }
}
