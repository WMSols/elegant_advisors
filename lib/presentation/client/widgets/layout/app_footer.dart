import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors/app_colors.dart';
import '../../../../core/utils/app_spacing/app_spacing.dart';
import '../../../../core/utils/app_styles/app_text_styles.dart';
import '../../../../core/utils/app_texts/app_texts.dart';

class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppSpacing.symmetric(context, h: 0.04, v: 0.04),
      decoration: const BoxDecoration(
        color: AppColors.primary,
      ),
      child: Column(
        children: [
          Text(
            AppTexts.webName,
            style: AppTextStyles.heading(context).copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          AppSpacing.vertical(context, 0.02),
          Text(
            AppTexts.footerTagline,
            style: AppTextStyles.bodyText(context).copyWith(
              color: AppColors.white,
            ),
            textAlign: TextAlign.center,
          ),
          AppSpacing.vertical(context, 0.02),
          Text(
            AppTexts.footerCopyright(),
            style: AppTextStyles.bodyText(context).copyWith(
              color: AppColors.white,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
