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

class HomeOurApproachContentDesktop extends StatelessWidget {
  const HomeOurApproachContentDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return _OurApproachContent(
      onButtonPressed: () => Get.toNamed(ClientConstants.routeClientProperties),
    );
  }
}

class HomeOurApproachContentMobile extends StatelessWidget {
  const HomeOurApproachContentMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return _OurApproachContent(
      onButtonPressed: () => Get.toNamed(ClientConstants.routeClientProperties),
      fullWidthButton: true,
    );
  }
}

class _OurApproachContent extends StatelessWidget {
  final VoidCallback onButtonPressed;
  final bool fullWidthButton;

  const _OurApproachContent({
    required this.onButtonPressed,
    this.fullWidthButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          context.l10n.homeOurApproachTitle,
          style: AppTextStyles.bodyText(context).copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
            fontFamily: AppFonts.primaryFont,
            fontSize: AppResponsive.fontSizeClamped(context, min: 26, max: 30),
          ),
          textAlign: TextAlign.left,
        ),
        AppSpacing.vertical(context, 0.04),
        Text(
          context.l10n.homeOurApproachDescription,
          style: AppTextStyles.bodyText(context).copyWith(
            color: AppColors.black.withValues(alpha: 0.7),
            height: 1.6,
          ),
          textAlign: TextAlign.left,
        ),
        AppSpacing.vertical(context, 0.06),
        AppButton(
          text: context.l10n.homeOurApproachButton,
          backgroundColor: AppColors.primary,
          textColor: AppColors.white,
          width: fullWidthButton ? double.infinity : null,
          onPressed: onButtonPressed,
        ),
      ],
    );
  }
}
