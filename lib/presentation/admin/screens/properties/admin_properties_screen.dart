import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:elegant_advisors/core/utils/app_texts/app_texts.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';
import 'package:elegant_advisors/presentation/admin/controllers/properties/admin_properties_controller.dart';
import 'package:elegant_advisors/presentation/admin/widgets/layout/admin_layout.dart';
import 'package:elegant_advisors/core/widgets/feedback/app_loading_indicator.dart';
import 'package:elegant_advisors/core/widgets/buttons/app_button.dart';
import 'package:elegant_advisors/presentation/admin/widgets/properties/filters/admin_property_search_and_filters.dart';
import 'package:elegant_advisors/presentation/admin/widgets/properties/cards/admin_property_card.dart';
import 'package:elegant_advisors/presentation/admin/widgets/admins/states/admin_empty_state.dart';

class AdminPropertiesScreen extends GetView<AdminPropertiesController> {
  const AdminPropertiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AdminLayout(
      title: AppTexts.adminNavProperties,
      child: Padding(
        padding: AppSpacing.all(context, factor: 1.2),
        child: Obx(() {
          if (controller.isLoading.value && controller.properties.isEmpty) {
            return const Center(
              child: AppLoadingIndicator(
                variant: LoadingIndicatorVariant.white,
              ),
            );
          }

          // Access deletingPropertyId here to make it reactive in this Obx scope
          final deletingPropertyId = controller.deletingPropertyId.value;
          final filteredProperties = controller.filteredProperties;

          if (controller.properties.isEmpty) {
            return AdminEmptyState(
              message: AppTexts.adminPropertiesNoPropertiesFound,
              buttonText: AppTexts.adminPropertiesCreateFirstProperty,
              onButtonPressed: controller.navigateToAddProperty,
            );
          }

          return Column(
            children: [
              // Search and Filters Section
              const AdminPropertySearchAndFilters(),
              AppSpacing.vertical(context, 0.02),
              // Create New Property Button
              Align(
                alignment: Alignment.centerRight,
                child: AppButton(
                  text: AppTexts.adminPropertiesCreateNewProperty,
                  onPressed: controller.navigateToAddProperty,
                  backgroundColor: AppColors.white,
                ),
              ),
              AppSpacing.vertical(context, 0.02),
              // Properties List
              Expanded(
                child: filteredProperties.isEmpty
                    ? Center(
                        child: Text(
                          AppTexts.adminPropertiesNoMatchFound,
                          style: AppTextStyles.bodyText(
                            context,
                          ).copyWith(color: AppColors.white),
                        ),
                      )
                    : ListView.builder(
                        itemCount: filteredProperties.length,
                        itemBuilder: (context, index) {
                          final property = filteredProperties[index];
                          final isDeleting = deletingPropertyId == property.id;
                          return AdminPropertyCard(
                            property: property,
                            onEdit: () =>
                                controller.navigateToEditProperty(property.id!),
                            onDelete: () =>
                                controller.deleteProperty(property.id!),
                            onTogglePublish: () =>
                                controller.togglePropertyStatus(
                                  property.id!,
                                  property.isPublished,
                                ),
                            isDeleting: isDeleting,
                          );
                        },
                      ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
