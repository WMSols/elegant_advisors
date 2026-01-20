import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';
import 'package:elegant_advisors/core/constants/client_constants.dart';
import 'package:elegant_advisors/presentation/client/controllers/properties/client_properties_controller.dart';
import 'package:elegant_advisors/presentation/client/controllers/properties/client_property_detail_controller.dart';

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
                style: AppTextStyles.bodyText(
                  context,
                ).copyWith(color: AppColors.white, letterSpacing: 0.5),
                overflow: TextOverflow.ellipsis,
              ),
              if (_isHovered || isActive)
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
      ),
    );
  }
}
