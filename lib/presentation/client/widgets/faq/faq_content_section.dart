import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_fonts/app_fonts.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';
import 'package:elegant_advisors/core/utils/app_helpers/language/app_localizations_helper.dart';
import 'package:elegant_advisors/presentation/client/widgets/common/client_background_section.dart';
import 'package:elegant_advisors/presentation/client/widgets/common/client_content_container.dart';

class FaqContentSection extends StatelessWidget {
  const FaqContentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return ClientBackgroundSection(
      horizontalPadding: 0.04,
      verticalPadding: 0.08,
      child: ClientContentContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppSpacing.vertical(context, 0.02),
            Text(
              l10n.faqPageTitle,
              style: AppTextStyles.headline(context).copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.white,
                fontFamily: AppFonts.primaryFont,
              ),
            ),
            AppSpacing.vertical(context, 0.06),
            _FaqAccordion(),
          ],
        ),
      ),
    );
  }
}

class _FaqAccordion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final items = [
      (l10n.faq1Question, l10n.faq1Answer),
      (l10n.faq2Question, l10n.faq2Answer),
      (l10n.faq3Question, l10n.faq3Answer),
      (l10n.faq4Question, l10n.faq4Answer),
      (l10n.faq5Question, l10n.faq5Answer),
      (l10n.faq6Question, l10n.faq6Answer),
      (l10n.faq7Question, l10n.faq7Answer),
      (l10n.faq8Question, l10n.faq8Answer),
      (l10n.faq9Question, l10n.faq9Answer),
      (l10n.faq10Question, l10n.faq10Answer),
      (l10n.faq11Question, l10n.faq11Answer),
    ];
    return Column(
      children: [
        for (int i = 0; i < items.length; i++) ...[
          _FaqExpansionTile(question: items[i].$1, answer: items[i].$2),
          if (i < items.length - 1) AppSpacing.vertical(context, 0.01),
        ],
      ],
    );
  }
}

class _FaqExpansionTile extends StatelessWidget {
  final String question;
  final String answer;

  const _FaqExpansionTile({required this.question, required this.answer});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.6),
        border: Border.all(color: AppColors.white.withValues(alpha: 0.15)),
      ),
      child: ExpansionTile(
        initiallyExpanded: false,
        shape: const Border(),
        collapsedShape: const Border(),
        tilePadding: AppSpacing.symmetric(context, h: 0.02, v: 0.01),
        childrenPadding: AppSpacing.symmetric(context, h: 0.02, v: 0.01),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: 2,
                right: AppResponsive.scaleSize(context, 10, min: 8, max: 12),
              ),
              child: Icon(
                Iconsax.quote_down_circle,
                color: AppColors.white.withValues(alpha: 0.9),
                size: AppResponsive.scaleSize(context, 20, min: 18, max: 22),
              ),
            ),
            Expanded(
              child: Text(
                question,
                style: AppTextStyles.bodyText(context).copyWith(
                  fontWeight: FontWeight.w600,
                  fontFamily: AppFonts.primaryFont,
                  color: AppColors.white,
                  fontSize: AppResponsive.fontSizeClamped(
                    context,
                    min: 14,
                    max: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        collapsedBackgroundColor: Colors.transparent,
        iconColor: AppColors.white,
        collapsedIconColor: AppColors.white,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              answer,
              style: AppTextStyles.bodyText(context).copyWith(
                height: 1.6,
                color: AppColors.white.withValues(alpha: 0.95),
                fontSize: AppResponsive.fontSizeClamped(
                  context,
                  min: 13,
                  max: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
