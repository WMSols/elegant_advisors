import 'package:flutter/material.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';

class FooterContactItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const FooterContactItem({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: AppResponsive.scaleSize(context, 16, min: 14, max: 18),
          color: AppColors.white.withValues(alpha: 0.8),
        ),
        AppSpacing.horizontal(context, 0.01),
        Expanded(
          child: Text(
            text,
            style: AppTextStyles.bodyText(context).copyWith(
              color: AppColors.white.withValues(alpha: 0.8),
              fontSize: AppResponsive.fontSizeClamped(
                context,
                min: 11,
                max: 13,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
