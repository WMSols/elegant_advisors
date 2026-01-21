import 'package:flutter/material.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';
import 'package:elegant_advisors/core/utils/app_texts/app_texts.dart';
import 'package:elegant_advisors/core/utils/client_property_filters.dart';
import 'package:elegant_advisors/presentation/client/widgets/properties/filters/client_property_filter_sort_dropdown.dart';
import 'package:elegant_advisors/presentation/client/widgets/properties/filters/client_property_filter_property_type.dart';
import 'package:elegant_advisors/presentation/client/widgets/properties/filters/client_property_filter_location.dart';
import 'package:elegant_advisors/presentation/client/widgets/properties/filters/client_property_filter_price_range.dart';
import 'package:elegant_advisors/presentation/client/widgets/properties/filters/client_property_filter_bedrooms.dart';
import 'package:elegant_advisors/presentation/client/widgets/properties/filters/client_property_filter_bathrooms.dart';
import 'package:elegant_advisors/presentation/client/widgets/properties/filters/client_property_filter_status_chips.dart';
import 'package:elegant_advisors/presentation/client/widgets/properties/filters/client_property_filter_featured.dart';

/// Filter panel widget for properties
class ClientPropertiesFilterPanel extends StatefulWidget {
  final ClientPorpertyFilters filters;
  final Function(ClientPorpertyFilters) onFiltersChanged;
  final PropertySortOption? sortOption;
  final Function(PropertySortOption?) onSortChanged;
  final List<String> availablePropertyTypes;
  final List<String> availableCountries;
  final List<String> availableCities;
  final double? maxPrice;

  const ClientPropertiesFilterPanel({
    super.key,
    required this.filters,
    required this.onFiltersChanged,
    this.sortOption,
    required this.onSortChanged,
    this.availablePropertyTypes = const [],
    this.availableCountries = const [],
    this.availableCities = const [],
    this.maxPrice,
  });

  @override
  State<ClientPropertiesFilterPanel> createState() =>
      _ClientPropertiesFilterPanelState();
}

