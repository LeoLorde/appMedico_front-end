import 'package:flutter/material.dart';

class ResponsiveHelper {
  final BuildContext context;

  ResponsiveHelper(this.context);

  // Get screen width
  double get screenWidth => MediaQuery.of(context).size.width;

  // Get screen height
  double get screenHeight => MediaQuery.of(context).size.height;

  // Responsive font size based on screen width
  double fontSize(double size) {
    double baseWidth = 375; // iPhone SE width as base
    return (screenWidth / baseWidth) * size;
  }

  // Responsive width
  double width(double size) {
    double baseWidth = 375;
    return (screenWidth / baseWidth) * size;
  }

  // Responsive height
  double height(double size) {
    double baseHeight = 812; // iPhone X height as base
    return (screenHeight / baseHeight) * size;
  }

  // Check if it's a small device
  bool get isSmallDevice => screenWidth < 375;

  // Check if it's a tablet
  bool get isTablet => screenWidth >= 600;
}
