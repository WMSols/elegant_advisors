import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:elegant_advisors/data/services/firestore_service.dart';
import 'package:elegant_advisors/data/services/analytics_service.dart';
import 'package:elegant_advisors/domain/models/property_model.dart';
import 'package:elegant_advisors/core/base/base_controller/app_base_controller.dart';
import 'package:elegant_advisors/core/utils/app_property_filters.dart';
import 'package:elegant_advisors/core/utils/app_pagination_helper.dart';

class ClientPropertiesController extends BaseController {
  final FirestoreService _firestoreService = FirestoreService();
  final AnalyticsService _analyticsService = AnalyticsService();

  // Data
  final allProperties = <PropertyModel>[].obs;
  final filteredProperties = <PropertyModel>[].obs;
  final displayedProperties = <PropertyModel>[].obs;
  final featuredProperties = <PropertyModel>[].obs;
  
  // State
  final isLoadingProperties = false.obs;
  @override
  final errorMessage = ''.obs;
  final scrollController = ScrollController();
  final showHeader = false.obs;
  final GlobalKey listingSectionKey = GlobalKey();
  
  // Stream subscription
  StreamSubscription<List<PropertyModel>>? _propertiesSubscription;
  
  // Filters & Sort
  final filters = PropertyFilters().obs;
  final sortOption = Rxn<PropertySortOption>();
  
  // Pagination
  final currentPage = 1.obs;
  final itemsPerPage = 12;
  
  // Available filter options
  final availablePropertyTypes = <String>[].obs;
  final availableCountries = <String>[].obs;
  final availableCities = <String>[].obs;
  final maxPrice = Rxn<double>();

  @override
  void onInit() {
    super.onInit();
    _setupScrollListener();
    loadProperties();
  }

  void _setupScrollListener() {
    scrollController.addListener(() {
      // Show header background when scrolled down
      if (scrollController.offset > 100) {
        if (!showHeader.value) {
          showHeader.value = true;
        }
      } else {
        if (showHeader.value) {
          showHeader.value = false;
        }
      }
    });
  }

  @override
  void onClose() {
    _propertiesSubscription?.cancel();
    scrollController.dispose();
    super.onClose();
  }

  Future<void> loadProperties() async {
    isLoadingProperties.value = true;
    errorMessage.value = '';
    
    // Cancel existing subscription if any
    await _propertiesSubscription?.cancel();
    
    try {
      // Use stream for real-time updates
      _propertiesSubscription = _firestoreService.getPublishedProperties().listen(
        (fetchedProperties) {
          allProperties.value = fetchedProperties;
          _extractFilterOptions();
          applyFilters();
          isLoadingProperties.value = false;
          update(); // Notify GetBuilder to rebuild
        },
        onError: (error) {
          errorMessage.value = 'Failed to load properties: ${error.toString()}';
          showError('Failed to load properties');
          isLoadingProperties.value = false;
        },
      );
    } catch (e) {
      errorMessage.value = 'Failed to load properties: ${e.toString()}';
      showError('Failed to load properties');
      isLoadingProperties.value = false;
    }
  }

  void _extractFilterOptions() {
    final propertyTypes = <String>{};
    final countries = <String>{};
    final cities = <String>{};
    double? maxPriceValue;

    for (final property in allProperties) {
      if (property.specs.propertyType.isNotEmpty) {
        propertyTypes.add(property.specs.propertyType);
      }
      if (property.location.country.isNotEmpty) {
        countries.add(property.location.country);
      }
      if (property.location.city.isNotEmpty) {
        cities.add(property.location.city);
      }
      if (property.price.amount != null) {
        if (maxPriceValue == null || property.price.amount! > maxPriceValue) {
          maxPriceValue = property.price.amount;
        }
      }
    }

    availablePropertyTypes.value = propertyTypes.toList()..sort();
    availableCountries.value = countries.toList()..sort();
    availableCities.value = cities.toList()..sort();
    maxPrice.value = maxPriceValue;
  }

