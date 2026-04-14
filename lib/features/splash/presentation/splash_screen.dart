import 'package:fixly/core/theme/app_color.dart';
import 'package:fixly/core/utils/custom_text_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() =>
      _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _textFadeAnimation;
  late Animation<Offset> _textSlideAnimation;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.immersive,
    );
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0)
        .animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(
              0.0,
              0.7,
              curve: Curves.easeOutCubic,
            ),
          ),
        );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0)
        .animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(
              0.0,
              0.5,
              curve: Curves.easeIn,
            ),
          ),
        );

    _textFadeAnimation = Tween<double>(begin: 0.0, end: 1.0)
        .animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(
              0.5,
              1.0,
              curve: Curves.easeIn,
            ),
          ),
        );

    _textSlideAnimation =
        Tween<Offset>(
          begin: const Offset(0, 0.4),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(
              0.5,
              1.0,
              curve: Curves.easeOut,
            ),
          ),
        );

    _controller.forward();

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _onAnimationComplete();
      }
    });
  }

  Future<void> _loadApp() async {
    await Future.wait([
      precacheImage(
        AssetImage('assets/images/logo.png'),
        context,
      ),
      precacheImage(
        AssetImage('assets/images/electrician.jpg'),
        context,
      ),
      precacheImage(
        AssetImage('assets/images/mechanic.jpg'),
        context,
      ),
      precacheImage(
        AssetImage('assets/images/plumber.jpg'),
        context,
      ),
      precacheImage(
        AssetImage('assets/images/body.jpg'),
        context,
      ),
    ]);
  }

  Future<void> _onAnimationComplete() async {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.edgeToEdge,
    );
    await Future.wait([
      Future.delayed(const Duration(milliseconds: 500)),
      _loadApp(),
    ]);
    if (!mounted) return;
    debugPrint('Animation is completed in : ');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColor.kScaffoldBackground,
      body: SizedBox(
        height: mediaSize.height,
        width: double.infinity,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FadeTransition(
                opacity: _fadeAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: mediaSize.width * 0.30,
                    height: mediaSize.width * 0.30,
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              FadeTransition(
                opacity: _textFadeAnimation,
                child: SlideTransition(
                  position: _textSlideAnimation,
                  child: CustomTextFormat(
                    text: 'Fixly',
                    fontSize: mediaSize.width * 0.07,
                    fontWeight: FontWeight.w800,
                    color: AppColor.kSplashTextColor,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
