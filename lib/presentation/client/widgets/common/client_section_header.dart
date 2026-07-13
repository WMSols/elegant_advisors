import 'package:flutter/material.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';

/// Reusable centered section header for client marketing sections.
class ClientSectionHeader extends StatelessWidget {
  final String title;
  final String? tagline;
  final String? description;
  final TextAlign textAlign;

  const ClientSectionHeader({
    super.key,
    required this.title,
    this.tagline,
    this.description,
    this.textAlign = TextAlign.center,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: textAlign == TextAlign.center
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.displayTitle(
            context,
          ).copyWith(color: AppColors.primary),
          textAlign: textAlign,
        ),
        if (tagline != null) ...[
          AppSpacing.vertical(context, 0.02),
          Text(
            tagline!,
            style: AppTextStyles.tagline(
              context,
            ).copyWith(color: AppColors.black.withValues(alpha: 0.65)),
            textAlign: textAlign,
          ),
        ],
        if (description != null) ...[
          AppSpacing.vertical(context, 0.03),
          Text(
            description!,
            style: AppTextStyles.bodyText(context).copyWith(
              color: AppColors.black.withValues(alpha: 0.7),
              height: 1.6,
            ),
            textAlign: textAlign,
          ),
        ],
      ],
    );
  }
}
