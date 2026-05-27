import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final TextOverflow? overflow;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? letterSpacing;
  final double? wordSpacing;
  final TextBaseline? textBaseline;
  final double? height;
  final String? fontFamily;

  const AppText({
    super.key,
    required this.text,
    this.textAlign,
    this.textDirection,
    this.overflow,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.letterSpacing,
    this.wordSpacing,
    this.textBaseline,
    this.height,
    this.fontFamily = 'Inter',
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      textDirection: textDirection,
      overflow: overflow,
      style: TextStyle(
        color: color,
        fontFamily: fontFamily,
        fontSize: fontSize,
        fontWeight: fontWeight,
        letterSpacing: letterSpacing,
        height: height,
      ),
    );
  }
}
