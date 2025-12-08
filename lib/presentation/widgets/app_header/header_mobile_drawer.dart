import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/utils/app_colors/app_colors.dart';
import '../../../core/utils/app_responsive/app_responsive.dart';
import '../../../core/utils/app_spacing/app_spacing.dart';
import '../../../core/utils/app_styles/app_text_styles.dart';
import '../../../core/utils/app_texts/app_texts.dart';

class HeaderMobileDrawer extends StatelessWidget {
  final VoidCallback onClose;

  const HeaderMobileDrawer({
    super.key,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = AppResponsive.screenWidth(context);
    final drawerWidth = screenWidth < 600 
        ? screenWidth * 0.6
        : screenWidth * 0.35;
    
    return Drawer(
      backgroundColor: AppColors.primary,shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero
      ),
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
                    icon: const Icon(
                      Icons.close,
                      color: AppColors.white,
                    ),
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
                    label: AppTexts.navWhatWeDo,
                    route: AppConstants.routeWhatWeDo,
                    onTap: onClose,
                  ),
                  _MobileDrawerItem(
                    label: AppTexts.navHowWeDoIt,
                    route: AppConstants.routeHowWeDoIt,
                    onTap: onClose,
                  ),
                  _MobileDrawerItem(
                    label: AppTexts.navWhyElegant,
                    route: AppConstants.routeWhyElegant,
                    onTap: onClose,
                  ),
                  _MobileDrawerItem(
                    label: AppTexts.navServices,
                    route: AppConstants.routeServices,
                    onTap: onClose,
                  ),
                  _MobileDrawerItem(
                    label: AppTexts.navProperties,
                    route: AppConstants.routeProperties,
                    onTap: onClose,
                  ),
                  _MobileDrawerItem(
                    label: AppTexts.navInsights,
                    route: AppConstants.routeInsights,
                    onTap: onClose,
                  ),
                  _MobileDrawerItem(
                    label: AppTexts.navGoldenVisa,
                    route: AppConstants.routeGoldenVisa,
                    onTap: onClose,
                    showArrow: true,
                    hasSubmenu: true,
                  ),
                  _MobileDrawerItem(
                    label: AppTexts.navContact,
                    route: AppConstants.routeContact,
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
  final bool showArrow;
  final bool hasSubmenu;

  const _MobileDrawerItem({
    required this.label,
    required this.route,
    required this.onTap,
    this.showArrow = false,
    this.hasSubmenu = false,
  });

  @override
  State<_MobileDrawerItem> createState() => _MobileDrawerItemState();
}

class _MobileDrawerItemState extends State<_MobileDrawerItem> {
  bool _isHovered = false;
  bool _isExpanded = false;

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
              if (widget.hasSubmenu) {
                setState(() => _isExpanded = !_isExpanded);
              } else {
                Get.toNamed(widget.route);
                widget.onTap();
              }
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
                      style: AppTextStyles.bodyText(context).copyWith(
                        color: AppColors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  // Arrow icon for Golden Visa
                  if (widget.showArrow)
                    Icon(
                      _isExpanded ? Icons.arrow_drop_down : Icons.arrow_forward_ios,
                      size: 14,
                      color: AppColors.white.withValues(alpha:0.7),
                    ),
                ],
              ),
            ),
          ),
        ),
        // Submenu items
        if (widget.hasSubmenu && _isExpanded)
          _GoldenVisaSubmenu(
            onOptionSelected: () {
              setState(() => _isExpanded = false);
              widget.onTap();
            },
          ),
      ],
    );
  }
}

class _GoldenVisaSubmenu extends StatelessWidget {
  final VoidCallback onOptionSelected;

  const _GoldenVisaSubmenu({required this.onOptionSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary.withValues(alpha:0.8),
      child: Column(
        children: [
          Divider(
            color: AppColors.white.withValues(alpha:0.2),
            height: 1,
          ),
          _SubmenuItem(
            label: 'IFICI',
            onTap: () {
              // Navigate to IFICI page
              onOptionSelected();
            },
          ),
          // Add more submenu items as needed
        ],
      ),
    );
  }
}

class _SubmenuItem extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _SubmenuItem({
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppResponsive.screenWidth(context) * 0.08,
          vertical: AppResponsive.screenHeight(context) * 0.02,
        ),
        child: Row(
          children: [
            Text(
              label,
              style: AppTextStyles.bodyText(context).copyWith(
                color: AppColors.white,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

