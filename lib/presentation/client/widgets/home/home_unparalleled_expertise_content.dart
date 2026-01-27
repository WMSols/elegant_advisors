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

class HomeUnparalleledExpertiseContentDesktop extends StatelessWidget {
  const HomeUnparalleledExpertiseContentDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: AppResponsive.screenWidth(context) * 0.8,
          ),
          child: _ExpertiseHeader(),
        ),
        AppSpacing.vertical(context, 0.06),
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: AppResponsive.screenWidth(context) * 0.8,
          ),
          child: _ExpertiseCategoriesGrid(),
        ),
        AppSpacing.vertical(context, 0.06),
        _ExpertiseButton(),
      ],
    );
  }
}

class HomeUnparalleledExpertiseContentMobile extends StatelessWidget {
  const HomeUnparalleledExpertiseContentMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _ExpertiseHeader(),
        AppSpacing.vertical(context, 0.06),
        _ExpertiseCategoriesList(),
        AppSpacing.vertical(context, 0.06),
        _ExpertiseButton(fullWidth: true),
      ],
    );
  }
}

class _ExpertiseHeader extends StatelessWidget {
  const _ExpertiseHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          context.l10n.homeUnparalleledExpertiseTitle,
          style: AppTextStyles.bodyText(context).copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
            fontSize: AppResponsive.fontSizeClamped(context, min: 26, max: 30),
          ),
          textAlign: TextAlign.center,
        ),
        AppSpacing.vertical(context, 0.04),
        Text(
          context.l10n.homeUnparalleledExpertiseDescription,
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

class _ExpertiseCategoriesGrid extends StatelessWidget {
  const _ExpertiseCategoriesGrid();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // First Row
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: AppCategoryCard(
                title:
                    context.l10n.homeUnparalleledExpertisePropertySearchTitle,
                description: context
                    .l10n
                    .homeUnparalleledExpertisePropertySearchDescription,
              ),
            ),
            AppSpacing.horizontal(context, 0.03),
            Expanded(
              child: AppCategoryCard(
                title:
                    context.l10n.homeUnparalleledExpertisePurchaseStrategyTitle,
                description: context
                    .l10n
                    .homeUnparalleledExpertisePurchaseStrategyDescription,
              ),
            ),
            AppSpacing.horizontal(context, 0.03),
            Expanded(
              child: AppCategoryCard(
                title: context.l10n.homeUnparalleledExpertiseNegotiationTitle,
                description: context
                    .l10n
                    .homeUnparalleledExpertiseNegotiationDescription,
              ),
            ),
          ],
        ),
        AppSpacing.vertical(context, 0.04),
        // Second Row
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: AppCategoryCard(
                title: context
                    .l10n
                    .homeUnparalleledExpertisePortfolioManagementTitle,
                description: context
                    .l10n
                    .homeUnparalleledExpertisePortfolioManagementDescription,
              ),
            ),
            AppSpacing.horizontal(context, 0.03),
            Expanded(
              child: AppCategoryCard(
                title:
                    context.l10n.homeUnparalleledExpertiseVisaTaxAdvisoryTitle,
                description: context
                    .l10n
                    .homeUnparalleledExpertiseVisaTaxAdvisoryDescription,
              ),
            ),
            AppSpacing.horizontal(context, 0.03),
            Expanded(
              child: AppCategoryCard(
                title: context
                    .l10n
                    .homeUnparalleledExpertiseLuxuryRentalsManagementTitle,
                description: context
                    .l10n
                    .homeUnparalleledExpertiseLuxuryRentalsManagementDescription,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ExpertiseCategoriesList extends StatelessWidget {
  const _ExpertiseCategoriesList();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppCategoryCard(
          title: context.l10n.homeUnparalleledExpertisePropertySearchTitle,
          description:
              context.l10n.homeUnparalleledExpertisePropertySearchDescription,
        ),
        AppSpacing.vertical(context, 0.04),
        AppCategoryCard(
          title: context.l10n.homeUnparalleledExpertisePurchaseStrategyTitle,
          description:
              context.l10n.homeUnparalleledExpertisePurchaseStrategyDescription,
        ),
        AppSpacing.vertical(context, 0.04),
        AppCategoryCard(
          title: context.l10n.homeUnparalleledExpertiseNegotiationTitle,
          description:
              context.l10n.homeUnparalleledExpertiseNegotiationDescription,
        ),
        AppSpacing.vertical(context, 0.04),
        AppCategoryCard(
          title: context.l10n.homeUnparalleledExpertisePortfolioManagementTitle,
          description: context
              .l10n
              .homeUnparalleledExpertisePortfolioManagementDescription,
        ),
        AppSpacing.vertical(context, 0.04),
        AppCategoryCard(
          title: context.l10n.homeUnparalleledExpertiseVisaTaxAdvisoryTitle,
          description:
              context.l10n.homeUnparalleledExpertiseVisaTaxAdvisoryDescription,
        ),
        AppSpacing.vertical(context, 0.04),
        AppCategoryCard(
          title: context
              .l10n
              .homeUnparalleledExpertiseLuxuryRentalsManagementTitle,
          description: context
              .l10n
              .homeUnparalleledExpertiseLuxuryRentalsManagementDescription,
        ),
      ],
    );
  }
}

class _ExpertiseButton extends StatelessWidget {
  final bool fullWidth;

  const _ExpertiseButton({this.fullWidth = false});

  @override
  Widget build(BuildContext context) {
    return AppButton(
      text: context.l10n.homeUnparalleledExpertiseButton,
      backgroundColor: AppColors.primary,
      textColor: AppColors.white,
      width: fullWidth ? double.infinity : null,
      onPressed: () {
        Get.toNamed(ClientConstants.routeClientContact);
      },
    );
  }
}
