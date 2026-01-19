import 'package:flutter/material.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';

class FooterLink extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const FooterLink({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: AppResponsive.scaleSize(context, 4, min: 3, max: 6),
      ),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: onTap,
          child: Text(
            text,
            style: AppTextStyles.bodyText(context).copyWith(
              color: AppColors.white.withValues(alpha: 0.8),
              fontSize: AppResponsive.fontSizeClamped(
                context,
                min: 12,
                max: 14,
              ),
              decoration: TextDecoration.none,
            ),
          ),
        ),
      ),
    );
  }
}
