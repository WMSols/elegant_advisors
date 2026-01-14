import 'package:flutter/material.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';

class AppCategoryCard extends StatelessWidget {
  final String title;
  final String description;

  const AppCategoryCard({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.bodyText(context).copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
            fontSize: AppResponsive.fontSizeClamped(context, min: 18, max: 22),
          ),
          textAlign: TextAlign.left,
        ),
        AppSpacing.vertical(context, 0.01),
        Text(
          description,
          style: AppTextStyles.bodyText(context).copyWith(
            color: AppColors.black.withValues(alpha: 0.7),
            fontSize: AppResponsive.fontSizeClamped(context, min: 14, max: 18),
            height: 1.6,
          ),
          textAlign: TextAlign.left,
        ),
      ],
    );
  }
}
