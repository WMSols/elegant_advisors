import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:elegant_advisors/core/constants/client_constants.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';
import 'package:elegant_advisors/core/utils/app_texts/app_texts.dart';

class HeaderMobileDrawer extends StatelessWidget {
  final VoidCallback onClose;

  const HeaderMobileDrawer({super.key, required this.onClose});

  @override
  Widget build(BuildContext context) {
    final screenWidth = AppResponsive.screenWidth(context);
    final drawerWidth = screenWidth < 600
        ? screenWidth * 0.6
        : screenWidth * 0.35;

    return Drawer(
      backgroundColor: AppColors.primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      width: drawerWidth,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Close button in header
            Padding(
              padding: AppSpacing.symmetric(context, h: 0.04, v: 0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close, color: AppColors.white),
                    onPressed: onClose,
                  ),
                ],
              ),
            ),
            // Navigation items
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _MobileDrawerItem(
                    label: AppTexts.navProperties,
                    route: ClientConstants.routeProperties,
                    onTap: onClose,
                  ),
                  _MobileDrawerItem(
                    label: AppTexts.navOurTeam,
                    route: ClientConstants.routeOurTeam,
                    onTap: onClose,
                  ),
                  _MobileDrawerItem(
                    label: AppTexts.navAboutUs,
                    route: ClientConstants.routeAboutUs,
                    onTap: onClose,
                  ),
                  _MobileDrawerItem(
                    label: AppTexts.navContact,
                    route: ClientConstants.routeContact,
                    onTap: onClose,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MobileDrawerItem extends StatefulWidget {
  final String label;
  final String route;
  final VoidCallback onTap;

  const _MobileDrawerItem({
    required this.label,
    required this.route,
    required this.onTap,
  });

  @override
  State<_MobileDrawerItem> createState() => _MobileDrawerItemState();
}

class _MobileDrawerItemState extends State<_MobileDrawerItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final currentRoute = Get.currentRoute;
    final isActive = currentRoute == widget.route;

    return Column(
      children: [
        MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          child: InkWell(
            onTap: () {
              Get.toNamed(widget.route);
              widget.onTap();
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppResponsive.screenWidth(context) * 0.04,
                vertical: AppResponsive.screenHeight(context) * 0.02,
              ),
              child: Row(
                children: [
                  // Vertical line indicator (appears on hover)
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: _isHovered || isActive ? 2 : 0,
                    height: AppResponsive.screenHeight(context) * 0.03,
                    margin: EdgeInsets.only(
                      right: _isHovered || isActive ? 12 : 0,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(1),
                    ),
                  ),
                  // Menu item text
                  Expanded(
                    child: Text(
                      widget.label,
                      style: AppTextStyles.bodyText(
                        context,
                      ).copyWith(color: AppColors.white, letterSpacing: 0.5),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
