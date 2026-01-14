import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/core/utils/app_texts/app_texts.dart';
import 'package:elegant_advisors/core/widgets/forms/app_search_field.dart';
import 'package:elegant_advisors/core/widgets/buttons/app_icon_button.dart';
import 'package:elegant_advisors/core/widgets/forms/app_dropdown_field.dart';
import 'package:elegant_advisors/presentation/admin/controllers/admins/admin_manage_admins_controller.dart';

/// Reusable search and filters widget for admin management
class AdminSearchAndFilters extends GetView<AdminManageAdminsController> {
  const AdminSearchAndFilters({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Search Field
        AppSearchField(
          controller: controller.searchController,
          hint: AppTexts.adminManageAdminsSearchHint,
          onFieldSubmitted: controller.updateSearchQuery,
        ),
        AppSpacing.vertical(context, 0.015),
        // Filters Row
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Sort By Dropdown
            Expanded(
              child: Obx(
                () => AppDropdownField<String>(
                  label: AppTexts.adminManageAdminsSortBy,
                  value: controller.sortBy.value,
                  items: [
                    DropdownMenuItem(
                      value: 'name',
                      child: Text(AppTexts.adminManageAdminsSortByName),
                    ),
                    DropdownMenuItem(
                      value: 'email',
                      child: Text(AppTexts.adminManageAdminsSortByEmail),
                    ),
                    DropdownMenuItem(
                      value: 'createdAt',
                      child: Text(AppTexts.adminManageAdminsSortByCreatedDate),
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
                    ? AppTexts.adminManageAdminsAscending
                    : AppTexts.adminManageAdminsDescending,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
