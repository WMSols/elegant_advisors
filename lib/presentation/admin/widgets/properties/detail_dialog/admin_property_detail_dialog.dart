import 'package:flutter/material.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/domain/models/property_model.dart';
import 'package:elegant_advisors/presentation/admin/widgets/properties/detail_dialog/admin_property_detail_header.dart';
import 'package:elegant_advisors/presentation/admin/widgets/properties/detail_dialog/admin_property_detail_content.dart';

/// Detail dialog showing full property information
class AdminPropertyDetailDialog extends StatelessWidget {
  final PropertyModel property;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onTogglePublish;

  const AdminPropertyDetailDialog({
    super.key,
    required this.property,
    required this.onEdit,
    required this.onDelete,
    required this.onTogglePublish,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = AppResponsive.isMobile(context);
    final screenWidth = AppResponsive.screenWidth(context);

    // Calculate dialog width based on screen size
    final dialogWidth = isMobile ? screenWidth * 0.9 : screenWidth * 0.8;

    // Calculate horizontal padding for mobile
    final horizontalPadding = isMobile
        ? AppResponsive.scaleSize(context, 16, min: 12, max: 24)
        : AppResponsive.scaleSize(context, 24, min: 16, max: 32);

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: AppResponsive.scaleSize(context, 24, min: 16, max: 32),
      ),
      child: SizedBox(
        width: dialogWidth,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: AppResponsive.screenHeight(context) * 0.9,
            minWidth: isMobile ? 280 : 350,
          ),
          child: Stack(
            children: [
              // Background - same as AppAlertDialog
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    // image: const DecorationImage(
                    //   image: AssetImage(AppImages.homeBackground),
                    //   fit: BoxFit.cover,
                    //   onError: null,
                    // ),
                    borderRadius: BorderRadius.circular(
                      AppResponsive.radius(context),
                    ),
                  ),
                ),
              ),
              // Content
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header with Action Buttons
                  AdminPropertyDetailHeader(
                    property: property,
                    onEdit: onEdit,
                    onDelete: onDelete,
                    onTogglePublish: onTogglePublish,
                  ),
                  // Content
                  Flexible(
                    child: AdminPropertyDetailContent(property: property),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
