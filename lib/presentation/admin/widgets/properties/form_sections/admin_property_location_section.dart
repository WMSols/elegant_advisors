import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:elegant_advisors/presentation/admin/controllers/properties/admin_property_form_controller.dart';
import 'package:elegant_advisors/presentation/admin/widgets/properties/form_sections/admin_property_form_section.dart';
import 'package:elegant_advisors/core/widgets/forms/app_text_field.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/core/utils/app_texts/app_texts.dart';
import 'package:elegant_advisors/presentation/admin/widgets/properties/map/admin_property_map_picker.dart';

class AdminPropertyLocationSection
    extends GetView<AdminPropertyFormController> {
  const AdminPropertyLocationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return AdminPropertyFormSection(
      title: AppTexts.adminPropertyFormLocation,
      child: Column(
        children: [
          AppTextField(
            label: AppTexts.adminPropertyFormCountryLabel,
            hint: AppTexts.adminPropertyFormCountryHint,
            controller: controller.countryController,
            textInputAction: TextInputAction.next,
            prefixIcon: const Icon(Iconsax.global),
            errorTextColor: AppColors.white,
            validator: controller.validateCountry,
            maxLines: 1,
            isAdmin: true,
          ),
          AppSpacing.vertical(context, 0.02),
          AppTextField(
            label: AppTexts.adminPropertyFormCityLabel,
            hint: AppTexts.adminPropertyFormCityHint,
            controller: controller.cityController,
            textInputAction: TextInputAction.next,
            prefixIcon: const Icon(Iconsax.building),
            errorTextColor: AppColors.white,
            validator: controller.validateCity,
            maxLines: 1,
            isAdmin: true,
          ),
          AppSpacing.vertical(context, 0.02),
          AppTextField(
            label: AppTexts.adminPropertyFormAreaLabel,
            hint: AppTexts.adminPropertyFormAreaHint,
            controller: controller.areaController,
            textInputAction: TextInputAction.next,
            prefixIcon: const Icon(Icons.location_pin),
            errorTextColor: AppColors.white,
            validator: controller.validateArea,
            maxLines: 1,
            isAdmin: true,
          ),
          AppSpacing.vertical(context, 0.02),
          AppTextField(
            label: AppTexts.adminPropertyFormAddressLabel,
            hint: AppTexts.adminPropertyFormAddressHint,
            controller: controller.addressController,
            textInputAction: TextInputAction.next,
            maxLines: null, // Expandable, starts as 1 line
            minLines: 1,
            prefixIcon: const Icon(Iconsax.map),
            errorTextColor: AppColors.white,
            validator: controller.validateAddress,
            isAdmin: true,
          ),
          AppSpacing.vertical(context, 0.02),
          // Map Picker
          AdminPropertyMapPicker(
            onLocationSelected: (lat, lng) {
              controller.setLocationCoordinates(lat, lng);
            },
            initialLat: controller.locationLat.value,
            initialLng: controller.locationLng.value,
          ),
        ],
      ),
    );
  }
}
