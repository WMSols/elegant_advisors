import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:elegant_advisors/core/utils/app_texts/app_texts.dart';
import 'package:elegant_advisors/core/widgets/buttons/app_icon_button.dart';
import 'package:elegant_advisors/core/widgets/forms/app_dropdown_field.dart';
import 'package:elegant_advisors/presentation/admin/controllers/admins/admin_manage_admins_controller.dart';

/// Reusable filters widget for admin management
class AdminFilters extends GetView<AdminManageAdminsController> {
  const AdminFilters({super.key});

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
                  label: AppTexts.adminManageAdminsSortBy,
                  labelColor: AppColors.white,
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
