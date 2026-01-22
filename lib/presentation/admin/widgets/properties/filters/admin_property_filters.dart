import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/core/utils/app_texts/app_texts.dart';
import 'package:elegant_advisors/core/widgets/buttons/app_icon_button.dart';
import 'package:elegant_advisors/core/widgets/buttons/app_button.dart';
import 'package:elegant_advisors/core/widgets/forms/app_dropdown_field.dart';
import 'package:elegant_advisors/presentation/admin/controllers/properties/admin_properties_controller.dart';

/// Reusable filters widget for property management
class AdminPropertyFilters extends GetView<AdminPropertiesController> {
  const AdminPropertyFilters({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Filters Row
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Sort By Dropdown
            Expanded(
              child: Obx(
                () => AppDropdownField<String>(
                  label: AppTexts.adminPropertiesSortBy,
                  labelColor: AppColors.white,
                  value: controller.sortBy.value,
                  items: [
                    DropdownMenuItem(
                      value: 'title',
                      child: Text(AppTexts.adminPropertiesSortByTitle),
                    ),
                    DropdownMenuItem(
                      value: 'createdAt',
                      child: Text(AppTexts.adminPropertiesSortByCreatedDate),
                    ),
                    DropdownMenuItem(
                      value: 'updatedAt',
                      child: Text(AppTexts.adminPropertiesSortByUpdatedDate),
                    ),
                    DropdownMenuItem(
                      value: 'price',
                      child: Text(AppTexts.adminPropertiesSortByPrice),
                    ),
                    DropdownMenuItem(
                      value: 'status',
                      child: Text(AppTexts.adminPropertiesSortByStatus),
                    ),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      controller.updateSortBy(value);
                    }
                  },
                  errorTextColor: AppColors.white,
                ),
              ),
            ),
            // Sort Order Toggle
            Obx(
              () => AppIconButton(
                icon: controller.sortOrder.value == 'asc'
                    ? Iconsax.arrow_up_3
                    : Iconsax.arrow_down,
                onPressed: controller.toggleSortOrder,
                color: AppColors.white,
                tooltip: controller.sortOrder.value == 'asc'
                    ? AppTexts.adminPropertiesAscending
                    : AppTexts.adminPropertiesDescending,
              ),
            ),
          ],
        ),
        AppSpacing.vertical(context, 0.015),
        // Status Filter
        Row(
          children: [
            Expanded(
              child: Obx(
                () => AppDropdownField<String?>(
                  label: AppTexts.adminPropertiesStatusFilter,
                  labelColor: AppColors.white,
                  value: controller.statusFilter.value,
                  items: [
                    DropdownMenuItem(
                      value: null,
                      child: Text(AppTexts.adminPropertiesSortAllStatuses),
                    ),
                    DropdownMenuItem(
                      value: 'available',
                      child: Text(AppTexts.adminPropertiesStatusAvailable),
                    ),
                    DropdownMenuItem(
                      value: 'sold',
                      child: Text(AppTexts.adminPropertiesStatusSold),
                    ),
                    DropdownMenuItem(
                      value: 'off_market',
                      child: Text(AppTexts.adminPropertiesStatusOffMarket),
                    ),
                    DropdownMenuItem(
                      value: 'coming_soon',
                      child: Text(AppTexts.adminPropertiesStatusComingSoon),
                    ),
                  ],
                  onChanged: (value) => controller.updateStatusFilter(value),
                  errorTextColor: AppColors.white,
                ),
              ),
            ),
            AppSpacing.horizontal(context, 0.01),
            Expanded(
              child: Obx(
                () => AppDropdownField<bool?>(
                  label: AppTexts.adminPropertiesPublishedFilter,
                  labelColor: AppColors.white,
                  value: controller.publishedFilter.value,
                  items: [
                    DropdownMenuItem(
                      value: null,
                      child: Text(AppTexts.adminPropertiesSortAll),
                    ),
                    DropdownMenuItem(
                      value: true,
                      child: Text(AppTexts.adminPropertiesPublished),
                    ),
                    DropdownMenuItem(
                      value: false,
                      child: Text(AppTexts.adminPropertiesUnpublished),
                    ),
                  ],
                  onChanged: (value) => controller.updatePublishedFilter(value),
                  errorTextColor: AppColors.white,
                ),
              ),
            ),
            AppSpacing.horizontal(context, 0.01),
            Expanded(
              child: Obx(
                () => AppDropdownField<bool?>(
                  label: AppTexts.adminPropertiesFeaturedFilter,
                  labelColor: AppColors.white,
                  value: controller.featuredFilter.value,
                  items: [
                    DropdownMenuItem(
                      value: null,
                      child: Text(AppTexts.adminPropertiesSortAll),
                    ),
                    DropdownMenuItem(
                      value: true,
                      child: Text(AppTexts.adminPropertiesFeatured),
                    ),
                    DropdownMenuItem(
                      value: false,
                      child: Text(AppTexts.adminPropertiesNotFeatured),
                    ),
                  ],
                  onChanged: (value) => controller.updateFeaturedFilter(value),
                  errorTextColor: AppColors.white,
                ),
              ),
            ),
          ],
        ),
        // Clear Filters Button
        Obx(() {
          final hasFilters =
              controller.statusFilter.value != null ||
              controller.publishedFilter.value != null ||
              controller.featuredFilter.value != null;
          if (!hasFilters) return const SizedBox.shrink();
          return Column(
            children: [
              AppSpacing.vertical(context, 0.01),
              Align(
                alignment: Alignment.centerRight,
                child: AppButton(
                  text: AppTexts.adminPropertiesClearFilters,
                  onPressed: controller.clearFilters,
                  backgroundColor: AppColors.white.withValues(alpha: 0.2),
                  textColor: AppColors.white,
                ),
              ),
            ],
          );
        }),
      ],
    );
  }
}
