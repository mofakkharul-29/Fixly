import 'package:flutter/material.dart';

class BodyContainer extends StatelessWidget {
  final Widget? child;
  const BodyContainer({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/images/body.jpg',
            fit: BoxFit.cover,
          ),
        ),

        Positioned.fill(
          child: Container(
            color: Colors.black.withAlpha(40),
          ),
        ),

        ...[child].whereType<Widget>(),
      ],
    );
  }
}
