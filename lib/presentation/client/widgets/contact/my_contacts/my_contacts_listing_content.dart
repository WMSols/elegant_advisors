import 'package:elegant_advisors/core/utils/app_validators/app_validators.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';
import 'package:elegant_advisors/core/utils/app_helpers/language/app_localizations_helper.dart';
import 'package:elegant_advisors/core/widgets/buttons/app_button.dart';
import 'package:elegant_advisors/core/widgets/forms/app_text_field.dart';
import 'package:elegant_advisors/core/widgets/feedback/app_loading_indicator.dart';
import 'package:elegant_advisors/presentation/client/controllers/contact/my_contacts/client_my_contacts_controller.dart';
import 'package:elegant_advisors/presentation/client/widgets/contact/my_contacts/client_my_contact_card.dart';
import 'package:elegant_advisors/presentation/client/widgets/contact/my_contacts/client_my_contacts_filter_chips.dart';
import 'package:elegant_advisors/core/widgets/feedback/app_empty_state.dart';
import 'package:elegant_advisors/core/widgets/feedback/app_error_state.dart';

/// My contacts listing content section
class MyContactsListingContent extends StatelessWidget {
  const MyContactsListingContent({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ClientMyContactsController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Email Input Section (if no email set)
        Obx(
          () => controller.userEmail.value == null
              ? _buildEmailInputSection(context, controller)
              : _buildContactsSection(context, controller),
        ),
      ],
    );
  }

  Widget _buildEmailInputSection(
    BuildContext context,
    ClientMyContactsController controller,
  ) {
    final isMobile = AppResponsive.isMobile(context);

    return Form(
      key: controller.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.myContactsEnterEmail,
            style: AppTextStyles.heading(context).copyWith(
              color: AppColors.white,
              fontSize: AppResponsive.fontSizeClamped(
                context,
                min: 20,
                max: 24,
              ),
            ),
          ),
          AppSpacing.vertical(context, 0.03),
          SizedBox(
            width: isMobile
                ? double.infinity
                : AppResponsive.screenWidth(context) * 0.5,
            child: AppTextField(
              label: context.l10n.myContactsEnterEmailHint,
              controller: controller.emailController,
              keyboardType: TextInputType.emailAddress,
              errorTextColor: AppColors.white,
              validator: AppValidators.validateEmail,
            ),
          ),
          AppSpacing.vertical(context, 0.03),
          Obx(
            () => AppButton(
              text: context.l10n.myContactsViewContacts,
              isLoading: controller.isLoading.value,
              onPressed: controller.viewContacts,
              backgroundColor: AppColors.white,
              textColor: AppColors.primary,
              width: isMobile
                  ? double.infinity
                  : AppResponsive.screenWidth(context) * 0.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactsSection(
    BuildContext context,
    ClientMyContactsController controller,
  ) {
    final isMobile = AppResponsive.isMobile(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Filters Section
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              context.l10n.myContactsFilters,
              style: AppTextStyles.heading(context).copyWith(
                color: AppColors.white,
                fontSize: AppResponsive.fontSizeClamped(
                  context,
                  min: 18,
                  max: 22,
                ),
              ),
            ),
            if (!isMobile)
              Obx(
                () => controller.selectedStatus.value != 'all'
                    ? TextButton(
                        onPressed: controller.clearFilters,
                        child: Text(
                          context.l10n.myContactsClearFilters,
                          style: AppTextStyles.bodyText(context).copyWith(
                            color: AppColors.white,
                            fontSize: AppResponsive.fontSizeClamped(
                              context,
                              min: 12,
                              max: 14,
                            ),
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
          ],
        ),
        AppSpacing.vertical(context, 0.02),
        const ClientMyContactsFilterChips(),
        if (isMobile)
          Obx(
            () => controller.selectedStatus.value != 'all'
                ? Padding(
                    padding: EdgeInsets.only(
                      top: AppSpacing.vertical(context, 0.02).height ?? 16,
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: controller.clearFilters,
                        child: Text(
                          context.l10n.myContactsClearFilters,
                          style: AppTextStyles.bodyText(context).copyWith(
                            color: AppColors.white,
                            fontSize: AppResponsive.fontSizeClamped(
                              context,
                              min: 12,
                              max: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        AppSpacing.vertical(context, 0.04),
        // Contacts List
        Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: AppLoadingIndicator());
          }

          if (controller.hasError.value) {
            return AppErrorState(
              title: context.l10n.myContactsErrorLoading,
              onRetry: controller.refreshContacts,
              retryButtonText: context.l10n.myContactsRetry,
              titleColor: AppColors.white,
              buttonBackgroundColor: AppColors.primary,
              buttonTextColor: AppColors.white,
            );
          }

          if (controller.contacts.isEmpty) {
            return AppEmptyState(
              title: context.l10n.myContactsNoContactsFound,
              titleColor: AppColors.white,
              message: context.l10n.myContactsNoContactsMessage,
              messageColor: AppColors.white,
            );
          }

          return Column(
            children: [
              ...controller.contacts.map(
                (contact) => ClientMyContactCard(contact: contact),
              ),
            ],
          );
        }),
      ],
    );
  }
}
