import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Custom smooth transition for admin navigation
/// Combines fade and slide for a professional effect
class AdminFadeSlideTransition extends CustomTransition {
  @override
  Widget buildTransition(
    BuildContext context,
    Curve? curve,
    Alignment? alignment,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    // Combine fade and slide for smooth effect
    return FadeTransition(
      opacity: CurvedAnimation(
        parent: animation,
        curve: curve ?? Curves.easeInOut,
      ),
      child: SlideTransition(
        position:
            Tween<Offset>(
              begin: const Offset(0.05, 0.0), // Slight slide from right
              end: Offset.zero,
            ).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
            ),
        child: child,
      ),
    );
  }
}

/// Custom smooth transitions for admin navigation
class AdminTransitions {
  AdminTransitions._();

  /// Custom transition instance for smooth admin navigation
  static final CustomTransition buildTransition = AdminFadeSlideTransition();
}