  void applyFilters() {
    var filtered = List<PropertyModel>.from(allProperties);

    // Apply filters
    final currentFilters = filters.value;
    
    if (currentFilters.propertyType != null) {
      filtered = filtered.where((p) =>
          p.specs.propertyType == currentFilters.propertyType).toList();
    }

    if (currentFilters.country != null) {
      filtered = filtered.where((p) =>
          p.location.country == currentFilters.country).toList();
    }

    if (currentFilters.city != null) {
      filtered = filtered.where((p) =>
          p.location.city == currentFilters.city).toList();
    }

    if (currentFilters.minPrice != null) {
      filtered = filtered.where((p) =>
          p.price.amount != null &&
          p.price.amount! >= currentFilters.minPrice!).toList();
    }

    if (currentFilters.maxPrice != null) {
      filtered = filtered.where((p) =>
          p.price.amount != null &&
          p.price.amount! <= currentFilters.maxPrice!).toList();
    }

    if (currentFilters.minBedrooms != null) {
      filtered = filtered.where((p) =>
          p.specs.bedrooms != null &&
          p.specs.bedrooms! >= currentFilters.minBedrooms!).toList();
    }

    if (currentFilters.maxBedrooms != null) {
      filtered = filtered.where((p) =>
          p.specs.bedrooms != null &&
          p.specs.bedrooms! <= currentFilters.maxBedrooms!).toList();
    }

    if (currentFilters.minBathrooms != null) {
      filtered = filtered.where((p) =>
          p.specs.bathrooms != null &&
          p.specs.bathrooms! >= currentFilters.minBathrooms!).toList();
    }

    if (currentFilters.maxBathrooms != null) {
      filtered = filtered.where((p) =>
          p.specs.bathrooms != null &&
          p.specs.bathrooms! <= currentFilters.maxBathrooms!).toList();
    }

    if (currentFilters.statuses.isNotEmpty) {
      filtered = filtered.where((p) =>
          currentFilters.statuses.contains(p.status)).toList();
    }

    if (currentFilters.featuredOnly) {
      filtered = filtered.where((p) => p.isFeatured).toList();
    }

    filteredProperties.value = filtered;
    applySort();
  }

  void applySort() {
    var sorted = List<PropertyModel>.from(filteredProperties);
    final sort = sortOption.value;

    if (sort == null) {
      // Default: featured first, then by sortOrder
      sorted.sort((a, b) {
        if (a.isFeatured && !b.isFeatured) return -1;
        if (!a.isFeatured && b.isFeatured) return 1;
        return a.sortOrder.compareTo(b.sortOrder);
      });
    } else {
      switch (sort) {
        case PropertySortOption.priceLowHigh:
          sorted.sort((a, b) {
            final aPrice = a.price.amount ?? double.infinity;
            final bPrice = b.price.amount ?? double.infinity;
            return aPrice.compareTo(bPrice);
          });
          break;
        case PropertySortOption.priceHighLow:
          sorted.sort((a, b) {
            final aPrice = a.price.amount ?? double.infinity;
            final bPrice = b.price.amount ?? double.infinity;
            return bPrice.compareTo(aPrice);
          });
          break;
        case PropertySortOption.newestFirst:
          sorted.sort((a, b) => b.createdAt.compareTo(a.createdAt));
          break;
        case PropertySortOption.featuredFirst:
          sorted.sort((a, b) {
            if (a.isFeatured && !b.isFeatured) return -1;
            if (!a.isFeatured && b.isFeatured) return 1;
            return a.sortOrder.compareTo(b.sortOrder);
          });
          break;
        case PropertySortOption.alphabetical:
          sorted.sort((a, b) => a.title.compareTo(b.title));
          break;
      }
    }

    filteredProperties.value = sorted;
    featuredProperties.value = sorted.where((p) => p.isFeatured).toList();
    applyPagination();
  }

  void applyPagination() {
    final totalPages = AppPaginationHelper.calculateTotalPages(
      filteredProperties.length,
      itemsPerPage,
    );

    // Reset to page 1 if current page is out of bounds
    if (currentPage.value > totalPages && totalPages > 0) {
      currentPage.value = 1;
    }

    displayedProperties.value = AppPaginationHelper.getPageItems(
      filteredProperties,
      currentPage.value,
      itemsPerPage,
    );
  }

  void updateFilters(PropertyFilters newFilters) {
    filters.value = newFilters;
    currentPage.value = 1; // Reset to first page
    applyFilters();
  }

  void updateSort(PropertySortOption? newSort) {
    sortOption.value = newSort;
    currentPage.value = 1; // Reset to first page
    applySort();
  }

  void goToPage(int page) {
    final totalPages = AppPaginationHelper.calculateTotalPages(
      filteredProperties.length,
      itemsPerPage,
    );
    if (page >= 1 && page <= totalPages) {
      currentPage.value = page;
      applyPagination();
    }
  }

  int get totalPages => AppPaginationHelper.calculateTotalPages(
        filteredProperties.length,
        itemsPerPage,
      );

  Future<void> viewProperty(PropertyModel property) async {
    await _analyticsService.logPropertyView(property.id ?? '', property.title);
  }

  PropertyModel? getPropertyBySlug(String slug) {
    try {
      return allProperties.firstWhere((p) => p.slug == slug);
    } catch (e) {
      return null;
    }
  }

  void scrollToListing() {
    final context = listingSectionKey.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }
}
