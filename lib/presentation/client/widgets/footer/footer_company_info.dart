import 'package:flutter/material.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';
import 'package:elegant_advisors/core/utils/app_helpers/language/app_localizations_helper.dart';
import 'package:elegant_advisors/core/widgets/text/app_text.dart';

class FooterCompanyInfo extends StatelessWidget {
  const FooterCompanyInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Elegant Real Estate",
          style: AppTextStyles.displayLabel(context).copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.w600,
            fontSize: AppResponsive.fontSizeClamped(context, min: 20, max: 24),
          ),
        ),
        AppSpacing.vertical(context, 0.01),
        AppText(
          context.l10n.footerTagline,
          style: AppTextStyles.bodyText(context).copyWith(
            color: AppColors.white.withValues(alpha: 0.9),
            fontSize: AppResponsive.fontSizeClamped(context, min: 12, max: 14),
          ),
        ),
        AppSpacing.vertical(context, 0.015),
        AppText(
          context.l10n.footerCompanyDescription,
          style: AppTextStyles.bodyText(context).copyWith(
            color: AppColors.white.withValues(alpha: 0.7),
            fontSize: AppResponsive.fontSizeClamped(context, min: 11, max: 13),
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
