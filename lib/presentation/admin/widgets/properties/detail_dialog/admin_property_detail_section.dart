import 'package:flutter/material.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';

/// Reusable detail section widget for property detail dialog
class AdminPropertyDetailSection extends StatelessWidget {
  final String label;
  final IconData icon;
  final String value;

  const AdminPropertyDetailSection({
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
            Icon(icon, color: AppColors.white, size: 20),
            AppSpacing.horizontal(context, 0.01),
            Text(
              label,
              style: AppTextStyles.heading(
                context,
              ).copyWith(color: AppColors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        AppSpacing.vertical(context, 0.005),
        Text(
          value,
          style: AppTextStyles.bodyText(
            context,
          ).copyWith(color: AppColors.white.withValues(alpha: 0.9)),
        ),
      ],
    );
  }
}
