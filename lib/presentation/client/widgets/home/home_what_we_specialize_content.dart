import 'package:elegant_advisors/core/utils/app_fonts/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:elegant_advisors/core/constants/client_constants.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';
import 'package:elegant_advisors/core/utils/app_helpers/language/app_localizations_helper.dart';
import 'package:elegant_advisors/core/widgets/buttons/app_button.dart';
import 'package:elegant_advisors/core/widgets/display/app_category_card.dart';

class HomeWhatWeSpecializeContentDesktop extends StatelessWidget {
  const HomeWhatWeSpecializeContentDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: AppResponsive.screenWidth(context) * 0.8,
          ),
          child: _SpecializationHeader(),
        ),
        AppSpacing.vertical(context, 0.06),
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: AppResponsive.screenWidth(context) * 0.8,
          ),
          child: _SpecializationCategoriesGrid(),
        ),
        AppSpacing.vertical(context, 0.06),
        _SpecializationButton(),
      ],
    );
  }
}

class HomeWhatWeSpecializeContentMobile extends StatelessWidget {
  const HomeWhatWeSpecializeContentMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _SpecializationHeader(),
        AppSpacing.vertical(context, 0.06),
        _SpecializationCategoriesList(),
        AppSpacing.vertical(context, 0.06),
        _SpecializationButton(fullWidth: true),
      ],
    );
  }
}

class _SpecializationHeader extends StatelessWidget {
  const _SpecializationHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          context.l10n.homeWhatWeSpecializeInTitle,
          style: AppTextStyles.bodyText(context).copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
            fontFamily: AppFonts.primaryFont,
            fontSize: AppResponsive.fontSizeClamped(context, min: 26, max: 30),
          ),
          textAlign: TextAlign.center,
        ),
        AppSpacing.vertical(context, 0.04),
        Text(
          context.l10n.homeWhatWeSpecializeInDescription,
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

class _SpecializationCategoriesGrid extends StatelessWidget {
  const _SpecializationCategoriesGrid();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // First Row - 2 cards
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: AppCategoryCard(
                title:
                    context.l10n.homeWhatWeSpecializeInHighEndResidentialTitle,
                description: context
                    .l10n
                    .homeWhatWeSpecializeInHighEndResidentialDescription,
              ),
            ),
            AppSpacing.horizontal(context, 0.03),
            Expanded(
              child: AppCategoryCard(
                title: context.l10n.homeWhatWeSpecializeInInvestmentPlotsTitle,
                description: context
                    .l10n
                    .homeWhatWeSpecializeInInvestmentPlotsDescription,
              ),
            ),
          ],
        ),
        AppSpacing.vertical(context, 0.04),
        // Second Row - 2 cards
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: AppCategoryCard(
                title:
                    context.l10n.homeWhatWeSpecializeInInvestmentBuildingsTitle,
                description: context
                    .l10n
                    .homeWhatWeSpecializeInInvestmentBuildingsDescription,
              ),
            ),
            AppSpacing.horizontal(context, 0.03),
            Expanded(
              child: AppCategoryCard(
                title: context
                    .l10n
                    .homeWhatWeSpecializeInCommercialRealEstateTitle,
                description: context
                    .l10n
                    .homeWhatWeSpecializeInCommercialRealEstateDescription,
              ),
            ),
          ],
        ),
        AppSpacing.vertical(context, 0.04),
        // Third Row - 1 card (centered)
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 2, child: Container()),
            Expanded(
              flex: 2,
              child: AppCategoryCard(
                title: context.l10n.homeWhatWeSpecializeInHospitalityTitle,
                description:
                    context.l10n.homeWhatWeSpecializeInHospitalityDescription,
              ),
            ),
            Expanded(flex: 2, child: Container()),
          ],
        ),
      ],
    );
  }
}

class _SpecializationCategoriesList extends StatelessWidget {
  const _SpecializationCategoriesList();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppCategoryCard(
          title: context.l10n.homeWhatWeSpecializeInHighEndResidentialTitle,
          description:
              context.l10n.homeWhatWeSpecializeInHighEndResidentialDescription,
        ),
        AppSpacing.vertical(context, 0.04),
        AppCategoryCard(
          title: context.l10n.homeWhatWeSpecializeInInvestmentPlotsTitle,
          description:
              context.l10n.homeWhatWeSpecializeInInvestmentPlotsDescription,
        ),
        AppSpacing.vertical(context, 0.04),
        AppCategoryCard(
          title: context.l10n.homeWhatWeSpecializeInInvestmentBuildingsTitle,
          description:
              context.l10n.homeWhatWeSpecializeInInvestmentBuildingsDescription,
        ),
        AppSpacing.vertical(context, 0.04),
        AppCategoryCard(
          title: context.l10n.homeWhatWeSpecializeInCommercialRealEstateTitle,
          description: context
              .l10n
              .homeWhatWeSpecializeInCommercialRealEstateDescription,
        ),
        AppSpacing.vertical(context, 0.04),
        AppCategoryCard(
          title: context.l10n.homeWhatWeSpecializeInHospitalityTitle,
          description:
              context.l10n.homeWhatWeSpecializeInHospitalityDescription,
        ),
      ],
    );
  }
}

class _SpecializationButton extends StatelessWidget {
  final bool fullWidth;

  const _SpecializationButton({this.fullWidth = false});

  @override
  Widget build(BuildContext context) {
    return AppButton(
      text: context.l10n.homeWhatWeSpecializeInButton,
      backgroundColor: AppColors.primary,
      textColor: AppColors.white,
      width: fullWidth ? double.infinity : null,
      onPressed: () {
        Get.toNamed(ClientConstants.routeClientContact);
      },
    );
  }
}
