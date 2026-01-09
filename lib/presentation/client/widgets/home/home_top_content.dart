import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:elegant_advisors/core/constants/client_constants.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';
import 'package:elegant_advisors/core/utils/app_texts/app_texts.dart';
import 'package:elegant_advisors/core/widgets/app_button.dart';

class HomeTopContentSmall extends StatelessWidget {
  const HomeTopContentSmall({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Main Headline
        Text(
          AppTexts.homeTitle,
          style: AppTextStyles.headline(context).copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.w300,
            letterSpacing: 2,
          ),
          textAlign: TextAlign.left,
        ),
        AppSpacing.vertical(context, 0.04),
        // Subtitle
        Text(
          AppTexts.homeSubtitle,
          style: AppTextStyles.bodyText(context).copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.w300,
            height: 1.6,
          ),
          textAlign: TextAlign.left,
        ),
        AppSpacing.vertical(context, 0.06),
        // CTA Button
        AppButton(
          text: AppTexts.homeButtonConsultation,
          backgroundColor: AppColors.lightGrey,
          textColor: AppColors.black,
          width: AppResponsive.screenWidth(context) * 0.9,
          onPressed: () => Get.toNamed(ClientConstants.routeClientContact),
        ),
      ],
    );
  }
}

class HomeTopContentLarge extends StatelessWidget {
  const HomeTopContentLarge({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: AppResponsive.screenWidth(context) * 0.9,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Main Headline
            Text(
              AppTexts.homeTitle,
              style: AppTextStyles.headline(context).copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.w300,
                letterSpacing: 2,
              ),
              textAlign: TextAlign.center,
            ),
            AppSpacing.vertical(context, 0.04),
            // Subtitle
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: AppResponsive.screenWidth(context) * 0.5,
              ),
              child: Text(
                AppTexts.homeSubtitle,
                style: AppTextStyles.bodyText(context).copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.w300,
                  height: 1.6,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            AppSpacing.vertical(context, 0.06),
            // CTA Button
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: AppResponsive.screenWidth(context) * 0.2,
              ),
              child: AppButton(
                text: AppTexts.homeButtonConsultation,
                backgroundColor: AppColors.lightGrey,
                textColor: AppColors.black,
                onPressed: () =>
                    Get.toNamed(ClientConstants.routeClientContact),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
