import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/client_constants.dart';
import '../../../../core/utils/app_colors/app_colors.dart';
import '../../../../core/utils/app_responsive/app_responsive.dart';
import '../../../../core/utils/app_spacing/app_spacing.dart';
import '../../../../core/utils/app_styles/app_text_styles.dart';
import '../../../../core/utils/app_texts/app_texts.dart';
import '../common/app_button.dart';
import '../common/app_category_card.dart';

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
          AppTexts.homeUnparalleledExpertiseTitle,
          style: AppTextStyles.bodyText(context).copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
            fontSize: AppResponsive.fontSizeClamped(context, min: 26, max: 30),
          ),
          textAlign: TextAlign.center,
        ),
        AppSpacing.vertical(context, 0.04),
        Text(
          AppTexts.homeUnparalleledExpertiseDescription,
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
                title: AppTexts.homeUnparalleledExpertisePropertySearchTitle,
                description: AppTexts.homeUnparalleledExpertisePropertySearchDescription,
              ),
            ),
            AppSpacing.horizontal(context, 0.03),
            Expanded(
              child: AppCategoryCard(
                title: AppTexts.homeUnparalleledExpertisePurchaseStrategyTitle,
                description: AppTexts.homeUnparalleledExpertisePurchaseStrategyDescription,
              ),
            ),
            AppSpacing.horizontal(context, 0.03),
            Expanded(
              child: AppCategoryCard(
                title: AppTexts.homeUnparalleledExpertiseNegotiationTitle,
                description: AppTexts.homeUnparalleledExpertiseNegotiationDescription,
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
                title: AppTexts.homeUnparalleledExpertisePortfolioManagementTitle,
                description: AppTexts.homeUnparalleledExpertisePortfolioManagementDescription,
              ),
            ),
            AppSpacing.horizontal(context, 0.03),
            Expanded(
              child: AppCategoryCard(
                title: AppTexts.homeUnparalleledExpertiseVisaTaxAdvisoryTitle,
                description: AppTexts.homeUnparalleledExpertiseVisaTaxAdvisoryDescription,
              ),
            ),
            AppSpacing.horizontal(context, 0.03),
            Expanded(
              child: AppCategoryCard(
                title: AppTexts.homeUnparalleledExpertiseLuxuryRentalsManagementTitle,
                description: AppTexts.homeUnparalleledExpertiseLuxuryRentalsManagementDescription,
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
          title: AppTexts.homeUnparalleledExpertisePropertySearchTitle,
          description: AppTexts.homeUnparalleledExpertisePropertySearchDescription,
        ),
        AppSpacing.vertical(context, 0.04),
        AppCategoryCard(
          title: AppTexts.homeUnparalleledExpertisePurchaseStrategyTitle,
          description: AppTexts.homeUnparalleledExpertisePurchaseStrategyDescription,
        ),
        AppSpacing.vertical(context, 0.04),
        AppCategoryCard(
          title: AppTexts.homeUnparalleledExpertiseNegotiationTitle,
          description: AppTexts.homeUnparalleledExpertiseNegotiationDescription,
        ),
        AppSpacing.vertical(context, 0.04),
        AppCategoryCard(
          title: AppTexts.homeUnparalleledExpertisePortfolioManagementTitle,
          description: AppTexts.homeUnparalleledExpertisePortfolioManagementDescription,
        ),
        AppSpacing.vertical(context, 0.04),
        AppCategoryCard(
          title: AppTexts.homeUnparalleledExpertiseVisaTaxAdvisoryTitle,
          description: AppTexts.homeUnparalleledExpertiseVisaTaxAdvisoryDescription,
        ),
        AppSpacing.vertical(context, 0.04),
        AppCategoryCard(
          title: AppTexts.homeUnparalleledExpertiseLuxuryRentalsManagementTitle,
          description: AppTexts.homeUnparalleledExpertiseLuxuryRentalsManagementDescription,
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
      text: AppTexts.homeUnparalleledExpertiseButton,
      backgroundColor: AppColors.primary,
      textColor: AppColors.white,
      width: fullWidth ? double.infinity : null,
      onPressed: () {
        Get.toNamed(ClientConstants.routeOurTeam);
      },
    );
  }
}

