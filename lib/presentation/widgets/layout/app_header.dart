import 'package:flutter/material.dart';
import '../../../core/utils/app_colors/app_colors.dart';
import '../../../core/utils/app_images/app_images.dart';
import '../../../core/utils/app_spacing/app_spacing.dart';
import '../../../core/utils/app_texts/app_texts.dart';
import '../../widgets/app_header/header_language_selector.dart';
import '../../widgets/app_header/header_logo.dart';
import '../../widgets/app_header/header_mobile_menu.dart';
import '../../widgets/app_header/header_nav_item.dart';
import '../../../core/constants/app_constants.dart';

class AppHeader extends StatefulWidget {
  final bool showBackground;
  
  const AppHeader({super.key, this.showBackground = false});

  @override
  State<AppHeader> createState() => _AppHeaderState();
}

class _AppHeaderState extends State<AppHeader> {
  String _selectedLanguage = AppImages.englandFlag;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final showNav = constraints.maxWidth >= 600;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          padding: AppSpacing.symmetric(context, h: 0.04, v: 0.02),
          decoration: BoxDecoration(
            color: widget.showBackground 
                ? AppColors.primary.withValues(alpha: 0.95)
                : Colors.transparent,
          ),
          child: Stack(
            children: [
              // Navigation Menu - centered in the screen
              if (showNav)
                Center(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        HeaderNavItem(
                          label: AppTexts.navWhatWeDo,
                          route: AppConstants.routeWhatWeDo,
                        ),
                        HeaderNavItem(
                          label: AppTexts.navHowWeDoIt,
                          route: AppConstants.routeHowWeDoIt,
                        ),
                        HeaderNavItem(
                          label: AppTexts.navWhyElegant,
                          route: AppConstants.routeWhyElegant,
                        ),
                        HeaderNavItem(
                          label: AppTexts.navServices,
                          route: AppConstants.routeServices,
                        ),
                        HeaderNavItem(
                          label: AppTexts.navProperties,
                          route: AppConstants.routeProperties,
                        ),
                        HeaderNavItem(
                          label: AppTexts.navInsights,
                          route: AppConstants.routeInsights,
                        ),
                        HeaderNavItem(
                          label: AppTexts.navGoldenVisa,
                          route: AppConstants.routeGoldenVisa,
                        ),
                        // Contact and Language Selector in same row
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            HeaderNavItem(
                              label: AppTexts.navContact,
                              route: AppConstants.routeContact,
                            ),
                            HeaderLanguageSelector(
                              selectedLanguage: _selectedLanguage,
                              onLanguageSelected: (language) {
                                setState(() {
                                  _selectedLanguage = language;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

              // Logo on the left
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                child: const HeaderLogo(),
              ),

              // Mobile Menu Button - automatically shows on small screens
              if (!showNav)
                const Positioned(
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: HeaderMobileMenu(),
                ),
            ],
          ),
        );
      },
    );
  }
}
