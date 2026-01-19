import 'package:flutter/material.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';

/// Reusable spec item widget for property cards
class ClientPropertyCardSpecItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const ClientPropertyCardSpecItem({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: AppResponsive.scaleSize(context, 16, min: 14, max: 18),
          color: AppColors.primary,
        ),
        AppSpacing.horizontal(context, 0.01),
        Text(
          text,
          style: AppTextStyles.bodyText(context).copyWith(
            color: AppColors.black.withValues(alpha: 0.7),
            fontSize: AppResponsive.fontSizeClamped(context, min: 14, max: 16),
          ),
        ),
      ],
    );
  }
}
