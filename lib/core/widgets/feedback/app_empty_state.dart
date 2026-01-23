import 'package:flutter/material.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_images/app_images.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';
import 'package:elegant_advisors/core/widgets/buttons/app_button.dart';

/// Reusable empty state widget
/// Displays image, title, message, and optional action button
/// Can be used in both client and admin sides
class AppEmptyState extends StatelessWidget {
  final String? title;
  final Color? titleColor;
  final String message;
  final Color? messageColor;
  final String? buttonText;
  final VoidCallback? onButtonPressed;
  final Color? buttonBackgroundColor;
  final Color? buttonTextColor;
  final bool showImage;
  final bool centerContent;

  const AppEmptyState({
    super.key,
    this.title,
    this.titleColor,
    required this.message,
    this.messageColor,
    this.buttonText,
    this.onButtonPressed,
    this.buttonBackgroundColor,
    this.buttonTextColor,
    this.showImage = true,
    this.centerContent = false,
  });

  @override
  Widget build(BuildContext context) {
    final content = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (showImage) ...[
          Image.asset(
            AppImages.emptyState,
            width: AppResponsive.scaleSize(context, 140, min: 120, max: 160),
            height: AppResponsive.scaleSize(context, 140, min: 120, max: 160),
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return Icon(
                Icons.search_off,
                size: AppResponsive.scaleSize(context, 80, min: 60, max: 100),
                color: (messageColor ?? AppColors.grey).withValues(alpha: 0.5),
              );
            },
          ),
          AppSpacing.vertical(context, 0.02),
        ],
        if (title != null) ...[
          Text(
            title!,
            style: AppTextStyles.heading(context).copyWith(
              fontSize: AppResponsive.fontSizeClamped(
                context,
                min: 20,
                max: 28,
              ),
              color: titleColor ?? AppColors.primary,
            ),
            textAlign: TextAlign.center,
          ),
          AppSpacing.vertical(context, 0.01),
        ],
        Text(
          message,
          style: AppTextStyles.bodyText(context).copyWith(
            color: messageColor ?? AppColors.grey,
            fontSize: AppResponsive.fontSizeClamped(context, min: 14, max: 16),
          ),
          textAlign: TextAlign.center,
        ),
        if (buttonText != null && onButtonPressed != null) ...[
          AppSpacing.vertical(context, 0.03),
          AppButton(
            text: buttonText!,
            onPressed: onButtonPressed,
            backgroundColor: buttonBackgroundColor ?? AppColors.primary,
            textColor: buttonTextColor ?? AppColors.white,
          ),
        ],
      ],
    );

    if (centerContent) {
      return Center(child: content);
    }

    return Container(
      padding: AppSpacing.all(context, factor: 2),
      child: content,
    );
  }
}
