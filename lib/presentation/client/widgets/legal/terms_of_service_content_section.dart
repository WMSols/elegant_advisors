import 'package:elegant_advisors/core/utils/app_fonts/app_fonts.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_helpers/language/app_localizations_helper.dart';
import 'package:elegant_advisors/presentation/client/widgets/common/client_background_section.dart';
import 'package:elegant_advisors/presentation/client/widgets/common/client_content_container.dart';

class TermsOfServiceContentSection extends StatelessWidget {
  const TermsOfServiceContentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final locale = Localizations.localeOf(context);
    final currentDate = DateTime.now();
    final formattedDate = DateFormat.yMd(
      locale.toLanguageTag(),
    ).format(currentDate);

    return ClientBackgroundSection(
      horizontalPadding: 0.04,
      verticalPadding: 0.08,
      child: ClientContentContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppSpacing.vertical(context, 0.02),
            // Title
            Text(
              l10n.termsOfServiceTitle,
              style: AppTextStyles.headline(
                context,
              ).copyWith(fontWeight: FontWeight.bold, color: AppColors.white),
            ),
            // Last Updated
            Text(
              l10n.termsOfServiceLastUpdated(formattedDate),
              style: AppTextStyles.bodyText(context).copyWith(
                color: AppColors.white,
                fontSize: AppResponsive.fontSizeClamped(
                  context,
                  min: 10,
                  max: 12,
                ),
                fontWeight: FontWeight.normal,
                fontStyle: FontStyle.italic,
              ),
            ),
            AppSpacing.vertical(context, 0.04),
            // Introduction
            _buildSection(context, content: l10n.termsOfServiceIntroduction),
            AppSpacing.vertical(context, 0.04),
            // Section 1
            _buildSection(
              context,
              title: l10n.termsOfServiceSection1Title,
              content: l10n.termsOfServiceSection1Content,
            ),
            AppSpacing.vertical(context, 0.04),
            // Section 2
            _buildSection(
              context,
              title: l10n.termsOfServiceSection2Title,
              content: l10n.termsOfServiceSection2Content,
            ),
            AppSpacing.vertical(context, 0.04),
            // Section 3
            _buildSection(
              context,
              title: l10n.termsOfServiceSection3Title,
              content: l10n.termsOfServiceSection3Content,
            ),
            AppSpacing.vertical(context, 0.04),
            // Section 4
            _buildSection(
              context,
              title: l10n.termsOfServiceSection4Title,
              content: l10n.termsOfServiceSection4Content,
            ),
            AppSpacing.vertical(context, 0.04),
            // Section 5
            _buildSection(
              context,
              title: l10n.termsOfServiceSection5Title,
              content: l10n.termsOfServiceSection5Content,
            ),
            AppSpacing.vertical(context, 0.04),
            // Section 6
            _buildSection(
              context,
              title: l10n.termsOfServiceSection6Title,
              content: l10n.termsOfServiceSection6Content,
            ),
            AppSpacing.vertical(context, 0.04),
            // Section 7
            _buildSection(
              context,
              title: l10n.termsOfServiceSection7Title,
              content: l10n.termsOfServiceSection7Content,
            ),
            AppSpacing.vertical(context, 0.04),
            // Section 8
            _buildSection(
              context,
              title: l10n.termsOfServiceSection8Title,
              content: l10n.termsOfServiceSection8Content,
            ),
            AppSpacing.vertical(context, 0.04),
            // Section 9
            _buildSection(
              context,
              title: l10n.termsOfServiceSection9Title,
              content: l10n.termsOfServiceSection9Content,
            ),
            AppSpacing.vertical(context, 0.04),
            // Section 10
            _buildSection(
              context,
              title: l10n.termsOfServiceSection10Title,
              content: l10n.termsOfServiceSection10Content,
            ),
            AppSpacing.vertical(context, 0.04),
            // Section 11
            _buildSection(
              context,
              title: l10n.termsOfServiceSection11Title,
              content: l10n.termsOfServiceSection11Content,
            ),
            AppSpacing.vertical(context, 0.08),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    String? title,
    required String content,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ...[
          Text(
            title,
            style: AppTextStyles.bodyText(context).copyWith(
              fontWeight: FontWeight.bold,
              fontFamily: AppFonts.primaryFont,
              color: AppColors.white,
            ),
          ),
          AppSpacing.vertical(context, 0.01),
        ],
        Text(
          content,
          style: AppTextStyles.bodyText(
            context,
          ).copyWith(height: 1.6, color: AppColors.white),
        ),
      ],
    );
  }
}
