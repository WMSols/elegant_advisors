import 'package:flutter/material.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_gradient/app_gradient.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';
import 'package:elegant_advisors/core/widgets/feedback/app_loading_indicator.dart';

/// Primary Button Widget with Gradient Support
class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final double? height;
  final bool isAdmin;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.backgroundColor,
    this.textColor,
    this.width,
    this.height,
    this.isAdmin = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDisabled = onPressed == null;

    // Use responsive radius for admin, fixed radius for client
    final borderRadius = isAdmin ? AppResponsive.radius(context) : 0.0;

    // Build decoration
    final decoration = isDisabled
        ? BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            color: AppColors.grey.withValues(alpha: 0.5),
          )
        : backgroundColor != null
        ? BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(borderRadius),
          )
        : BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
          ).withAppGradient();

    // Determine text color
    final finalTextColor =
        textColor ??
        (backgroundColor != null ? AppColors.primary : AppColors.white);

    Widget buttonContent = Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isLoading ? null : onPressed,
        child: Container(
          decoration: decoration,
          padding: EdgeInsets.symmetric(
            horizontal: AppResponsive.scaleSize(context, 24, min: 16, max: 32),
            vertical: AppResponsive.screenHeight(context) * 0.015,
          ),
          child: Center(
            child: isLoading
                ? AppLoadingIndicator()
                : Text(
                    text,
                    style: AppTextStyles.buttonText(context).copyWith(
                      color: finalTextColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
          ),
        ),
      ),
    );

    // If width is provided, wrap in SizedBox, otherwise use intrinsic width
    if (width != null) {
      return SizedBox(
        width: width,
        height: height ?? AppResponsive.screenHeight(context) * 0.06,
        child: buttonContent,
      );
    } else {
      return IntrinsicWidth(
        child: SizedBox(
          height: height ?? AppResponsive.screenHeight(context) * 0.06,
          child: buttonContent,
        ),
      );
    }
  }
}
