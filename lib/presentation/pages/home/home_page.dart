import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/app_colors/app_colors.dart';
import '../../../core/utils/app_responsive/app_responsive.dart';
import '../../../core/utils/app_spacing/app_spacing.dart';
import '../../../core/utils/app_styles/app_text_styles.dart';
import '../../../core/utils/app_texts/app_texts.dart';
import '../../widgets/layout/app_header.dart';
import '../../widgets/common/app_button.dart';
import '../../controllers/home/home_controller.dart';
import '../../../core/constants/app_constants.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Hero Section with Primary Background
          Container(
            width: double.infinity,
            height: AppResponsive.screenHeight(context),
            decoration: const BoxDecoration(color: AppColors.primary),
            child: Stack(
              children: [
                // Optional: Add texture/pattern overlay for water-like effect
                Container(
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    // You can add a gradient or image here for texture
                  ),
                ),
                // Header (positioned absolutely)
                const Positioned(top: 0, left: 0, right: 0, child: AppHeader()),
                // Hero Content (responsive alignment)
                Positioned.fill(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final isSmallScreen = constraints.maxWidth < 600;
                      final headerHeight = AppResponsive.screenHeight(context) * 0.08;
                      
                      return SingleChildScrollView(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: constraints.maxHeight,
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: headerHeight,
                              left: isSmallScreen 
                                  ? AppResponsive.screenWidth(context) * 0.05
                                  : AppResponsive.screenWidth(context) * 0.1,
                              right: isSmallScreen 
                                  ? AppResponsive.screenWidth(context) * 0.05
                                  : AppResponsive.screenWidth(context) * 0.1,
                              bottom: AppResponsive.screenHeight(context) * 0.05,
                            ),
                            child: isSmallScreen
                                ? _buildSmallScreenContent(context)
                                : _buildLargeScreenContent(context),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSmallScreenContent(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Main Headline
        Text(
          AppTexts.homeHeroTitle,
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
          AppTexts.homeHeroSubtitle,
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
          onPressed: () => Get.toNamed(AppConstants.routeContact),
        ),
      ],
    );
  }

  Widget _buildLargeScreenContent(BuildContext context) {
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
              AppTexts.homeHeroTitle,
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
                AppTexts.homeHeroSubtitle,
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
                onPressed: () => Get.toNamed(AppConstants.routeContact),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
