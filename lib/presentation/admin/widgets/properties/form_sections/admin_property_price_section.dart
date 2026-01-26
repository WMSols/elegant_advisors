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
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';

class AdminPropertyPriceSection extends GetView<AdminPropertyFormController> {
  const AdminPropertyPriceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return AdminPropertyFormSection(
      title: AppTexts.adminPropertyFormPrice,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: AppTextField(
                  label: AppTexts.adminPropertyFormPriceAmountLabel,
                  hint: AppTexts.adminPropertyFormPriceAmountHint,
                  controller: controller.priceAmountController,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  prefixIcon: const Icon(Iconsax.dollar_circle),
                  errorTextColor: AppColors.white,
                  validator: controller.validatePrice,
                  enabled: !controller.isOnRequest.value,
                  maxLines: 1,
                  isAdmin: true,
                ),
              ),
              AppSpacing.horizontal(context, 0.01),
              Expanded(
                child: Obx(
                  () => AppDropdownField<String>(
                    label: AppTexts.adminPropertyFormCurrencyLabel,
                    labelColor: AppColors.white,
                    value: controller.currency.value,
                    items: [
                      DropdownMenuItem(
                        value: 'EUR',
                        child: Text(AppTexts.adminPropertyFormCurrencyEUR),
                      ),
                      DropdownMenuItem(
                        value: 'GBP',
                        child: Text(AppTexts.adminPropertyFormCurrencyGBP),
                      ),
                      DropdownMenuItem(
                        value: 'USD',
                        child: Text(AppTexts.adminPropertyFormCurrencyUSD),
                      ),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        controller.currency.value = value;
                      }
                    },
                    errorTextColor: AppColors.white,
                    isAdmin: true,
                  ),
                ),
              ),
            ],
          ),
          AppSpacing.vertical(context, 0.02),
          Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CheckboxListTile(
                  title: Text(
                    AppTexts.adminPropertyFormPriceOnRequest,
                    style: AppTextStyles.bodyText(
                      context,
                    ).copyWith(color: AppColors.white),
                  ),
                  value: controller.isOnRequest.value,
                  onChanged: (value) {
                    controller.isOnRequest.value = value ?? false;
                  },
                  activeColor: AppColors.primary,
                  checkColor: AppColors.white,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: AppResponsive.scaleSize(
                      context,
                      48,
                      min: 40,
                      max: 56,
                    ),
                    top: AppResponsive.scaleSize(context, 4, min: 2, max: 8),
                  ),
                  child: Text(
                    'When enabled, the property price will be displayed as "Price on Request" instead of a specific amount. This is useful for exclusive properties where pricing is negotiated privately.',
                    style: AppTextStyles.bodyText(context).copyWith(
                      color: AppColors.white.withValues(alpha: 0.7),
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
