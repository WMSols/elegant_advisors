import 'package:flutter/material.dart';
import 'package:elegant_advisors/core/utils/app_helpers/language/app_localizations_helper.dart';

/// Property filter model and helper class
class ClientPropertyFilters {
  String? propertyType;
  String? country;
  String? city;
  double? minPrice;
  double? maxPrice;
  int? minBedrooms;
  int? maxBedrooms;
  int? minBathrooms;
  int? maxBathrooms;
  List<String> statuses; // available, sold, coming_soon, off_market
  bool featuredOnly;

  ClientPropertyFilters({
    this.propertyType,
    this.country,
    this.city,
    this.minPrice,
    this.maxPrice,
    this.minBedrooms,
    this.maxBedrooms,
    this.minBathrooms,
    this.maxBathrooms,
    this.statuses = const [],
    this.featuredOnly = false,
  });

  ClientPropertyFilters copyWith({
    String? propertyType,
    String? country,
    String? city,
    double? minPrice,
    double? maxPrice,
    int? minBedrooms,
    int? maxBedrooms,
    int? minBathrooms,
    int? maxBathrooms,
    List<String>? statuses,
    bool? featuredOnly,
  }) {
    return ClientPropertyFilters(
      propertyType: propertyType ?? this.propertyType,
      country: country ?? this.country,
      city: city ?? this.city,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      minBedrooms: minBedrooms ?? this.minBedrooms,
      maxBedrooms: maxBedrooms ?? this.maxBedrooms,
      minBathrooms: minBathrooms ?? this.minBathrooms,
      maxBathrooms: maxBathrooms ?? this.maxBathrooms,
      statuses: statuses ?? this.statuses,
      featuredOnly: featuredOnly ?? this.featuredOnly,
    );
  }

  void clear() {
    propertyType = null;
    country = null;
    city = null;
    minPrice = null;
    maxPrice = null;
    minBedrooms = null;
    maxBedrooms = null;
    minBathrooms = null;
    maxBathrooms = null;
    statuses = [];
    featuredOnly = false;
  }

  bool get hasActiveFilters {
    return propertyType != null ||
        country != null ||
        city != null ||
        minPrice != null ||
        maxPrice != null ||
        minBedrooms != null ||
        maxBedrooms != null ||
        minBathrooms != null ||
        maxBathrooms != null ||
        statuses.isNotEmpty ||
        featuredOnly;
  }
}

/// Property sort options
enum PropertySortOption {
  priceLowHigh,
  priceHighLow,
  newestFirst,
  featuredFirst,
  alphabetical,
}

extension PropertySortOptionExtension on PropertySortOption {
  /// Get localized display name for sort option
  /// Requires BuildContext to access translations
  String getDisplayName(BuildContext context) {
    switch (this) {
      case PropertySortOption.priceLowHigh:
        return context.l10n.clientPropertiesSortPriceLowHigh;
      case PropertySortOption.priceHighLow:
        return context.l10n.clientPropertiesSortPriceHighLow;
      case PropertySortOption.newestFirst:
        return context.l10n.clientPropertiesSortNewest;
      case PropertySortOption.featuredFirst:
        return context.l10n.clientPropertiesSortFeatured;
      case PropertySortOption.alphabetical:
        return context.l10n.clientPropertiesSortAlphabetical;
    }
  }
}
