import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/presentation/client/widgets/properties/listing/client_properties_grid.dart';
import 'package:elegant_advisors/presentation/client/widgets/properties/listing/client_properties_pagination.dart';
import 'package:elegant_advisors/presentation/client/widgets/properties/states/client_properties_empty_state.dart';
import 'package:elegant_advisors/presentation/client/widgets/properties/states/client_properties_error_state.dart';
import 'package:elegant_advisors/core/widgets/feedback/app_loading_indicator.dart';
import 'package:elegant_advisors/presentation/client/controllers/properties/client_properties_controller.dart';

/// Responsive listing content widget (replaces desktop/mobile duplicates)
class PropertiesListingContent extends StatelessWidget {
  final ClientPropertiesController controller;

  const PropertiesListingContent({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isLoading = controller.isLoadingProperties.value;
      final errorMsg = controller.errorMessage.value;
      final displayedCount = controller.displayedProperties.length;

      if (isLoading) {
        return SizedBox(
          height: AppResponsive.screenHeight(context) * 0.5,
          child: const Center(
            child: AppLoadingIndicator(),
          ),
        );
      }

      if (errorMsg.isNotEmpty) {
        return ClientPropertiesErrorState(
          errorMessage: errorMsg,
          onRetry: controller.loadProperties,
        );
      }

      if (displayedCount == 0) {
        return ClientPropertiesEmptyState(
          onClearFilters: controller.filters.value.hasActiveFilters
              ? () {
                  controller.filters.value.clear();
                  controller.updateFilters(controller.filters.value);
                }
              : null,
        );
      }

      return Column(
        children: [
          ClientPropertiesGrid(
            properties: controller.displayedProperties,
          ),
          AppSpacing.vertical(context, 0.04),
          ClientPropertiesPagination(
            currentPage: controller.currentPage.value,
            totalPages: controller.totalPages,
            totalItems: controller.filteredProperties.length,
            itemsPerPage: controller.itemsPerPage,
            onPageChanged: controller.goToPage,
          ),
        ],
      );
    });
  }
}
