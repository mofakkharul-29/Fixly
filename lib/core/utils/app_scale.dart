import 'package:flutter/material.dart';

class AppScale {
  static late double _scaleFactor;

  static void init(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    _scaleFactor = width / 360;
  }

  static double sp(double size) => size * _scaleFactor;
  static double dp(double size) => size * _scaleFactor;
}
