import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:elegant_advisors/core/utils/app_texts/app_texts.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/presentation/admin/controllers/admins/admin_manage_admins_controller.dart';
import 'package:elegant_advisors/presentation/admin/widgets/layout/admin_layout.dart';
import 'package:elegant_advisors/core/widgets/feedback/app_loading_indicator.dart';
import 'package:elegant_advisors/core/widgets/buttons/app_button.dart';
import 'package:elegant_advisors/presentation/admin/widgets/admins/filters/admin_filters.dart';
import 'package:elegant_advisors/presentation/admin/widgets/admins/cards/admin_admin_card.dart';
import 'package:elegant_advisors/core/widgets/feedback/app_empty_state.dart';
import 'package:elegant_advisors/core/widgets/forms/app_search_field.dart';

class AdminManageAdminsScreen extends GetView<AdminManageAdminsController> {
  const AdminManageAdminsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AdminLayout(
      title: AppTexts.adminNavManageAdmins,
      child: Padding(
        padding: AppSpacing.all(context, factor: 1.2),
        child: Obx(() {
          if (controller.isLoading.value && controller.admins.isEmpty) {
            return const Center(
              child: AppLoadingIndicator(
                variant: LoadingIndicatorVariant.white,
              ),
            );
          }

          // Access deletingAdminId here to make it reactive in this Obx scope
          final deletingAdminId = controller.deletingAdminId.value;
          final filteredAdmins = controller.filteredAdmins;

          if (controller.admins.isEmpty) {
            return AppEmptyState(
              message: AppTexts.adminManageAdminsNoAdminsFound,
              buttonText: AppTexts.adminManageAdminsCreateFirstAdmin,
              onButtonPressed: controller.navigateToCreateAdmin,
              messageColor: AppColors.white,
              buttonBackgroundColor: AppColors.white,
              showImage: false,
              centerContent: true,
            );
          }

          return Column(
            children: [
              // Search Field (Static)
              AppSearchField(
                controller: controller.searchController,
                hint: AppTexts.adminManageAdminsSearchHint,
                onFieldSubmitted: controller.updateSearchQuery,
                isAdmin: true,
              ),
              AppSpacing.vertical(context, 0.02),
              // Scrollable Content: Filters, Button, and Cards
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Filters Section
                      const AdminFilters(),
                      AppSpacing.vertical(context, 0.02),
                      // Create New Admin Button
                      Align(
                        alignment: Alignment.centerRight,
                        child: AppButton(
                          text: AppTexts.adminManageAdminsCreateNewAdmin,
                          onPressed: controller.navigateToCreateAdmin,
                          backgroundColor: AppColors.white,
                          isAdmin: true,
                        ),
                      ),
                      AppSpacing.vertical(context, 0.02),
                      // Admins List
                      filteredAdmins.isEmpty
                          ? AppEmptyState(
                              message: AppTexts.adminManageAdminsNoMatchFound,
                              messageColor: AppColors.white,
                              showImage: false,
                              centerContent: true,
                            )
                          : Column(
                              children: filteredAdmins.map((admin) {
                                final isDeleting = deletingAdminId == admin.id;
                                return AdminAdminCard(
                                  admin: admin,
                                  onEdit: () =>
                                      controller.navigateToEditAdmin(admin.id!),
                                  onDelete: () =>
                                      controller.deleteAdmin(admin.id!),
                                  isDeleting: isDeleting,
                                );
                              }).toList(),
                            ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
