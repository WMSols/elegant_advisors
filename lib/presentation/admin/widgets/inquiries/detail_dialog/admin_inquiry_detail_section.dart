import 'package:flutter/material.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';

/// Reusable section widget for inquiry detail dialog
class AdminInquiryDetailSection extends StatelessWidget {
  final String label;
  final IconData icon;
  final String value;

  const AdminInquiryDetailSection({
    super.key,
    required this.label,
    required this.icon,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              color: AppColors.white,
              size: AppResponsive.scaleSize(context, 20, min: 18, max: 22),
            ),
            AppSpacing.horizontal(context, 0.01),
            Text(
              label,
              style: AppTextStyles.heading(context).copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        AppSpacing.vertical(context, 0.01),
        Text(
          value,
          style: AppTextStyles.bodyText(
            context,
          ).copyWith(color: AppColors.white),
        ),
      ],
    );
  }
}
