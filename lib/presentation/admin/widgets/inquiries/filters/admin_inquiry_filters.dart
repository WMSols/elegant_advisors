import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/core/utils/app_texts/app_texts.dart';
import 'package:elegant_advisors/core/widgets/buttons/app_icon_button.dart';
import 'package:elegant_advisors/core/widgets/buttons/app_button.dart';
import 'package:elegant_advisors/core/widgets/forms/app_dropdown_field.dart';
import 'package:elegant_advisors/presentation/admin/controllers/inquiries/admin_inquiries_controller.dart';

/// Reusable filters widget for inquiry management
class AdminInquiryFilters extends GetView<AdminInquiriesController> {
  const AdminInquiryFilters({super.key});

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
                  label: AppTexts.adminInquiriesSortBy,
                  labelColor: AppColors.white,
                  value: controller.sortBy.value,
                  items: [
                    DropdownMenuItem(
                      value: 'name',
                      child: Text(AppTexts.adminInquiriesSortByName),
                    ),
                    DropdownMenuItem(
                      value: 'email',
                      child: Text(AppTexts.adminInquiriesSortByEmail),
                    ),
                    DropdownMenuItem(
                      value: 'subject',
                      child: Text(AppTexts.adminInquiriesSortBySubject),
                    ),
                    DropdownMenuItem(
                      value: 'status',
                      child: Text(AppTexts.adminInquiriesSortByStatus),
                    ),
                    DropdownMenuItem(
                      value: 'createdAt',
                      child: Text(AppTexts.adminInquiriesSortByCreatedDate),
                    ),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      controller.updateSortBy(value);
                    }
                  },
                  errorTextColor: AppColors.white,
                  isAdmin: true,
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
                    ? AppTexts.adminInquiriesAscending
                    : AppTexts.adminInquiriesDescending,
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
                  label: AppTexts.adminInquiriesStatusFilter,
                  labelColor: AppColors.white,
                  value: controller.statusFilter.value,
                  items: [
                    DropdownMenuItem(
                      value: null,
                      child: Text(AppTexts.adminInquiriesSortAllStatuses),
                    ),
                    DropdownMenuItem(
                      value: 'new',
                      child: Text(AppTexts.adminInquiriesStatusNew),
                    ),
                    DropdownMenuItem(
                      value: 'in_progress',
                      child: Text(AppTexts.adminInquiriesStatusInProgress),
                    ),
                    DropdownMenuItem(
                      value: 'closed',
                      child: Text(AppTexts.adminInquiriesStatusClosed),
                    ),
                  ],
                  onChanged: (value) => controller.updateStatusFilter(value),
                  errorTextColor: AppColors.white,
                  isAdmin: true,
                ),
              ),
            ),
          ],
        ),
        // Clear Filters Button
        Obx(() {
          final hasFilters =
              controller.statusFilter.value != null ||
              controller.selectedPropertyId.value != null ||
              controller.dateFilter.value != null;
          if (!hasFilters) return const SizedBox.shrink();
          return Column(
            children: [
              AppSpacing.vertical(context, 0.01),
              Align(
                alignment: Alignment.centerRight,
                child: AppButton(
                  text: AppTexts.adminInquiriesClearFilters,
                  onPressed: controller.clearFilters,
                  backgroundColor: AppColors.white.withValues(alpha: 0.2),
                  textColor: AppColors.white,
                  isAdmin: true,
                ),
              ),
            ],
          );
        }),
      ],
    );
  }
}
