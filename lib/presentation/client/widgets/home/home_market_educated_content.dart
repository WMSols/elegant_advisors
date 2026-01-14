import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:elegant_advisors/core/constants/client_constants.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_images/app_images.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';
import 'package:elegant_advisors/core/utils/app_texts/app_texts.dart';
import 'package:elegant_advisors/core/widgets/buttons/app_button.dart';
import 'package:elegant_advisors/core/widgets/images/app_error_image_fallback.dart';

class HomeMarketEducatedContentDesktop extends StatelessWidget {
  const HomeMarketEducatedContentDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 6,
          child: _MarketEducatedImage(
            height: AppResponsive.screenHeight(context) * 0.6,
            iconSize: 80,
          ),
        ),
        AppSpacing.horizontal(context, 0.04),
        Expanded(
          flex: 4,
          child: _MarketEducatedContent(
            onButtonPressed: () =>
                Get.toNamed(ClientConstants.routeClientProperties),
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
        _MarketEducatedImage(
          height: AppResponsive.screenHeight(context) * 0.4,
          iconSize: 60,
        ),
        AppSpacing.vertical(context, 0.04),
        _MarketEducatedContent(
          onButtonPressed: () =>
              Get.toNamed(ClientConstants.routeClientProperties),
          fullWidthButton: true,
        ),
      ],
    );
  }
}

class _MarketEducatedImage extends StatelessWidget {
  final double height;
  final double iconSize;

  const _MarketEducatedImage({required this.height, required this.iconSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(color: AppColors.grey.withValues(alpha: 0.1)),
      child: ClipRRect(
        child: Image.asset(
          AppImages.homeMarketEducated,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return AppErrorImageFallback(iconSize: iconSize);
          },
        ),
      ),
    );
  }
}

class _MarketEducatedContent extends StatelessWidget {
  final VoidCallback onButtonPressed;
  final bool fullWidthButton;

  const _MarketEducatedContent({
    required this.onButtonPressed,
    this.fullWidthButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppTexts.homeMarketEducatedTitle,
          style: AppTextStyles.bodyText(context).copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
            fontSize: AppResponsive.fontSizeClamped(context, min: 26, max: 30),
          ),
          textAlign: TextAlign.left,
        ),
        AppSpacing.vertical(context, 0.04),
        Text(
          AppTexts.homeMarketEducatedDescription,
          style: AppTextStyles.bodyText(context).copyWith(
            color: AppColors.black.withValues(alpha: 0.7),
            height: 1.6,
          ),
          textAlign: TextAlign.left,
        ),
        AppSpacing.vertical(context, 0.06),
        AppButton(
          text: AppTexts.homeMarketEducatedButton,
          backgroundColor: AppColors.primary,
          textColor: AppColors.white,
          width: fullWidthButton ? double.infinity : null,
          onPressed: onButtonPressed,
        ),
      ],
    );
  }
}