class _ClientPropertiesFilterPanelState
    extends State<ClientPropertiesFilterPanel> {
  late ClientPorpertyFilters _currentFilters;

  @override
  void initState() {
    super.initState();
    _currentFilters = ClientPorpertyFilters(
      propertyType: widget.filters.propertyType,
      country: widget.filters.country,
      city: widget.filters.city,
      minPrice: widget.filters.minPrice,
      maxPrice: widget.filters.maxPrice,
      minBedrooms: widget.filters.minBedrooms,
      maxBedrooms: widget.filters.maxBedrooms,
      minBathrooms: widget.filters.minBathrooms,
      maxBathrooms: widget.filters.maxBathrooms,
      statuses: List.from(widget.filters.statuses),
      featuredOnly: widget.filters.featuredOnly,
    );
  }

  void _updateFilters() {
    widget.onFiltersChanged(_currentFilters);
  }

  void _clearFilters() {
    setState(() {
      _currentFilters.clear();
    });
    _updateFilters();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(
          AppResponsive.radius(context, factor: 1.5),
        ),
        border: Border.all(color: AppColors.grey.withValues(alpha: 0.2)),
      ),
      child: ExpansionTile(
        initiallyExpanded: false,
        shape: const Border(),
        collapsedShape: const Border(),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppTexts.clientPropertiesFilters,
              style: AppTextStyles.heading(context).copyWith(
                fontSize: AppResponsive.fontSizeClamped(
                  context,
                  min: 18,
                  max: 22,
                ),
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
            ),
            if (_currentFilters.hasActiveFilters)
              TextButton(
                onPressed: _clearFilters,
                child: Text(
                  AppTexts.clientPropertiesClearFilters,
                  style: AppTextStyles.bodyText(context).copyWith(
                    color: AppColors.primary,
                    fontSize: AppResponsive.fontSizeClamped(
                      context,
                      min: 12,
                      max: 14,
                    ),
                  ),
                ),
              ),
          ],
        ),
        backgroundColor: Colors.transparent,
        collapsedBackgroundColor: Colors.transparent,
        children: [
          Padding(
            padding: AppSpacing.all(context, factor: 1.2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Sort By Dropdown
                ClientPropertyFilterSortDropdown(
                  value: widget.sortOption,
                  onChanged: widget.onSortChanged,
                ),
                AppSpacing.vertical(context, 0.02),
                // Property Type
                ClientPropertyFilterPropertyType(
                  value: _currentFilters.propertyType,
                  availableTypes: widget.availablePropertyTypes,
                  onChanged: (value) {
                    setState(() {
                      _currentFilters.propertyType = value;
                    });
                    _updateFilters();
                  },
                ),
                if (widget.availablePropertyTypes.isNotEmpty)
                  AppSpacing.vertical(context, 0.015),
                // Location (Country and City)
                ClientPropertyFilterLocation(
                  country: _currentFilters.country,
                  city: _currentFilters.city,
                  availableCountries: widget.availableCountries,
                  availableCities: widget.availableCities,
                  onCountryChanged: (value) {
                    setState(() {
                      _currentFilters.country = value;
                      if (value == null) {
                        _currentFilters.city = null;
                      }
                    });
                    _updateFilters();
                  },
                  onCityChanged: (value) {
                    setState(() {
                      _currentFilters.city = value;
                    });
                    _updateFilters();
                  },
                ),
                if (widget.availableCountries.isNotEmpty ||
                    widget.availableCities.isNotEmpty)
                  AppSpacing.vertical(context, 0.015),
                // Price Range
                ClientPropertyFilterPriceRange(
                  minPrice: _currentFilters.minPrice,
                  maxPrice: _currentFilters.maxPrice,
                  availableMaxPrice: widget.maxPrice,
                  onMinPriceChanged: (value) {
                    setState(() {
                      _currentFilters.minPrice = value;
                    });
                    _updateFilters();
                  },
                  onMaxPriceChanged: (value) {
                    setState(() {
                      _currentFilters.maxPrice = value;
                    });
                    _updateFilters();
                  },
                ),
                if (widget.maxPrice != null && widget.maxPrice! > 0)
                  AppSpacing.vertical(context, 0.015),
                // Bedrooms
                ClientPropertyFilterBedrooms(
                  minBedrooms: _currentFilters.minBedrooms,
                  maxBedrooms: _currentFilters.maxBedrooms,
                  onMinBedroomsChanged: (value) {
                    setState(() {
                      _currentFilters.minBedrooms = value;
                    });
                    _updateFilters();
                  },
                  onMaxBedroomsChanged: (value) {
                    setState(() {
                      _currentFilters.maxBedrooms = value;
                    });
                    _updateFilters();
                  },
                ),
                AppSpacing.vertical(context, 0.015),
                // Bathrooms
                ClientPropertyFilterBathrooms(
                  minBathrooms: _currentFilters.minBathrooms,
                  maxBathrooms: _currentFilters.maxBathrooms,
                  onMinBathroomsChanged: (value) {
                    setState(() {
                      _currentFilters.minBathrooms = value;
                    });
                    _updateFilters();
                  },
                  onMaxBathroomsChanged: (value) {
                    setState(() {
                      _currentFilters.maxBathrooms = value;
                    });
                    _updateFilters();
                  },
                ),
                AppSpacing.vertical(context, 0.015),
                // Status Chips
                ClientPropertyFilterStatusChips(
                  selectedStatuses: _currentFilters.statuses,
                  onStatusToggled: (status, selected) {
                    setState(() {
                      if (selected) {
                        _currentFilters.statuses.add(status);
                      } else {
                        _currentFilters.statuses.remove(status);
                      }
                    });
                    _updateFilters();
                  },
                ),
                AppSpacing.vertical(context, 0.015),
                // Featured Only
                ClientPropertyFilterFeatured(
                  value: _currentFilters.featuredOnly,
                  onChanged: (value) {
                    setState(() {
                      _currentFilters.featuredOnly = value;
                    });
                    _updateFilters();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
