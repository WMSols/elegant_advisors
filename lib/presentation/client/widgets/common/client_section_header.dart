import 'package:flutter/material.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';
import 'package:elegant_advisors/core/widgets/text/app_text.dart';

/// Reusable centered section header for client marketing sections.
/// Use [titleColor], [taglineColor], [descriptionColor] to override defaults.
class ClientSectionHeader extends StatelessWidget {
  final String title;
  final String? tagline;
  final String? description;
  final TextAlign textAlign;
  final Color? titleColor;
  final Color? taglineColor;
  final Color? descriptionColor;

  const ClientSectionHeader({
    super.key,
    required this.title,
    this.tagline,
    this.description,
    this.textAlign = TextAlign.center,
    this.titleColor,
    this.taglineColor,
    this.descriptionColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: textAlign == TextAlign.center
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        AppText(
          title,
          style: AppTextStyles.displayTitle(
            context,
          ).copyWith(color: titleColor ?? AppColors.white),
          textAlign: textAlign,
        ),
        if (tagline != null) ...[
          AppSpacing.vertical(context, 0.02),
          AppText(
            tagline!,
            style: AppTextStyles.tagline(context).copyWith(
              color: taglineColor ?? AppColors.white.withValues(alpha: 0.75),
            ),
            textAlign: textAlign,
          ),
        ],
        if (description != null) ...[
          AppSpacing.vertical(context, 0.03),
          AppText(
            description!,
            style: AppTextStyles.bodyText(context).copyWith(
              color:
                  descriptionColor ?? AppColors.white.withValues(alpha: 0.85),
              height: 1.6,
            ),
            textAlign: textAlign,
          ),
        ],
      ],
    );
  }
}
