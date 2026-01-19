import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';

/// Reusable error fallback widget for failed image loads
class AppErrorImageFallback extends StatelessWidget {
  /// Custom icon size (optional, uses responsive sizing if not provided)
  final double? iconSize;

  /// Background color (optional)
  final Color? backgroundColor;

  /// Icon color (optional)
  final Color? iconColor;

  /// Whether to show error message text
  final bool showMessage;

  /// Custom error message
  final String? message;

  const AppErrorImageFallback({
    super.key,
    this.iconSize,
    this.backgroundColor,
    this.iconColor,
    this.showMessage = false,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    final defaultIconSize =
        iconSize ?? AppResponsive.scaleSize(context, 48, min: 30, max: 80);
    final bgColor = backgroundColor ?? AppColors.grey.withValues(alpha: 0.2);
    final iconColorValue = iconColor ?? AppColors.white.withValues(alpha: 0.5);

    return Container(
      decoration: BoxDecoration(color: bgColor),
      child: Center(
        child: showMessage
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Iconsax.image,
                    size: defaultIconSize,
                    color: iconColorValue,
                  ),
                  SizedBox(
                    height: AppResponsive.scaleSize(context, 4, min: 2, max: 8),
                  ),
                  Text(
                    message ?? 'Failed to load',
                    style: AppTextStyles.bodyText(context).copyWith(
                      color: iconColorValue,
                      fontSize: AppResponsive.scaleSize(
                        context,
                        10,
                        min: 8,
                        max: 12,
                      ),
                    ),
                  ),
                ],
              )
            : Icon(Iconsax.image, size: defaultIconSize, color: iconColorValue),
      ),
    );
  }
}
