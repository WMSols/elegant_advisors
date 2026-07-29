import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:elegant_advisors/core/constants/client_constants.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/core/utils/app_helpers/language/app_localizations_helper.dart';
import 'package:elegant_advisors/core/widgets/buttons/app_button.dart';
import 'package:elegant_advisors/core/widgets/display/app_category_card.dart';
import 'package:elegant_advisors/presentation/client/widgets/common/client_section_header.dart';

class HomeOurPhilosophyMissionContentDesktop extends StatelessWidget {
  const HomeOurPhilosophyMissionContentDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: AppResponsive.screenWidth(context) * 0.8,
          ),
          child: _PhilosophyMissionHeader(),
        ),
        AppSpacing.vertical(context, 0.06),
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: AppResponsive.screenWidth(context) * 0.8,
          ),
          child: _PhilosophyMissionCategoriesGrid(),
        ),
        AppSpacing.vertical(context, 0.06),
        _PhilosophyMissionButton(),
      ],
    );
  }
}

class HomeOurPhilosophyMissionContentMobile extends StatelessWidget {
  const HomeOurPhilosophyMissionContentMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _PhilosophyMissionHeader(),
        AppSpacing.vertical(context, 0.06),
        _PhilosophyMissionCategoriesList(),
        AppSpacing.vertical(context, 0.06),
        _PhilosophyMissionButton(fullWidth: true),
      ],
    );
  }
}

class _PhilosophyMissionHeader extends StatelessWidget {
  const _PhilosophyMissionHeader();

  @override
  Widget build(BuildContext context) {
    return ClientSectionHeader(
      title: context.l10n.homeOurPhilosophyMissionTitle,
      description: context.l10n.homeOurPhilosophyMissionDescription,
      titleColor: AppColors.primary,
      descriptionColor: AppColors.black.withValues(alpha: 0.7),
    );
  }
}

class _PhilosophyMissionCategoriesGrid extends StatelessWidget {
  const _PhilosophyMissionCategoriesGrid();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: AppCategoryCard(
            title: context.l10n.homeOurPhilosophyTitle,
            description: context.l10n.homeOurPhilosophyDescription,
            centerAligned: true,
          ),
        ),
        AppSpacing.horizontal(context, 0.03),
        Expanded(
          child: AppCategoryCard(
            title: context.l10n.homeOurMissionTitle,
            description: context.l10n.homeOurMissionDescription,
            centerAligned: true,
          ),
        ),
      ],
    );
  }
}

class _PhilosophyMissionCategoriesList extends StatelessWidget {
  const _PhilosophyMissionCategoriesList();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppCategoryCard(
          title: context.l10n.homeOurPhilosophyTitle,
          description: context.l10n.homeOurPhilosophyDescription,
          centerAligned: true,
        ),
        AppSpacing.vertical(context, 0.04),
        AppCategoryCard(
          title: context.l10n.homeOurMissionTitle,
          description: context.l10n.homeOurMissionDescription,
          centerAligned: true,
        ),
      ],
    );
  }
}

class _PhilosophyMissionButton extends StatelessWidget {
  final bool fullWidth;

  const _PhilosophyMissionButton({this.fullWidth = false});

  @override
  Widget build(BuildContext context) {
    return AppButton(
      text: context.l10n.contactTitle,
      backgroundColor: AppColors.primary,
      textColor: AppColors.white,
      width: fullWidth ? double.infinity : null,
      onPressed: () {
        Get.toNamed(ClientConstants.routeClientContact);
      },
    );
  }
}
