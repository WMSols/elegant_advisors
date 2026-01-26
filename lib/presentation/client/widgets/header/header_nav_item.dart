import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';
import 'package:elegant_advisors/core/constants/client_constants.dart';
import 'package:elegant_advisors/presentation/client/controllers/properties/client_properties_controller.dart';
import 'package:elegant_advisors/presentation/client/controllers/properties/client_property_detail_controller.dart';
import 'package:elegant_advisors/presentation/client/controllers/contact/client_contact_controller.dart';
import 'package:elegant_advisors/presentation/client/controllers/contact/my_contacts/client_my_contacts_controller.dart';
import 'package:elegant_advisors/presentation/client/controllers/home/client_home_controller.dart';
import 'package:elegant_advisors/presentation/client/controllers/our_team/client_our_team_controller.dart';
import 'package:elegant_advisors/presentation/client/controllers/about_us/client_about_us_controller.dart';

class HeaderNavItem extends StatefulWidget {
  final String label;
  final String route;
  final List<String>? submenuOptions;

  const HeaderNavItem({
    super.key,
    required this.label,
    required this.route,
    this.submenuOptions,
  });

  @override
  State<HeaderNavItem> createState() => _HeaderNavItemState();
}

class _HeaderNavItemState extends State<HeaderNavItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final currentRoute = Get.currentRoute;
    final isActive = currentRoute == widget.route;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppResponsive.scaleSize(context, 8, min: 4, max: 12),
      ),
      child: MouseRegion(
        onEnter: (_) {
          setState(() {
            _isHovered = true;
          });
        },
        onExit: (_) {
          setState(() {
            _isHovered = false;
          });
        },
        child: TextButton(
          onPressed: () {
            // Special handling for properties route to prevent GlobalKey/ScrollController conflicts
            if (widget.route == ClientConstants.routeClientProperties) {
              // Delete both controllers to ensure clean state
              if (Get.isRegistered<ClientPropertyDetailController>()) {
                Get.delete<ClientPropertyDetailController>(force: true);
              }
              if (Get.isRegistered<ClientPropertiesController>()) {
                Get.delete<ClientPropertiesController>(force: true);
              }
              // Use offNamed to replace current route, ensuring old route is fully removed
              // This prevents both widget trees from existing simultaneously
              Get.offNamed(ClientConstants.routeClientProperties);
            } else if (widget.route == ClientConstants.routeClientContact) {
              // Special handling for contact route to prevent GlobalKey conflicts
              // Delete both contact controllers to ensure clean state
              if (Get.isRegistered<ClientMyContactsController>()) {
                Get.delete<ClientMyContactsController>(force: true);
              }
              if (Get.isRegistered<ClientContactController>()) {
                Get.delete<ClientContactController>(force: true);
              }
              // Use offNamed to replace current route, ensuring old route is fully removed
              Get.offNamed(ClientConstants.routeClientContact);
            } else if (widget.route == ClientConstants.routeClientHome) {
              // Special handling for home route to prevent ScrollController conflicts
              if (Get.isRegistered<ClientHomeController>()) {
                Get.delete<ClientHomeController>(force: true);
              }
              Get.offNamed(ClientConstants.routeClientHome);
            } else if (widget.route == ClientConstants.routeClientOurTeam) {
              // Special handling for our team route to prevent ScrollController conflicts
              if (Get.isRegistered<ClientOurTeamController>()) {
                Get.delete<ClientOurTeamController>(force: true);
              }
              Get.offNamed(ClientConstants.routeClientOurTeam);
            } else if (widget.route == ClientConstants.routeClientAboutUs) {
              // Special handling for about us route to prevent ScrollController conflicts
              if (Get.isRegistered<ClientAboutUsController>()) {
                Get.delete<ClientAboutUsController>(force: true);
              }
              Get.offNamed(ClientConstants.routeClientAboutUs);
            } else {
              Get.toNamed(widget.route);
            }
          },
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
                widget.label,
                style: AppTextStyles.bodyText(context).copyWith(
                  color: AppColors.white,
                  letterSpacing: 0.5,
                  fontWeight: (_isHovered || isActive)
                      ? FontWeight.w500
                      : FontWeight.normal,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              if (_isHovered || isActive)
                Container(
                  height: 2,
                  width: AppResponsive.scaleSize(context, 20, min: 15, max: 25),
                  color: AppColors.white,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
