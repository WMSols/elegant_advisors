import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:elegant_advisors/presentation/client/widgets/properties/filters/client_properties_filter_panel.dart';
import 'package:elegant_advisors/presentation/client/controllers/properties/client_properties_controller.dart';

/// Responsive filters content widget (replaces desktop/mobile duplicates)
class PropertiesFiltersContent extends StatelessWidget {
  final ClientPropertiesController controller;

  const PropertiesFiltersContent({
    super.key,
    required this.controller,
  });

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
      ),
    );
  }
}
