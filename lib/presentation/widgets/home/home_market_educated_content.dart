import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/utils/app_colors/app_colors.dart';
import '../../../core/utils/app_images/app_images.dart';
import '../../../core/utils/app_responsive/app_responsive.dart';
import '../../../core/utils/app_spacing/app_spacing.dart';
import '../../../core/utils/app_styles/app_text_styles.dart';
import '../../../core/utils/app_texts/app_texts.dart';
import '../common/app_button.dart';

class HomeMarketEducatedContentDesktop extends StatelessWidget {
  const HomeMarketEducatedContentDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Image on the left (60% width)
        Expanded(
          flex: 6,
          child: Container(
            height: AppResponsive.screenHeight(context) * 0.6,
            decoration: BoxDecoration(color: AppColors.grey.withOpacity(0.1)),
            child: ClipRRect(
              child: Image.asset(
                AppImages.homeMarketEducated,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    decoration: BoxDecoration(
                      color: AppColors.grey.withOpacity(0.1),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.image,
                        size: 80,
                        color: AppColors.grey.withOpacity(0.5),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        AppSpacing.horizontal(context, 0.04),
        // Text content on the right (40% width)
        Expanded(
          flex: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Heading
              Text(
                AppTexts.homeMarketEducatedTitle,
                style: AppTextStyles.headline(context).copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                  height: 1.2,
                ),
                textAlign: TextAlign.left,
              ),
              AppSpacing.vertical(context, 0.04),
              // Description
              Text(
                AppTexts.homeMarketEducatedDescription,
                style: AppTextStyles.bodyText(context).copyWith(
                  color: AppColors.black.withOpacity(0.7),
                  height: 1.6,
                  fontSize: AppResponsive.scaleSize(
                    context,
                    16,
                    min: 14,
                    max: 18,
                  ),
                ),
                textAlign: TextAlign.left,
              ),
              AppSpacing.vertical(context, 0.06),
              // Button
              AppButton(
                text: AppTexts.homeMarketEducatedButton,
                backgroundColor: AppColors.primary,
                textColor: AppColors.white,
                onPressed: () => Get.toNamed(AppConstants.routeWhatWeDo),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class HomeMarketEducatedContentMobile extends StatelessWidget {
  const HomeMarketEducatedContentMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Image on top
        Container(
          width: double.infinity,
          height: AppResponsive.screenHeight(context) * 0.4,
          decoration: BoxDecoration(color: AppColors.grey.withOpacity(0.1)),
          child: ClipRRect(
            child: Image.asset(
              AppImages.homeMarketEducated,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  decoration: BoxDecoration(
                    color: AppColors.grey.withOpacity(0.1),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.image,
                      size: 60,
                      color: AppColors.grey.withOpacity(0.5),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        AppSpacing.vertical(context, 0.04),
        // Heading
        Text(
          AppTexts.homeMarketEducatedTitle,
          style: AppTextStyles.headline(context).copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
            height: 1.2,
          ),
          textAlign: TextAlign.left,
        ),
        AppSpacing.vertical(context, 0.04),
        // Description
        Text(
          AppTexts.homeMarketEducatedDescription,
          style: AppTextStyles.bodyText(context).copyWith(
            color: AppColors.black.withOpacity(0.7),
            height: 1.6,
            fontSize: AppResponsive.scaleSize(context, 14, min: 12, max: 16),
          ),
          textAlign: TextAlign.left,
        ),
        AppSpacing.vertical(context, 0.06),
        // Button
        AppButton(
          text: AppTexts.homeMarketEducatedButton,
          backgroundColor: AppColors.primary,
          textColor: AppColors.white,
          width: double.infinity,
          onPressed: () => Get.toNamed(AppConstants.routeWhatWeDo),
        ),
      ],
    );
  }
}
