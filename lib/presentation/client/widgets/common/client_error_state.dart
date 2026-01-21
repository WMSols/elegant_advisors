import 'package:flutter/material.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_images/app_images.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';
import 'package:elegant_advisors/core/widgets/buttons/app_button.dart';

/// Reusable error state widget
/// Displays error image, title, optional message, and retry button
class ClientErrorState extends StatelessWidget {
  final String title;
  final String? message;
  final VoidCallback onRetry;
  final String? retryButtonText;

  const ClientErrorState({
    super.key,
    required this.title,
    this.message,
    required this.onRetry,
    this.retryButtonText,
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
                color: AppColors.error,
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
              color: AppColors.error,
            ),
            textAlign: TextAlign.center,
          ),
          if (message != null) ...[
            AppSpacing.vertical(context, 0.02),
            Text(
              message!,
              style: AppTextStyles.bodyText(context).copyWith(
                color: AppColors.grey,
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
            text: retryButtonText ?? 'Retry',
            onPressed: onRetry,
            width: AppResponsive.screenWidth(context) * 0.3,
            backgroundColor: AppColors.error,
            textColor: AppColors.white,
          ),
        ],
      ),
    );
  }
}
