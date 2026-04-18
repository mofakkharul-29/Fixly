import 'package:flutter/material.dart';

class SubmitIndicator extends StatelessWidget {
  final Color? color;
  final double? strokeWidth;
  final double? width;
  final double? height;
  const SubmitIndicator({
    super.key,
    this.color = Colors.white70,
    this.strokeWidth = 3.0,
    this.height = 22,
    this.width = 22,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: CircularProgressIndicator(
        color: color,
        strokeWidth: strokeWidth,
      ),
    );
  }
}
