import 'package:flutter/material.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_images/app_images.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';

/// Reusable background section with image decoration
/// Used for sections that need background image with padding
class ClientBackgroundSection extends StatelessWidget {
  final Widget child;
  final String? backgroundImage;
  final EdgeInsets? padding;
  final double? horizontalPadding;
  final double? verticalPadding;

  const ClientBackgroundSection({
    super.key,
    required this.child,
    this.backgroundImage,
    this.padding,
    this.horizontalPadding,
    this.verticalPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.primary, // Fallback color
        image: DecorationImage(
          image: AssetImage(backgroundImage ?? AppImages.homeBackground),
          fit: BoxFit.cover,
          onError: null,
        ),
      ),
      child: Container(
        width: double.infinity,
        padding:
            padding ??
            AppSpacing.symmetric(
              context,
              h: horizontalPadding ?? 0.04,
              v: verticalPadding ?? 0.08,
            ),
        child: child,
      ),
    );
  }
}
