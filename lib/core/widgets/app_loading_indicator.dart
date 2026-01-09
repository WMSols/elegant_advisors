import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:elegant_advisors/core/utils/app_lotties/app_lotties.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';

/// Reusable loading indicator widget using Lottie animations
///
/// Supports two variants:
/// - primary: Uses loadingIndicatorPrimary (default)
/// - white: Uses loadingIndicatorWhite
class AppLoadingIndicator extends StatelessWidget {
  /// The variant of the loading indicator
  /// - primary: Default primary color loading indicator
  /// - white: White color loading indicator
  final LoadingIndicatorVariant variant;

  /// Optional size override. If not provided, uses AppResponsive.iconSize(context)
  final double? size;

  const AppLoadingIndicator({
    super.key,
    this.variant = LoadingIndicatorVariant.primary,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    final indicatorSize = size ?? AppResponsive.iconSize(context);
    final lottieAsset = variant == LoadingIndicatorVariant.white
        ? AppLotties.loadingIndicatorWhite
        : AppLotties.loadingIndicatorPrimary;

    return SizedBox(
      width: indicatorSize,
      height: indicatorSize,
      child: Lottie.asset(lottieAsset, fit: BoxFit.contain),
    );
  }
}

/// Enum for loading indicator variants
enum LoadingIndicatorVariant {
  /// Primary color loading indicator
  primary,

  /// White color loading indicator
  white,
}
