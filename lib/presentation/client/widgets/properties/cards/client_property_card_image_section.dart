import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/widgets/display/app_property_status_badge.dart';
import 'package:elegant_advisors/presentation/client/widgets/properties/cards/client_property_image_gallery.dart';
import 'package:elegant_advisors/domain/models/property_model.dart';

/// Property card image section with status badge overlay
class ClientPropertyCardImageSection extends StatelessWidget {
  final PropertyModel property;

  const ClientPropertyCardImageSection({
    super.key,
    required this.property,
  });

  @override
  Widget build(BuildContext context) {
    final imageHeight = AppResponsive.isMobile(context)
        ? AppResponsive.screenHeight(context) * 0.4
        : AppResponsive.screenHeight(context) * 0.6;

    if (property.images.isEmpty) {
      return Container(
        height: imageHeight,
        width: double.infinity,
        color: AppColors.grey.withValues(alpha: 0.1),
        child: Center(
          child: Icon(
            Iconsax.home,
            size: AppResponsive.scaleSize(context, 80, min: 60, max: 100),
            color: AppColors.primary,
          ),
        ),
      );
    }

    return Stack(
      children: [
        SizedBox(
          height: imageHeight,
          width: double.infinity,
          child: ClientPropertyImageGallery(
            images: property.images,
            height: imageHeight,
          ),
        ),
        // Status Badge Overlay
        Positioned(
          top: AppResponsive.scaleSize(context, 12, min: 8, max: 16),
          left: AppResponsive.scaleSize(context, 12, min: 8, max: 16),
          child: AppPropertyStatusBadge(status: property.status),
        ),
      ],
    );
  }
}
