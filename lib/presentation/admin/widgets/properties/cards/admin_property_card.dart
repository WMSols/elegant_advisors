import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';
import 'package:elegant_advisors/core/utils/app_texts/app_texts.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/core/utils/app_helpers/app_helpers.dart';
import 'package:elegant_advisors/core/widgets/images/app_network_image.dart';
import 'package:elegant_advisors/core/widgets/feedback/app_loading_indicator.dart';
import 'package:elegant_advisors/core/widgets/buttons/app_action_button.dart';
import 'package:elegant_advisors/domain/models/property_model.dart';
import 'package:elegant_advisors/core/widgets/display/app_property_status_badge.dart';
import 'package:elegant_advisors/presentation/admin/widgets/properties/detail_dialog/admin_property_detail_dialog.dart';

/// Reusable property card widget displaying property information
class AdminPropertyCard extends StatelessWidget {
  final PropertyModel property;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onTogglePublish;
  final bool isDeleting;

  const AdminPropertyCard({
    super.key,
    required this.property,
    required this.onEdit,
    required this.onDelete,
    required this.onTogglePublish,
    this.isDeleting = false,
  });


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.dialog(
          AdminPropertyDetailDialog(
            property: property,
            onEdit: () {
              Get.back();
              onEdit();
            },
            onDelete: () {
              Get.back();
              onDelete();
            },
            onTogglePublish: () {
              Get.back();
              onTogglePublish();
            },
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.symmetric(
          vertical: AppResponsive.scaleSize(context, 8, min: 4, max: 12),
        ),
        color: AppColors.white,
        child: Padding(
          padding: AppSpacing.all(context, factor: 0.5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Property Image (if available)
              if (property.images.isNotEmpty)
                Container(
                  width: AppResponsive.scaleSize(context, 120, min: 80, max: 150),
                  height: AppResponsive.scaleSize(context, 120, min: 80, max: 150),
                  margin: EdgeInsets.only(
                    right: AppResponsive.scaleSize(context, 16, min: 12, max: 20),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      AppResponsive.radius(context),
                    ),
                    color: AppColors.grey.withValues(alpha: 0.2),
                  ),
                  child: AppNetworkImage(
                    imageUrl: property.coverImage ?? property.images.first,
                    fit: BoxFit.cover,
                    loadingVariant: LoadingIndicatorVariant.primary,
                    maxWidthDiskCache: 1000,
                    maxHeightDiskCache: 1000,
                    borderRadius: AppResponsive.radius(context),
                    backgroundColor: AppColors.grey.withValues(alpha: 0.2),
                    errorWidget: Icon(
                      Iconsax.home,
                      size: AppResponsive.scaleSize(context, 40, min: 30, max: 50),
                      color: AppColors.primary,
                    ),
                  ),
                )
              else
                Container(
                  width: AppResponsive.scaleSize(context, 120, min: 80, max: 150),
                  height: AppResponsive.scaleSize(context, 120, min: 80, max: 150),
                  margin: EdgeInsets.only(
                    right: AppResponsive.scaleSize(context, 16, min: 12, max: 20),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      AppResponsive.radius(context),
                    ),
                    color: AppColors.grey.withValues(alpha: 0.2),
                  ),
                  child: Icon(
                    Iconsax.image,
                    size: AppResponsive.scaleSize(context, 40, min: 30, max: 50),
                    color: AppColors.primary,
                  ),
                ),
            // Property Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    property.title,
                    style: AppTextStyles.heading(
                      context,
                    ).copyWith(fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  AppSpacing.vertical(context, 0.005),
                  // Location
                  Text(
                    AppHelpers.formatPropertyLocationSimple(
                      property.location.city,
                      property.location.country,
                    ),
                    style: AppTextStyles.bodyText(
                      context,
                    ).copyWith(color: AppColors.primary),
                  ),
                  AppSpacing.vertical(context, 0.005),
                  // Price
                  Text(
                    property.price.isOnRequest
                        ? AppTexts.adminPropertyCardPriceOnRequest
                        : property.price.amount == null
                            ? AppTexts.adminPropertyCardPriceNotSet
                            : AppHelpers.formatCurrency(
                                property.price.amount!,
                                property.price.currency,
                              ),
                    style: AppTextStyles.heading(context).copyWith(
                      color: AppColors.primary,
                      fontSize: AppResponsive.fontSizeClamped(
                        context,
                        min: 14,
                        max: 18,
                      ),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  AppSpacing.vertical(context, 0.005),
                  // Specs
                  Text(
                    AppHelpers.formatPropertySpecs(
                      property.specs.propertyType,
                      property.specs.bedrooms,
                      property.specs.bathrooms,
                      property.specs.areaSize,
                      property.specs.areaUnit,
                    ),
                    style: AppTextStyles.bodyText(context).copyWith(
                      color: AppColors.primary,
                      fontSize: AppResponsive.fontSizeClamped(
                        context,
                        min: 12,
                        max: 14,
                      ),
                    ),
                  ),
                  AppSpacing.vertical(context, 0.01),
                  // Status and Badges
                  Wrap(
                    spacing: AppResponsive.scaleSize(context, 8, min: 6, max: 12),
                    runSpacing: AppResponsive.scaleSize(context, 4, min: 2, max: 6),
                    children: [
                      AppPropertyStatusBadge(status: property.status),
                      if (property.isFeatured)
                        AppPropertyStatusBadge(
                          text: AppTexts.adminPropertiesFeatured,
                          color: AppColors.primary,
                        ),
                    ],
                  ),
                  AppSpacing.vertical(context, 0.005),
                  // Created Date
                  Row(
                    children: [
                      Icon(
                        Iconsax.calendar,
                        size: AppResponsive.scaleSize(
                          context,
                          14,
                          min: 12,
                          max: 16,
                        ),
                        color: AppColors.primary,
                      ),
                      AppSpacing.horizontal(context, 0.005),
                      Flexible(
                        child: Text(
                          '${AppTexts.adminPropertyCardCreated} ${AppHelpers.formatDateTime(property.createdAt)}',
                          style: AppTextStyles.bodyText(context).copyWith(
                            color: AppColors.primary,
                            fontSize: AppResponsive.fontSizeClamped(
                              context,
                              min: 11,
                              max: 13,
                            ),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  AppSpacing.vertical(context, 0.01),
                  // Action Buttons - Single Row with labels for better UX
                  if (isDeleting)
                    Padding(
                      padding: EdgeInsets.all(
                        AppResponsive.scaleSize(context, 8, min: 6, max: 12),
                      ),
                      child: AppLoadingIndicator(
                        variant: LoadingIndicatorVariant.primary,
                        size: AppResponsive.scaleSize(
                          context,
                          20,
                          min: 16,
                          max: 24,
                        ),
                      ),
                    )
                  else
                    Wrap(
                      spacing: AppResponsive.scaleSize(context, 8, min: 6, max: 12),
                      runSpacing: AppResponsive.scaleSize(context, 4, min: 2, max: 6),
                      children: [
                        AppActionButton(
                          label: property.isPublished
                              ? AppTexts.adminPropertiesUnpublished
                              : AppTexts.adminPropertiesPublished,
                          onPressed: onTogglePublish,
                          backgroundColor: property.isPublished
                              ? AppColors.warning
                              : AppColors.success,
                          icon: property.isPublished
                              ? Iconsax.eye_slash
                              : Iconsax.eye,
                        ),
                        AppActionButton(
                          label: AppTexts.adminPropertiesEdit,
                          onPressed: onEdit,
                          backgroundColor: AppColors.information,
                          icon: Iconsax.edit,
                        ),
                        AppActionButton(
                          label: AppTexts.adminPropertiesDelete,
                          onPressed: onDelete,
                          backgroundColor: AppColors.error,
                          icon: Iconsax.trash,
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }
}
