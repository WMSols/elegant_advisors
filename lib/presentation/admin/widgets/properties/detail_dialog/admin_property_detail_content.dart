import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';
import 'package:elegant_advisors/core/utils/app_texts/app_texts.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/core/utils/app_helpers/app_helpers.dart';
import 'package:elegant_advisors/core/widgets/display/app_property_status_badge.dart';
import 'package:elegant_advisors/domain/models/property_model.dart';
import 'package:elegant_advisors/presentation/admin/widgets/properties/detail_dialog/admin_property_detail_section.dart';
import 'package:elegant_advisors/presentation/admin/widgets/properties/detail_dialog/admin_property_detail_images.dart';

/// Content section for property detail dialog
class AdminPropertyDetailContent extends StatelessWidget {
  final PropertyModel property;

  const AdminPropertyDetailContent({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: AppSpacing.all(context, factor: 0.8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Images
          if (property.images.isNotEmpty)
            AdminPropertyDetailImages(
              images: property.images,
              coverImage: property.coverImage,
            ),
          // Location
          AdminPropertyDetailSection(
            label: AppTexts.adminPropertyDetailLocation,
            icon: Iconsax.location,
            value: AppHelpers.formatPropertyLocationFull(
              property.location.country,
              property.location.city,
              property.location.area,
              property.location.address,
            ),
          ),
          AppSpacing.vertical(context, 0.02),
          // Price
          AdminPropertyDetailSection(
            label: AppTexts.adminPropertyDetailPrice,
            icon: Iconsax.dollar_circle,
            value: property.price.isOnRequest
                ? AppTexts.adminPropertyDetailPriceOnRequest
                : property.price.amount == null
                ? AppTexts.adminPropertyDetailPriceNotSet
                : AppHelpers.formatCurrency(
                    property.price.amount!,
                    property.price.currency,
                  ),
          ),
          AppSpacing.vertical(context, 0.02),
          // Specs
          AdminPropertyDetailSection(
            label: AppTexts.adminPropertyDetailSpecifications,
            icon: Iconsax.home_2,
            value: AppHelpers.formatPropertySpecsDetail(
              property.specs.propertyType,
              property.specs.bedrooms,
              property.specs.bathrooms,
              property.specs.areaSize,
              property.specs.areaUnit,
            ),
          ),
          AppSpacing.vertical(context, 0.02),
          // Status & Badges
          Wrap(
            spacing: AppResponsive.scaleSize(context, 8, min: 6, max: 12),
            runSpacing: AppResponsive.scaleSize(context, 4, min: 2, max: 6),
            children: [
              AppPropertyStatusBadge(status: property.status, isAdmin: true),
              if (property.isFeatured)
                AppPropertyStatusBadge(
                  text: AppTexts.adminPropertiesFeatured,
                  color: AppColors.primary,
                  isAdmin: true,
                ),
            ],
          ),
          AppSpacing.vertical(context, 0.02),
          // Short Description
          AdminPropertyDetailSection(
            label: AppTexts.adminPropertyDetailShortDescription,
            icon: Iconsax.document_text,
            value: property.shortDescription,
          ),
          AppSpacing.vertical(context, 0.02),
          // Full Description
          AdminPropertyDetailSection(
            label: AppTexts.adminPropertyDetailFullDescription,
            icon: Iconsax.document,
            value: property.fullDescription,
          ),
          AppSpacing.vertical(context, 0.02),
          // Features
          if (property.features.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Iconsax.star, color: AppColors.white, size: 20),
                    AppSpacing.horizontal(context, 0.01),
                    Text(
                      AppTexts.adminPropertyDetailFeatures,
                      style: AppTextStyles.heading(context).copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                AppSpacing.vertical(context, 0.01),
                Wrap(
                  spacing: AppResponsive.scaleSize(context, 8, min: 6, max: 12),
                  runSpacing: AppResponsive.scaleSize(
                    context,
                    8,
                    min: 6,
                    max: 12,
                  ),
                  children: property.features.map((feature) {
                    return Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppResponsive.scaleSize(
                          context,
                          12,
                          min: 8,
                          max: 16,
                        ),
                        vertical: AppResponsive.scaleSize(
                          context,
                          6,
                          min: 4,
                          max: 8,
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(
                          AppResponsive.radius(context, factor: 3),
                        ),
                      ),
                      child: Text(
                        feature,
                        style: AppTextStyles.bodyText(
                          context,
                        ).copyWith(color: AppColors.white),
                      ),
                    );
                  }).toList(),
                ),
                AppSpacing.vertical(context, 0.02),
              ],
            ),
          // Metadata
          AdminPropertyDetailSection(
            label: AppTexts.adminPropertyDetailCreated,
            icon: Iconsax.calendar,
            value: AppHelpers.formatDateTime(property.createdAt),
          ),
          AppSpacing.vertical(context, 0.01),
          AdminPropertyDetailSection(
            label: AppTexts.adminPropertyDetailLastUpdated,
            icon: Iconsax.clock,
            value: AppHelpers.formatDateTime(property.updatedAt),
          ),
        ],
      ),
    );
  }
}
