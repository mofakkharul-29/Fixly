import 'package:flutter/material.dart';

class CustomTextFormat extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final TextOverflow? overflow;
  final int? maxLines;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? backgroundColor;
  final double? letterSpacing;
  final double? wordSpacing;

  const CustomTextFormat({
    super.key,
    required this.text,
    this.textAlign,
    this.textDirection,
    this.overflow,
    this.maxLines,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.backgroundColor,
    this.letterSpacing,
    this.wordSpacing,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      textDirection: textDirection,
      overflow: overflow,
      maxLines: maxLines,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        backgroundColor: backgroundColor,
        letterSpacing: letterSpacing,
        wordSpacing: wordSpacing,
      ),
    );
  }
}
