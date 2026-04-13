import 'package:flutter/material.dart';

class BodyContainer extends StatelessWidget {
  final Widget? child;
  const BodyContainer({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const AssetImage(
            'assets/images/body4.jpg',
          ),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withAlpha(90),
            BlendMode.darken,
          ),
        ),
      ),
      child: child,
    );
  }
}
