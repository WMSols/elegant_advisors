import 'package:flutter/material.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_images/app_images.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';
import 'package:elegant_advisors/core/utils/app_texts/app_texts.dart';
import 'package:elegant_advisors/core/widgets/buttons/app_button.dart';

/// Reusable error state widget
/// Displays error image, title, optional message, and retry button
/// Can be used in both client and admin sides
class AppErrorState extends StatelessWidget {
  final String title;
  final String? message;
  final VoidCallback onRetry;
  final String? retryButtonText;
  final Color? titleColor;
  final Color? messageColor;
  final Color? buttonBackgroundColor;
  final Color? buttonTextColor;
  final double? buttonWidth;

  const AppErrorState({
    super.key,
    required this.title,
    this.message,
    required this.onRetry,
    this.retryButtonText,
    this.titleColor,
    this.messageColor,
    this.buttonBackgroundColor,
    this.buttonTextColor,
    this.buttonWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppSpacing.all(context, factor: 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AppImages.errorState,
            width: AppResponsive.scaleSize(context, 140, min: 120, max: 160),
            height: AppResponsive.scaleSize(context, 140, min: 120, max: 160),
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return Icon(
                Icons.error_outline,
                size: AppResponsive.scaleSize(context, 80, min: 60, max: 100),
                color: titleColor ?? AppColors.error,
              );
            },
          ),
          AppSpacing.vertical(context, 0.03),
          Text(
            title,
            style: AppTextStyles.heading(context).copyWith(
              fontSize: AppResponsive.fontSizeClamped(
                context,
                min: 20,
                max: 28,
              ),
              color: titleColor ?? AppColors.error,
            ),
            textAlign: TextAlign.center,
          ),
          if (message != null) ...[
            AppSpacing.vertical(context, 0.02),
            Text(
              message!,
              style: AppTextStyles.bodyText(context).copyWith(
                color: messageColor ?? AppColors.grey,
                fontSize: AppResponsive.fontSizeClamped(
                  context,
                  min: 14,
                  max: 16,
                ),
              ),
              textAlign: TextAlign.center,
            ),
          ],
          AppSpacing.vertical(context, 0.03),
          AppButton(
            text: retryButtonText ?? AppTexts.commonRetry,
            onPressed: onRetry,
            width: buttonWidth ?? AppResponsive.screenWidth(context) * 0.3,
            backgroundColor: buttonBackgroundColor ?? AppColors.error,
            textColor: buttonTextColor ?? AppColors.white,
          ),
        ],
      ),
    );
  }
}
