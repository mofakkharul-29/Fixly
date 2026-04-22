import 'package:fixly/features/auth/presentation/authentication_screen.dart';
import 'package:fixly/features/onboarding/presentation/onboarding_screen.dart';
import 'package:fixly/features/provider/auth_notifier_provider.dart';
import 'package:fixly/features/provider/onboarding_notifier_provider.dart';
import 'package:fixly/features/provider/router_listenable_provider.dart';
import 'package:fixly/features/provider/splash_status.dart';
import 'package:fixly/features/splash/presentation/splash_screen.dart';
import 'package:fixly/features/user/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AppRoute {
  static final GlobalKey<NavigatorState> _navigatorKey =
      GlobalKey();

  static final routeProvider = Provider<GoRouter>((ref) {
    return GoRouter(
      initialLocation: '/splash',
      navigatorKey: _navigatorKey,
      debugLogDiagnostics: true,
      refreshListenable: ref.read(routerListenableprovider),
      redirect: (context, state) {
        final user = ref
            .read(authStateProvider)
            .asData
            ?.value;
        final bool onbordingDone =
            ref.read(onboardingNotifierProfiver).value ??
            false;
        final splashDone = ref.read(splashStatus);

        final location = state.matchedLocation;

        // final isSplash = location == '/splash';

        final isAuth = location == '/authentication';

        if (!splashDone) return '/splash';

        if (!onbordingDone) return '/onboarding';

        if (user == null && !isAuth) {
          return '/authentication';
        }

        if (user != null && isAuth) return '/home';

        return null;
      },
      routes: <RouteBase>[
        GoRoute(
          path: '/splash',
          builder: (context, state) => const SplashScreen(),
        ),
        GoRoute(
          path: '/onboarding',
          builder: (context, state) =>
              const OnboardingScreen(),
        ),
        GoRoute(
          path: '/authentication',
          builder: (context, state) =>
              const AuthenticationScreen(),
        ),
        GoRoute(
          path: '/home',
          builder: (context, state) => const Home(),
        ),
      ],
    );
  });
}
