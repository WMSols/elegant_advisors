/// Property filter model and helper class
class ClientPorpertyFilters {
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

  ClientPorpertyFilters({
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

  ClientPorpertyFilters copyWith({
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
    return ClientPorpertyFilters(
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
  String get displayName {
    switch (this) {
      case PropertySortOption.priceLowHigh:
        return 'Price: Low to High';
      case PropertySortOption.priceHighLow:
        return 'Price: High to Low';
      case PropertySortOption.newestFirst:
        return 'Newest First';
      case PropertySortOption.featuredFirst:
        return 'Featured First';
      case PropertySortOption.alphabetical:
        return 'Alphabetical';
    }
  }
}
