import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:elegant_advisors/core/constants/client_constants.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';
import 'package:elegant_advisors/core/utils/app_helpers/language/app_localizations_helper.dart';
import 'package:elegant_advisors/presentation/client/controllers/properties/client_properties_controller.dart';
import 'package:elegant_advisors/presentation/client/controllers/properties/client_property_detail_controller.dart';

/// Breadcrumbs widget for property detail page
class ClientPropertyDetailBreadcrumbs extends StatelessWidget {
  final String propertyTitle;

  const ClientPropertyDetailBreadcrumbs({
    super.key,
    required this.propertyTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildBreadcrumbItem(
          context,
          context.l10n.clientPropertyDetailBreadcrumbHome,
          () => Get.toNamed(ClientConstants.routeClientHome),
        ),
        _buildSeparator(context),
        _buildBreadcrumbItem(
          context,
          context.l10n.clientPropertyDetailBreadcrumbProperties,
          () {
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
          },
        ),
        _buildSeparator(context),
        _buildBreadcrumbItem(
          context,
          propertyTitle,
          null, // Current page, not clickable
          isActive: true,
        ),
      ],
    );
  }

  Widget _buildBreadcrumbItem(
    BuildContext context,
    String text,
    VoidCallback? onTap, {
    bool isActive = false,
  }) {
    final textWidget = Text(
      text,
      style: AppTextStyles.bodyText(context).copyWith(
        color: isActive
            ? AppColors.primary
            : AppColors.primary.withValues(alpha: 0.7),
        fontSize: AppResponsive.fontSizeClamped(context, min: 12, max: 14),
        fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
      ),
    );

    if (onTap == null) {
      return textWidget;
    }

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(onTap: onTap, child: textWidget),
    );
  }

  Widget _buildSeparator(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppResponsive.scaleSize(context, 8, min: 4, max: 12),
      ),
      child: Icon(
        Iconsax.arrow_right_3,
        size: AppResponsive.scaleSize(context, 12, min: 10, max: 14),
        color: AppColors.primary.withValues(alpha: 0.7),
      ),
    );
  }
}
