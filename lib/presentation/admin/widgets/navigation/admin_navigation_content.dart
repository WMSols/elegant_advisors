import 'package:elegant_advisors/core/utils/app_fonts/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_texts/app_texts.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/widgets/app_logo.dart';
import 'package:elegant_advisors/core/constants/admin_constants.dart';
import 'package:elegant_advisors/presentation/admin/widgets/navigation/admin_navigation_item.dart';
import 'package:elegant_advisors/presentation/admin/widgets/navigation/admin_navigation_logout_button.dart';

/// Content widget for admin navigation panel
class AdminNavigationContent extends StatelessWidget {
  final String currentRoute;
  final String adminName;
  final VoidCallback onLogout;

  const AdminNavigationContent({
    super.key,
    required this.currentRoute,
    required this.adminName,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = AppResponsive.isMobile(context);
    final sidePadding = isMobile
        ? AppResponsive.scaleSize(context, 16, min: 12, max: 20)
        : AppResponsive.scaleSize(context, 12, min: 8, max: 16);

    return LayoutBuilder(
      builder: (context, constraints) {
        final availableHeight = constraints.maxHeight;

        // Simplified responsive calculations
        final _getPadding =
            (double normal, double small, double verySmall, double extreme) {
              if (availableHeight < 150) return extreme;
              if (availableHeight < 500) return verySmall;
              if (availableHeight < 600) return small;
              return normal;
            };

        final logoVerticalPadding = _getPadding(
          AppResponsive.scaleSize(context, 24, min: 16, max: 32),
          8.0,
          4.0,
          2.0,
        );

        final bottomPadding = _getPadding(sidePadding, 6.0, 4.0, 2.0);
        final spacingBetweenNameAndButton = _getPadding(
          AppResponsive.scaleSize(context, 8, min: 4, max: 12),
          4.0,
          2.0,
          1.0,
        );

        final showLogo = availableHeight > 100;
        final logoTitleSize = availableHeight < 150
            ? 12.0
            : availableHeight < 500
            ? 16.0
            : availableHeight < 600
            ? 18.0
            : null;
        final logoSubtitleSize = logoTitleSize != null
            ? logoTitleSize * 0.5
            : null;

        return ConstrainedBox(
          constraints: BoxConstraints(maxHeight: constraints.maxHeight),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Logo - Flexible to allow shrinking, hide if space is too limited
              if (showLogo)
                Flexible(
                  flex: 0,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: availableHeight < 150
                          ? 30.0
                          : availableHeight < 500
                          ? 50.0
                          : availableHeight < 600
                          ? 70.0
                          : 100.0,
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: sidePadding,
                        vertical: logoVerticalPadding,
                      ),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: AppLogo(
                          color: AppColors.primary,
                          titleFontSize: logoTitleSize,
                          subtitleFontSize: logoSubtitleSize,
                        ),
                      ),
                    ),
                  ),
                ),

              // Navigation Items - Flexible to take remaining space (can shrink if needed)
              Flexible(
                child: ListView(
                  clipBehavior: Clip.none,
                  padding: EdgeInsets.symmetric(
                    horizontal: sidePadding * 0.5,
                    vertical: _getPadding(
                      AppResponsive.scaleSize(context, 8, min: 4, max: 12),
                      6.0,
                      4.0,
                      2.0,
                    ),
                  ).copyWith(right: 0),
                  children: [
                    AdminNavigationItem(
                      icon: Iconsax.element_4,
                      label: AppTexts.adminNavDashboard,
                      route: AdminConstants.routeAdminDashboard,
                      currentRoute: currentRoute,
                    ),
                    AdminNavigationItem(
                      icon: Iconsax.home,
                      label: AppTexts.adminNavProperties,
                      route: AdminConstants.routeAdminProperties,
                      currentRoute: currentRoute,
                      relatedRoutes: [
                        AdminConstants.routeAdminPropertyAdd,
                        AdminConstants.routeAdminPropertyEdit,
                      ],
                    ),
                    AdminNavigationItem(
                      icon: Iconsax.sms,
                      label: AppTexts.adminNavInquiries,
                      route: AdminConstants.routeAdminInquiries,
                      currentRoute: currentRoute,
                    ),
                    AdminNavigationItem(
                      icon: Iconsax.profile_2user,
                      label: AppTexts.adminNavManageAdmins,
                      route: AdminConstants.routeAdminManageAdmins,
                      currentRoute: currentRoute,
                      relatedRoutes: [
                        AdminConstants.routeAdminCreateAdmin,
                        AdminConstants.routeAdminEditAdmin,
                      ],
                    ),
                  ],
                ),
              ),

              // Divider - Hide if space is extremely limited
              if (availableHeight >= 150)
                Divider(
                  height: 1,
                  thickness: 1,
                  color: AppColors.primary.withValues(alpha: 0.5),
                ),

              // Admin Name and Logout - Constrained to prevent overflow
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: availableHeight < 200 ? 40.0 : double.infinity,
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    left: sidePadding,
                    right: sidePadding,
                    top: bottomPadding,
                    bottom: bottomPadding,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          adminName,
                          style: AppTextStyles.bodyText(context).copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary,
                            fontFamily: AppFonts.primaryFont,
                            fontSize: availableHeight < 200
                                ? AppResponsive.scaleSize(
                                    context,
                                    12,
                                    min: 10,
                                    max: 14,
                                  )
                                : null,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          textAlign: TextAlign.left,
                        ),
                      ),
                      if (spacingBetweenNameAndButton > 0)
                        SizedBox(height: spacingBetweenNameAndButton),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: AdminNavigationLogoutButton(onLogout: onLogout),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
