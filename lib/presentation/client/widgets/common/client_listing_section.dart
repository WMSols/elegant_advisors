import 'package:flutter/material.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';

/// Reusable listing section wrapper
/// Provides consistent styling for listing sections
class ClientListingSection extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final EdgeInsets? padding;
  final double? minHeight;
  final double? horizontalPadding;
  final double? verticalPadding;

  const ClientListingSection({
    super.key,
    required this.child,
    this.backgroundColor,
    this.padding,
    this.minHeight,
    this.horizontalPadding,
    this.verticalPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: minHeight != null
          ? BoxConstraints(
              minHeight: minHeight!,
            )
          : BoxConstraints(
              minHeight: AppResponsive.screenHeight(context) * 0.5,
            ),
      color: backgroundColor ?? AppColors.white,
      padding: padding ??
          AppSpacing.symmetric(
            context,
            h: horizontalPadding ?? 0.1,
            v: verticalPadding ?? 0.06,
          ),
      child: child,
    );
  }
}
