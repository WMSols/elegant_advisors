import 'package:flutter/material.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_images/app_images.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/core/utils/app_texts/app_texts.dart';
import 'package:elegant_advisors/presentation/client/widgets/header/header_language_selector.dart';
import 'package:elegant_advisors/presentation/client/widgets/header/header_logo.dart';
import 'package:elegant_advisors/presentation/client/widgets/header/header_mobile_menu.dart';
import 'package:elegant_advisors/presentation/client/widgets/header/header_nav_item.dart';
import 'package:elegant_advisors/core/constants/client_constants.dart';

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
                ? AppColors.primary
                : Colors.transparent,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Logo on the left
              const HeaderLogo(),

              // Navigation Menu - centered and flexible
              if (showNav)
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          HeaderNavItem(
                            label: AppTexts.navProperties,
                            route: ClientConstants.routeClientProperties,
                          ),
                          HeaderNavItem(
                            label: AppTexts.navOurTeam,
                            route: ClientConstants.routeClientOurTeam,
                          ),
                          HeaderNavItem(
                            label: AppTexts.navAboutUs,
                            route: ClientConstants.routeClientAboutUs,
                          ),
                          // Contact and Language Selector in same row
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              HeaderNavItem(
                                label: AppTexts.navContact,
                                route: ClientConstants.routeClientContact,
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
                )
              else
                const Spacer(),

              // Mobile Menu Button and Language Selector - automatically shows on small screens
              if (!showNav)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const HeaderMobileMenu(),
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
        );
      },
    );
  }
}
