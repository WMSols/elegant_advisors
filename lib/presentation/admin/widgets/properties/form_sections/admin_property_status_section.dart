import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:elegant_advisors/presentation/admin/controllers/properties/admin_property_form_controller.dart';
import 'package:elegant_advisors/presentation/admin/widgets/properties/form_sections/admin_property_form_section.dart';
import 'package:elegant_advisors/core/widgets/forms/app_dropdown_field.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/core/utils/app_texts/app_texts.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';

class AdminPropertyStatusSection extends GetView<AdminPropertyFormController> {
  const AdminPropertyStatusSection({super.key});

  @override
  Widget build(BuildContext context) {
    return AdminPropertyFormSection(
      title: AppTexts.adminPropertyFormStatusSettings,
      child: Column(
        children: [
          Obx(
            () => AppDropdownField<String>(
              label: AppTexts.adminPropertyFormStatusLabel,
              labelColor: AppColors.white,
              value: controller.status.value,
              items: [
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
              onChanged: (value) {
                if (value != null) {
                  controller.status.value = value;
                }
              },
              errorTextColor: AppColors.white,
            ),
          ),
          AppSpacing.vertical(context, 0.02),
          Obx(
            () => CheckboxListTile(
              title: Text(
                AppTexts.adminPropertyFormIsFeatured,
                style: AppTextStyles.bodyText(
                  context,
                ).copyWith(color: AppColors.white),
              ),
              value: controller.isFeatured.value,
              onChanged: (value) {
                controller.isFeatured.value = value ?? false;
              },
              activeColor: AppColors.primary,
              checkColor: AppColors.white,
            ),
          ),
          Obx(
            () => CheckboxListTile(
              title: Text(
                AppTexts.adminPropertyFormIsPublished,
                style: AppTextStyles.bodyText(
                  context,
                ).copyWith(color: AppColors.white),
              ),
              value: controller.isPublished.value,
              onChanged: (value) {
                controller.isPublished.value = value ?? false;
              },
              activeColor: AppColors.primary,
              checkColor: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}
