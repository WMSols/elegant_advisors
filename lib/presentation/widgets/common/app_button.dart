import 'package:flutter/material.dart';
import '../../../core/utils/app_colors/app_colors.dart';
import '../../../core/utils/app_gradient/app_gradient.dart';
import '../../../core/utils/app_responsive/app_responsive.dart';
import '../../../core/utils/app_styles/app_text_styles.dart';

/// Primary Button Widget with Gradient Support
class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final double? height;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.backgroundColor,
    this.textColor,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final isDisabled = onPressed == null;

    // Build decoration
    final decoration = isDisabled
        ? BoxDecoration(color: AppColors.grey.withValues(alpha: 0.5))
        : backgroundColor != null
        ? BoxDecoration(color: backgroundColor)
        : BoxDecoration().withAppGradient();

    // Determine text color
    final finalTextColor =
        textColor ??
        (backgroundColor != null ? AppColors.primary : AppColors.white);

    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? AppResponsive.screenHeight(context) * 0.06,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isLoading ? null : onPressed,
          child: Container(
            decoration: decoration,
            child: Center(
              child: isLoading
                  ? SizedBox(
                      height: AppResponsive.iconSize(context),
                      width: AppResponsive.iconSize(context),
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          finalTextColor,
                        ),
                      ),
                    )
                  : Text(
                      text,
                      style: AppTextStyles.buttonText(context).copyWith(
                        color: finalTextColor,
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
