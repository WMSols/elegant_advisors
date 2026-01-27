import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:elegant_advisors/presentation/client/widgets/properties/filters/client_properties_filter_panel.dart';
import 'package:elegant_advisors/presentation/client/controllers/properties/client_off_market_controller.dart';

/// Responsive filters content widget for Off Market (hides status filter)
class OffMarketFiltersContent extends StatelessWidget {
  final ClientOffMarketController controller;

  const OffMarketFiltersContent({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ClientPropertiesFilterPanel(
        filters: controller.filters.value,
        onFiltersChanged: controller.updateFilters,
        sortOption: controller.sortOption.value,
        onSortChanged: controller.updateSort,
        availablePropertyTypes: controller.availablePropertyTypes,
        availableCountries: controller.availableCountries,
        availableCities: controller.availableCities,
        maxPrice: controller.maxPrice.value,
        hideStatusFilter: true, // Hide status filter since all are off-market
      ),
    );
  }
}
