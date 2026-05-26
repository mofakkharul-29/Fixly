import 'package:flutter/material.dart';

class AppContainer extends StatelessWidget {
  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final DecorationImage? image;
  final EdgeInsetsGeometry? margin;
  final Color bdrColor;
  final double bdrWidth;
  final BorderStyle bdrStyle;
  final BorderRadiusGeometry? borderRadius;
  final BoxShape shape;
  final double? height;
  final double? width;
  final Widget? child;
  const AppContainer({
    super.key,
    this.alignment,
    this.padding,
    this.color,
    this.image,
    this.margin,
    this.bdrColor = Colors.transparent,
    this.bdrWidth = 0.0,
    this.bdrStyle = BorderStyle.none,
    this.borderRadius,
    this.shape = BoxShape.rectangle,
    this.height,
    this.width,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      alignment: alignment,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: color,
        image: image,
        border: BoxBorder.all(
          color: bdrColor,
          width: bdrWidth,
          style: bdrStyle,
        ),
        borderRadius: borderRadius,
        shape: shape,
      ),
      child: child,
    );
  }
}
