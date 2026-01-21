import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';
import 'package:elegant_advisors/core/utils/app_texts/app_texts.dart';
import 'package:elegant_advisors/core/utils/app_validators/app_validators.dart';
import 'package:elegant_advisors/core/widgets/buttons/app_button.dart';
import 'package:elegant_advisors/core/widgets/forms/app_text_field.dart';
import 'package:elegant_advisors/presentation/client/controllers/contact/client_contact_controller.dart';

/// Contact form section
class ContactFormSection extends StatelessWidget {
  const ContactFormSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ClientContactController>();

    return Form(
      key: controller.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppTexts.contactFormTitle,
            style: AppTextStyles.heading(
              context,
            ).copyWith(color: AppColors.white),
          ),
          AppSpacing.vertical(context, 0.02),
          AppTextField(
            label: AppTexts.contactFormName,
            controller: controller.nameController,
            errorTextColor: AppColors.white,
            validator: AppValidators.validateName,
          ),
          AppSpacing.vertical(context, 0.02),
          AppTextField(
            label: AppTexts.contactFormEmail,
            controller: controller.emailController,
            keyboardType: TextInputType.emailAddress,
            errorTextColor: AppColors.white,
            validator: AppValidators.validateEmail,
          ),
          AppSpacing.vertical(context, 0.02),
          AppTextField(
            label: AppTexts.contactFormPhone,
            controller: controller.phoneController,
            keyboardType: TextInputType.phone,
            errorTextColor: AppColors.white,
            validator: AppValidators.validatePhone,
          ),
          AppSpacing.vertical(context, 0.02),
          AppTextField(
            label: AppTexts.contactFormMessage,
            controller: controller.messageController,
            errorTextColor: AppColors.white,
            minLines: 2,
            maxLines: 5,
            validator: AppValidators.validateMessage,
          ),
          AppSpacing.vertical(context, 0.03),
          Obx(
            () => AppButton(
              text: AppTexts.contactFormButton,
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
