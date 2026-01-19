import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';
import 'package:elegant_advisors/core/utils/app_texts/app_texts.dart';
import 'package:elegant_advisors/core/widgets/buttons/app_button.dart';

/// Error state widget when properties fail to load
class ClientPropertiesErrorState extends StatelessWidget {
  final String? errorMessage;
  final VoidCallback onRetry;

  const ClientPropertiesErrorState({
    super.key,
    this.errorMessage,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppSpacing.all(context, factor: 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Iconsax.warning_2,
            size: AppResponsive.scaleSize(context, 80, min: 60, max: 100),
            color: AppColors.error,
          ),
          AppSpacing.vertical(context, 0.03),
          Text(
            AppTexts.clientPropertiesErrorLoading,
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
          if (errorMessage != null) ...[
            AppSpacing.vertical(context, 0.02),
            Text(
              errorMessage!,
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
            text: AppTexts.clientPropertiesRetry,
            onPressed: onRetry,
            width: AppResponsive.screenWidth(context) * 0.3,
          ),
        ],
      ),
    );
  }
}
