import 'package:flutter/material.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';

/// Reusable content container with standard padding
/// Used for consistent content spacing across pages
class ClientContentContainer extends StatelessWidget {
  final Widget child;
  final double? horizontalPadding;
  final double? verticalPadding;
  final EdgeInsets? customPadding;
  final CrossAxisAlignment crossAxisAlignment;

  const ClientContentContainer({
    super.key,
    required this.child,
    this.horizontalPadding,
    this.verticalPadding,
    this.customPadding,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: customPadding ??
          AppSpacing.symmetric(
            context,
            h: horizontalPadding ?? 0.04,
            v: verticalPadding ?? 0.08,
          ),
      child: child,
    );
  }
}
