import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/utils/app_colors/app_colors.dart';
import '../../../core/utils/app_images/app_images.dart';
import '../../../core/utils/app_responsive/app_responsive.dart';
import '../../../core/utils/app_spacing/app_spacing.dart';
import '../../../core/utils/app_styles/app_text_styles.dart';
import '../../../core/utils/app_texts/app_texts.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final showNav = constraints.maxWidth >= 600;

        return Container(
          padding: AppSpacing.symmetric(context, h: 0.04, v: 0.02),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.95),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Logo
              GestureDetector(
                onTap: () => Get.toNamed(AppConstants.routeHome),
                child: Image.asset(
                  AppImages.webLogo,
                  height: AppResponsive.scaleSize(context, 30, min: 24, max: 40),
                  width: AppResponsive.scaleSize(context, 30, min: 24, max: 40),
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Text(
                      AppTexts.webName,
                      style: AppTextStyles.bodyText(context).copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.w300,
                        letterSpacing: 2,
                      ),
                    );
                  },
                ),
              ),

              // Navigation Menu - automatically hides on small screens
              if (showNav)
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _NavItem(
                          label: AppTexts.navWhatWeDo,
                          route: AppConstants.routeWhatWeDo,
                        ),
                        _NavItem(
                          label: AppTexts.navHowWeDoIt,
                          route: AppConstants.routeHowWeDoIt,
                        ),
                        _NavItem(
                          label: AppTexts.navWhyElegant,
                          route: AppConstants.routeWhyElegant,
                        ),
                        _NavItem(
                          label: AppTexts.navServices,
                          route: AppConstants.routeServices,
                        ),
                        _NavItem(
                          label: AppTexts.navProperties,
                          route: AppConstants.routeProperties,
                        ),
                        _NavItem(
                          label: AppTexts.navInsights,
                          route: AppConstants.routeInsights,
                        ),
                        _NavItem(
                          label: AppTexts.navGoldenVisa,
                          route: AppConstants.routeGoldenVisa,
                        ),
                        _NavItem(
                          label: AppTexts.navContact,
                          route: AppConstants.routeContact,
                        ),
                      ],
                    ),
                  ),
                ),

              // Language Selector & Mobile Menu
              Row(
                children: [
                  // Language Selector - automatically hides on small screens
                  if (showNav)
                    IconButton(
                      icon: Icon(
                        Icons.language,
                        color: AppColors.white,
                        size: AppResponsive.scaleSize(context, 20, min: 18, max: 24),
                      ),
                      onPressed: () {
                        // TODO: Implement language selector
                      },
                    ),
                  // Mobile Menu Button - automatically shows on small screens
                  if (!showNav)
                    IconButton(
                      icon: Icon(
                        Icons.menu,
                        color: AppColors.white,
                        size: AppResponsive.scaleSize(context, 24, min: 24, max: 28),
                      ),
                      onPressed: () {
                        // TODO: Implement mobile drawer
                      },
                    ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _NavItem extends StatelessWidget {
  final String label;
  final String route;

  const _NavItem({
    required this.label,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    final currentRoute = Get.currentRoute;
    final isActive = currentRoute == route;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppResponsive.scaleSize(context, 8, min: 4, max: 12),
      ),
      child: TextButton(
        onPressed: () => Get.toNamed(route),
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(
            horizontal: AppResponsive.scaleSize(context, 10, min: 6, max: 16),
            vertical: AppResponsive.screenHeight(context) * 0.01,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: AppTextStyles.bodyText(context).copyWith(
                color: AppColors.white,
                letterSpacing: 0.5,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            if (isActive)
              Container(
                margin: EdgeInsets.only(
                  top: AppResponsive.scaleSize(context, 4, min: 4, max: 6),
                ),
                height: 1,
                width: AppResponsive.scaleSize(context, 20, min: 15, max: 25),
                color: AppColors.white,
              ),
          ],
        ),
      ),
    );
  }
}
