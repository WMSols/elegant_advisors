import 'package:flutter/material.dart';

class AppResponsive {
  static double screenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static double screenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static bool isMobile(BuildContext context) => screenWidth(context) < 600;

  static bool isTablet(BuildContext context) =>
      screenWidth(context) >= 600 && screenWidth(context) < 1024;

  static bool isDesktop(BuildContext context) => screenWidth(context) >= 1024;

  /// Scales size responsively with minimum and maximum bounds
  /// Ensures sizes don't get too small on mobile or too large on desktop
  static double scaleSize(BuildContext context, double size, {double? min, double? max}) {
    final width = screenWidth(context);
    // Base scaling: scales from 375px (mobile) to larger screens
    double scaled = size * (width / 375);
    
    // Apply minimum if provided (prevents too small on mobile)
    if (min != null && scaled < min) {
      scaled = min;
    }
    
    // Apply maximum if provided (prevents too large on desktop)
    if (max != null && scaled > max) {
      scaled = max;
    }
    
    return scaled;
  }

  /// Clamps font size between min and max values
  /// Ensures readable text on all screen sizes
  static double fontSizeClamped(BuildContext context, {required double min, required double max}) {
    final width = screenWidth(context);
    // Scale between min (mobile) and max (desktop) based on screen width
    // Uses a breakpoint approach: 375px = min, 1200px+ = max
    final ratio = ((width - 375) / (1200 - 375)).clamp(0.0, 1.0);
    return min + (max - min) * ratio;
  }

  static double iconSize(BuildContext context, {double factor = 1}) {
    return screenWidth(context) * 0.05 * factor;
  }

  static double radius(BuildContext context, {double factor = 1}) =>
      screenWidth(context) * 0.02 * factor;
}

