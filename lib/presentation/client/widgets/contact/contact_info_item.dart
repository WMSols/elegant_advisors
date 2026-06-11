import 'package:flutter/material.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';

/// Contact info item widget
class ContactInfoItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final VoidCallback? onTap;

  const ContactInfoItem({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final valueWidget = Text(
      value,
      style: AppTextStyles.bodyText(context).copyWith(
        color: AppColors.white,
        decoration: onTap != null ? TextDecoration.underline : null,
        decorationColor: AppColors.white,
      ),
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: AppColors.white),
        AppSpacing.horizontal(context, 0.01),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyles.bodyText(
                  context,
                ).copyWith(fontWeight: FontWeight.bold, color: AppColors.white),
              ),
              onTap != null
                  ? MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: onTap,
                        behavior: HitTestBehavior.opaque,
                        child: valueWidget,
                      ),
                    )
                  : valueWidget,
            ],
          ),
        ),
      ],
    );
  }
}
