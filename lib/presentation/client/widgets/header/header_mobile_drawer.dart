import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:elegant_advisors/core/constants/client_constants.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';
import 'package:elegant_advisors/core/utils/app_texts/app_texts.dart';
import 'package:elegant_advisors/core/widgets/buttons/app_icon_button.dart';
import 'package:elegant_advisors/presentation/client/controllers/properties/client_properties_controller.dart';
import 'package:elegant_advisors/presentation/client/controllers/properties/client_property_detail_controller.dart';
import 'package:elegant_advisors/presentation/client/controllers/contact/client_contact_controller.dart';
import 'package:elegant_advisors/presentation/client/controllers/contact/my_contacts/client_my_contacts_controller.dart';

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
                  AppIconButton(
                    icon: Iconsax.close_circle,
                    color: AppColors.white,
                    onPressed: onClose,
                    tooltip: AppTexts.commonClose,
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
                    label: AppTexts.navHome,
                    route: ClientConstants.routeClientHome,
                    onTap: onClose,
                  ),
                  _MobileDrawerItem(
                    label: AppTexts.navProperties,
                    route: ClientConstants.routeClientProperties,
                    onTap: onClose,
                  ),
                  _MobileDrawerItem(
                    label: AppTexts.navOurTeam,
                    route: ClientConstants.routeClientOurTeam,
                    onTap: onClose,
                  ),
                  _MobileDrawerItem(
                    label: AppTexts.navAboutUs,
                    route: ClientConstants.routeClientAboutUs,
                    onTap: onClose,
                  ),
                  _MobileDrawerItem(
                    label: AppTexts.navContact,
                    route: ClientConstants.routeClientContact,
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
  bool _isNavigating = false;

  @override
  Widget build(BuildContext context) {
    final currentRoute = Get.currentRoute;
    final isActive = currentRoute == widget.route;

    void handleNavigation() {
      // Prevent double execution if both GestureDetector and InkWell fire
      if (_isNavigating) {
        return;
      }
      _isNavigating = true;

      try {
        final currentRoute = Get.currentRoute;

        // If already on the target route, just close the drawer
        if (currentRoute == widget.route) {
          widget.onTap();
          _isNavigating = false;
          return;
        }

        // Special handling for properties route to prevent GlobalKey/ScrollController conflicts
        if (widget.route == ClientConstants.routeClientProperties) {
          // Delete both controllers to ensure clean state
          if (Get.isRegistered<ClientPropertyDetailController>()) {
            Get.delete<ClientPropertyDetailController>(force: true);
          }
          if (Get.isRegistered<ClientPropertiesController>()) {
            Get.delete<ClientPropertiesController>(force: true);
          }
        }

        // Special handling for contact route to prevent GlobalKey conflicts
        if (widget.route == ClientConstants.routeClientContact) {
          // Delete both contact controllers to ensure clean state
          if (Get.isRegistered<ClientMyContactsController>()) {
            Get.delete<ClientMyContactsController>(force: true);
          }
          if (Get.isRegistered<ClientContactController>()) {
            Get.delete<ClientContactController>(force: true);
          }
        }

        // Close drawer first, then navigate immediately
        // The drawer needs to close before navigation to avoid context issues
        Navigator.of(context).pop();

        // Use offNamedUntil like admin side - this replaces the Scaffold
        // Keep routes until we reach home route (or null for initial route)
        Get.offNamedUntil(
          widget.route,
          (route) =>
              route.settings.name == ClientConstants.routeClientHome ||
              route.settings.name == null,
        );
      } catch (e) {
        _isNavigating = false;
      } finally {
        // Reset flag after a short delay to allow navigation to complete
        Future.delayed(const Duration(milliseconds: 300), () {
          _isNavigating = false;
        });
      }
    }

    return Column(
      children: [
        MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          child: GestureDetector(
            onTap: handleNavigation,
            behavior: HitTestBehavior.opaque,
            child: InkWell(
              onTap: handleNavigation,
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
        ),
      ],
    );
  }
}
