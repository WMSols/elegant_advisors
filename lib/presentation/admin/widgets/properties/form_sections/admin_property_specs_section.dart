import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:elegant_advisors/presentation/admin/controllers/properties/admin_property_form_controller.dart';
import 'package:elegant_advisors/presentation/admin/widgets/properties/form_sections/admin_property_form_section.dart';
import 'package:elegant_advisors/core/widgets/forms/app_text_field.dart';
import 'package:elegant_advisors/core/widgets/forms/app_dropdown_field.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/core/utils/app_texts/app_texts.dart';

class AdminPropertySpecsSection extends GetView<AdminPropertyFormController> {
  const AdminPropertySpecsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return AdminPropertyFormSection(
      title: AppTexts.adminPropertyFormSpecs,
      child: Column(
        children: [
          AppTextField(
            label: AppTexts.adminPropertyFormPropertyTypeLabel,
            hint: AppTexts.adminPropertyFormPropertyTypeHint,
            controller: controller.propertyTypeController,
            textInputAction: TextInputAction.next,
            prefixIcon: const Icon(Iconsax.home_2),
            errorTextColor: AppColors.white,
            validator: controller.validatePropertyType,
            maxLines: 1,
          ),
          AppSpacing.vertical(context, 0.02),
          Row(
            children: [
              Expanded(
                child: AppTextField(
                  label: AppTexts.adminPropertyFormBedroomsLabel,
                  hint: AppTexts.adminPropertyFormBedroomsHint,
                  controller: controller.bedroomsController,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  prefixIcon: Icon(Iconsax.home_2),
                  errorTextColor: AppColors.white,
                  validator: controller.validateBedrooms,
                  maxLines: 1,
                ),
              ),
              AppSpacing.horizontal(context, 0.01),
              Expanded(
                child: AppTextField(
                  label: AppTexts.adminPropertyFormBathroomsLabel,
                  hint: AppTexts.adminPropertyFormBathroomsHint,
                  controller: controller.bathroomsController,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  prefixIcon: Icon(Iconsax.building),
                  errorTextColor: AppColors.white,
                  validator: controller.validateBathrooms,
                  maxLines: 1,
                ),
              ),
            ],
          ),
          AppSpacing.vertical(context, 0.02),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: AppTextField(
                  label: AppTexts.adminPropertyFormAreaSizeLabel,
                  hint: AppTexts.adminPropertyFormAreaSizeHint,
                  controller: controller.areaSizeController,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  prefixIcon: const Icon(Iconsax.ruler),
                  errorTextColor: AppColors.white,
                  validator: controller.validateAreaSize,
                  maxLines: 1,
                ),
              ),
              AppSpacing.horizontal(context, 0.01),
              Expanded(
                child: Obx(
                  () => AppDropdownField<String>(
                    label: AppTexts.adminPropertyFormAreaUnitLabel,
                    value: controller.areaUnit.value,
                    items: [
                      DropdownMenuItem(
                        value: 'sqm',
                        child: Text(AppTexts.adminPropertyFormSqm),
                      ),
                      DropdownMenuItem(
                        value: 'sqft',
                        child: Text(AppTexts.adminPropertyFormSqft),
                      ),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        controller.areaUnit.value = value;
                      }
                    },
                    errorTextColor: AppColors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
