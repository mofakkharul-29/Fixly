import 'package:fixly/core/utils/app_container.dart';
import 'package:fixly/core/utils/app_scale.dart';
import 'package:fixly/core/utils/app_text.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppContainer(
        color: Colors.grey,
        alignment: Alignment.center,
        gradient: const LinearGradient(
          colors: [Color(0xFF37474F), Color(0xFF546E7A), Color(0xFF677F8B)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RotationTransition(
              turns: _rotationAnimation,
              child: Icon(Icons.settings, size: AppScale.dp(100.0)),
            ),
            SizedBox(height: AppScale.dp(15)),
            AppText(
              text: 'Fixly',
              color: const Color.fromRGBO(0, 0, 0, 0.867),
              fontFamily: 'Poppins',
              fontSize: AppScale.sp(28),
              fontWeight: FontWeight.w700,
            ),
          ],
        ),
      ),
    );
  }
}
