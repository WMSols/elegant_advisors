import 'package:flutter/material.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';
import 'package:elegant_advisors/core/utils/app_helpers/language/app_localizations_helper.dart';
import 'package:elegant_advisors/core/widgets/buttons/app_button.dart';
import 'package:elegant_advisors/core/widgets/display/app_category_card.dart';

class HomeOurDiscerningClienteleContentDesktop extends StatelessWidget {
  const HomeOurDiscerningClienteleContentDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: AppResponsive.screenWidth(context) * 0.45,
          ),
          child: _ClienteleHeader(),
        ),
        AppSpacing.vertical(context, 0.06),
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: AppResponsive.screenWidth(context) * 0.45,
          ),
          child: _ClienteleCategoriesGrid(),
        ),
        AppSpacing.vertical(context, 0.06),
        _ClienteleButton(),
      ],
    );
  }
}

class HomeOurDiscerningClienteleContentMobile extends StatelessWidget {
  const HomeOurDiscerningClienteleContentMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ClienteleHeader(),
        AppSpacing.vertical(context, 0.06),
        _ClienteleCategoriesList(),
        AppSpacing.vertical(context, 0.06),
        _ClienteleButton(fullWidth: true),
      ],
    );
  }
}

class _ClienteleHeader extends StatelessWidget {
  const _ClienteleHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          context.l10n.homeOurDiscerningClienteleTitle,
          style: AppTextStyles.bodyText(context).copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
            fontSize: AppResponsive.fontSizeClamped(context, min: 26, max: 30),
          ),
          textAlign: TextAlign.center,
        ),
        AppSpacing.vertical(context, 0.04),
        Text(
          context.l10n.homeOurDiscerningClienteleDescription,
          style: AppTextStyles.bodyText(context).copyWith(
            color: AppColors.black.withValues(alpha: 0.7),
            height: 1.6,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _ClienteleCategoriesGrid extends StatelessWidget {
  const _ClienteleCategoriesGrid();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: AppCategoryCard(
                title: context
                    .l10n
                    .homeOurDiscerningClientelePropertyInvestorsTitle,
                description: context
                    .l10n
                    .homeOurDiscerningClientelePropertyInvestorsDescription,
              ),
            ),
            AppSpacing.horizontal(context, 0.03),
            Expanded(
              child: AppCategoryCard(
                title: context
                    .l10n
                    .homeOurDiscerningClienteleCitizenshipClientsTitle,
                description: context
                    .l10n
                    .homeOurDiscerningClienteleCitizenshipClientsDescription,
              ),
            ),
          ],
        ),
        AppSpacing.vertical(context, 0.04),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: AppCategoryCard(
                title: context
                    .l10n
                    .homeOurDiscerningClienteleLifestyleHomeBuyersTitle,
                description: context
                    .l10n
                    .homeOurDiscerningClienteleLifestyleHomeBuyersDescription,
              ),
            ),
            AppSpacing.horizontal(context, 0.03),
            Expanded(
              child: AppCategoryCard(
                title: context
                    .l10n
                    .homeOurDiscerningClienteleLuxuryPropertyOwnersTitle,
                description: context
                    .l10n
                    .homeOurDiscerningClienteleLuxuryPropertyOwnersDescription,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ClienteleCategoriesList extends StatelessWidget {
  const _ClienteleCategoriesList();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppCategoryCard(
          title: context.l10n.homeOurDiscerningClientelePropertyInvestorsTitle,
          description: context
              .l10n
              .homeOurDiscerningClientelePropertyInvestorsDescription,
        ),
        AppSpacing.vertical(context, 0.04),
        AppCategoryCard(
          title: context.l10n.homeOurDiscerningClienteleCitizenshipClientsTitle,
          description: context
              .l10n
              .homeOurDiscerningClienteleCitizenshipClientsDescription,
        ),
        AppSpacing.vertical(context, 0.04),
        AppCategoryCard(
          title:
              context.l10n.homeOurDiscerningClienteleLifestyleHomeBuyersTitle,
          description: context
              .l10n
              .homeOurDiscerningClienteleLifestyleHomeBuyersDescription,
        ),
        AppSpacing.vertical(context, 0.04),
        AppCategoryCard(
          title:
              context.l10n.homeOurDiscerningClienteleLuxuryPropertyOwnersTitle,
          description: context
              .l10n
              .homeOurDiscerningClienteleLuxuryPropertyOwnersDescription,
        ),
      ],
    );
  }
}

class _ClienteleButton extends StatelessWidget {
  final bool fullWidth;

  const _ClienteleButton({this.fullWidth = false});

  @override
  Widget build(BuildContext context) {
    return AppButton(
      text: context.l10n.homeOurDiscerningClienteleButton,
      backgroundColor: AppColors.primary,
      textColor: AppColors.white,
      width: fullWidth ? double.infinity : null,
      onPressed: () {
        // TODO: Add navigation when testimonials page is available
      },
    );
  }
}
