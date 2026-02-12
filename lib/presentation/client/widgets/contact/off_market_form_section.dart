import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';
import 'package:elegant_advisors/core/utils/app_helpers/language/app_localizations_helper.dart';
import 'package:elegant_advisors/core/utils/app_validators/app_validators.dart';
import 'package:elegant_advisors/core/widgets/buttons/app_button.dart';
import 'package:elegant_advisors/core/widgets/forms/app_text_field.dart';
import 'package:elegant_advisors/presentation/client/controllers/properties/client_off_market_controller.dart';

/// Off Market request form section (same design as contact form, different fields)
class OffMarketFormSection extends StatelessWidget {
  const OffMarketFormSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ClientOffMarketController>();

    return Form(
      key: controller.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.offMarketFormTitle,
            style: AppTextStyles.heading(
              context,
            ).copyWith(color: AppColors.white),
          ),
          AppSpacing.vertical(context, 0.02),
          AppTextField(
            label: context.l10n.offMarketFormName,
            controller: controller.nameController,
            errorTextColor: AppColors.white,
            validator: AppValidators.validateName,
          ),
          AppSpacing.vertical(context, 0.02),
          AppTextField(
            label: context.l10n.offMarketFormEmail,
            controller: controller.emailController,
            keyboardType: TextInputType.emailAddress,
            errorTextColor: AppColors.white,
            validator: AppValidators.validateEmail,
          ),
          AppSpacing.vertical(context, 0.02),
          AppTextField(
            label: context.l10n.offMarketFormPhone,
            controller: controller.phoneController,
            keyboardType: TextInputType.phone,
            errorTextColor: AppColors.white,
            validator: AppValidators.validatePhone,
          ),
          AppSpacing.vertical(context, 0.02),
          AppTextField(
            label: context.l10n.offMarketFormMessage,
            hint: context.l10n.offMarketFormMessageHint,
            controller: controller.messageController,
            errorTextColor: AppColors.white,
            minLines: 2,
            maxLines: 5,
            validator: AppValidators.validateMessage,
          ),
          AppSpacing.vertical(context, 0.03),
          Obx(
            () => AppButton(
              text: context.l10n.offMarketFormButton,
              isLoading: controller.isLoading.value,
              onPressed: controller.submitForm,
              width: AppResponsive.screenWidth(context) * 0.7,
              backgroundColor: AppColors.white,
              textColor: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}
