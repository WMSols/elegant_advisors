import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';
import 'package:elegant_advisors/core/utils/app_texts/app_texts.dart';
import 'package:elegant_advisors/core/utils/app_validators/app_validators.dart';
import 'package:elegant_advisors/core/widgets/buttons/app_button.dart';
import 'package:elegant_advisors/core/widgets/forms/app_text_field.dart';
import 'package:elegant_advisors/presentation/client/widgets/layout/app_footer.dart';
import 'package:elegant_advisors/presentation/client/widgets/layout/app_header.dart';
import 'package:elegant_advisors/presentation/client/controllers/contact/client_contact_controller.dart';

class ClientContactScreen extends GetView<ClientContactController> {
  const ClientContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AppHeader(),
            Container(
              width: double.infinity,
              padding: AppSpacing.symmetric(context, h: 0.04, v: 0.08),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppTexts.contactTitle,
                    style: AppTextStyles.headline(context),
                  ),
                  AppSpacing.vertical(context, 0.04),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      if (constraints.maxWidth >= 768) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: _buildContactForm(context),
                            ),
                            AppSpacing.horizontal(context, 0.04),
                            Expanded(
                              flex: 1,
                              child: _buildOfficeDetails(context),
                            ),
                          ],
                        );
                      } else {
                        return Column(
                          children: [
                            _buildContactForm(context),
                            AppSpacing.vertical(context, 0.04),
                            _buildOfficeDetails(context),
                          ],
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
            const AppFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildContactForm(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppTexts.contactFormTitle,
            style: AppTextStyles.heading(context),
          ),
          AppSpacing.vertical(context, 0.02),
          AppTextField(
            label: AppTexts.contactFormName,
            controller: controller.nameController,
            validator: AppValidators.validateName,
          ),
          AppSpacing.vertical(context, 0.02),
          AppTextField(
            label: AppTexts.contactFormEmail,
            controller: controller.emailController,
            keyboardType: TextInputType.emailAddress,
            validator: AppValidators.validateEmail,
          ),
          AppSpacing.vertical(context, 0.02),
          AppTextField(
            label: AppTexts.contactFormPhone,
            controller: controller.phoneController,
            keyboardType: TextInputType.phone,
            validator: (value) => AppValidators.validateRequired(
              value,
              AppTexts.contactFormPhone,
            ),
          ),
          AppSpacing.vertical(context, 0.02),
          AppTextField(
            label: AppTexts.contactFormMessage,
            controller: controller.messageController,
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
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOfficeDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppTexts.contactOfficeTitle,
          style: AppTextStyles.heading(context),
        ),
        AppSpacing.vertical(context, 0.02),
        _buildInfoItem(
          context,
          icon: Icons.location_pin,
          title: AppTexts.contactOfficeAddress,
          value: AppTexts.contactOfficeAddressValue,
        ),
        AppSpacing.vertical(context, 0.02),
        _buildInfoItem(
          context,
          icon: Iconsax.call,
          title: AppTexts.contactOfficePhone,
          value: AppTexts.contactOfficePhoneValue,
        ),
        AppSpacing.vertical(context, 0.02),
        _buildInfoItem(
          context,
          icon: Iconsax.sms,
          title: AppTexts.contactOfficeEmail,
          value: AppTexts.contactOfficeEmailValue,
        ),
        AppSpacing.vertical(context, 0.02),
        _buildInfoItem(
          context,
          icon: Iconsax.clock,
          title: AppTexts.contactOfficeHours,
          value: AppTexts.contactOfficeHoursValue,
        ),
      ],
    );
  }

  Widget _buildInfoItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: AppColors.primary),
        AppSpacing.horizontal(context, 0.02),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyles.bodyText(
                  context,
                ).copyWith(fontWeight: FontWeight.bold),
              ),
              Text(value, style: AppTextStyles.bodyText(context)),
            ],
          ),
        ),
      ],
    );
  }
}
