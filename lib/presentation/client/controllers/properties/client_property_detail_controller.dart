import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:elegant_advisors/data/services/firestore_service.dart';
import 'package:elegant_advisors/data/services/analytics_service.dart';
import 'package:elegant_advisors/domain/models/property_model.dart';
import 'package:elegant_advisors/core/base/base_controller/app_base_controller.dart';
import 'package:elegant_advisors/core/constants/client_constants.dart';
import 'package:elegant_advisors/core/utils/app_helpers/ip_address/app_ip_helper.dart';
import 'package:elegant_advisors/core/utils/app_helpers/language/app_localizations_helper.dart';

class ClientPropertyDetailController extends BaseController {
  final FirestoreService _firestoreService = FirestoreService();
  final AnalyticsService _analyticsService = AnalyticsService();

  final property = Rxn<PropertyModel>();
  final relatedProperties = <PropertyModel>[].obs;
  final isLoadingRelated = false.obs;
  final currentImageIndex = 0.obs;
  ScrollController? _scrollController;
  final showHeader = false.obs;
  int _keyCounter = 0;
  String? _currentSlug; // Track current slug to detect changes
  String?
  _lastTrackedPropertyId; // Track last property ID that was tracked to prevent duplicates

  // Use ValueKey instead of GlobalKey to avoid duplicate key issues
  // ValueKey with a counter ensures unique keys without GlobalKey conflicts
  Key get scrollViewKey =>
      ValueKey('property_detail_scroll_${_keyCounter}_${slug ?? 'unknown'}');

  // Store the listener function so we can remove it properly
  VoidCallback? _scrollListener;

  // Getter for scroll controller - returns existing or creates new one
  ScrollController get scrollController {
    if (_scrollController == null) {
      _scrollController = ScrollController();
      _setupScrollListener();
    }
    return _scrollController!;
  }

  String? get slug => Get.parameters['slug'];

  void _disposeScrollController() {
    if (_scrollController != null) {
      // Remove listener first
      if (_scrollListener != null) {
        try {
          _scrollController!.removeListener(_scrollListener!);
        } catch (e) {
          // Ignore errors during removal - controller might already be disposed
        }
      }

      // Dispose the controller
      try {
        _scrollController!.dispose();
      } catch (e) {
        // Ignore disposal errors - controller might already be disposed
      }

      _scrollController = null;
      _scrollListener = null;
    }
  }

  @override
  void onInit() {
    super.onInit();

    // Always dispose any existing scroll controller first
    // This ensures clean state when navigating between properties
    _disposeScrollController();

    // Reset property data to ensure fresh load
    property.value = null;
    relatedProperties.clear();
    _lastTrackedPropertyId =
        null; // Reset tracking when navigating to new property

    // Update current slug
    _currentSlug = slug;

    // Increment key counter to ensure unique key for each navigation
    _keyCounter++;

    // Always show header background (primary color) in property detail screen
    showHeader.value = true;

    // Create new scroll controller - will be created in getter when needed
    // Don't create here to avoid timing issues during widget build
    if (slug != null) {
      loadProperty();
    }
  }

  @override
  void onReady() {
    super.onReady();
    // Reload property in case slug changed or wasn't available in onInit
    // This ensures property is loaded even if route parameters weren't ready in onInit
    final currentSlug = slug;
    if (currentSlug != null &&
        (property.value == null || _currentSlug != currentSlug)) {
      _currentSlug = currentSlug;
      loadProperty();
    }
  }

  void _setupScrollListener() {
    if (_scrollController == null) return;

    _scrollListener = () {
      // Property detail screen always shows header with primary color
      // No need to change based on scroll position
      // Keep showHeader always true
      if (!showHeader.value) {
        showHeader.value = true;
      }
    };

    _scrollController!.addListener(_scrollListener!);
  }

  @override
  void onClose() {
    // Dispose the scroll controller
    _disposeScrollController();
    _currentSlug = null;
    super.onClose();
  }

  Future<void> loadProperty() async {
    if (slug == null) return;

    isLoading.value = true;
    try {
      final loadedProperty = await _firestoreService.getPropertyBySlug(slug!);
      if (loadedProperty != null) {
        // Off-market listings are inquire-only: redirect to contact
        if (loadedProperty.status == 'off_market' &&
            loadedProperty.id != null &&
            loadedProperty.id!.isNotEmpty) {
          Get.offNamed(
            ClientConstants.routeClientContact,
            arguments: loadedProperty.id,
          );
          return;
        }
        property.value = loadedProperty;
        // Track property visit
        await trackPropertyVisit(loadedProperty);
        // Load related properties
        loadRelatedProperties(loadedProperty);
      } else {
        final l10n = AppLocalizationsHelper.getLocalizations();
        showError(l10n?.clientPropertyDetailNotFound ?? 'Property not found');
        Get.back();
      }
    } catch (e) {
      final l10n = AppLocalizationsHelper.getLocalizations();
      showError(
        l10n?.clientPropertyDetailErrorLoading ?? 'Failed to load property',
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadRelatedProperties(PropertyModel currentProperty) async {
    if (currentProperty.id == null) return;

    isLoadingRelated.value = true;
    try {
      final allProperties = await _firestoreService
          .getPublishedPropertiesOnce();

      // Filter related properties: same location or same type, exclude current
      final related = allProperties.where((p) {
        if (p.id == currentProperty.id) return false;

        final sameLocation =
            p.location.city == currentProperty.location.city &&
            p.location.country == currentProperty.location.country;
        final sameType =
            p.specs.propertyType == currentProperty.specs.propertyType;

        return sameLocation || sameType;
      }).toList();

      // Sort by featured first, then limit to 2-4
      related.sort((a, b) {
        if (a.isFeatured && !b.isFeatured) return -1;
        if (!a.isFeatured && b.isFeatured) return 1;
        return 0;
      });

      relatedProperties.value = related.take(4).toList();
    } catch (e) {
      // Silently fail - related properties are not critical
    } finally {
      isLoadingRelated.value = false;
    }
  }

  Future<void> trackPropertyVisit(PropertyModel property) async {
    try {
      // Validate property has an ID
      if (property.id == null || property.id!.isEmpty) {
        return;
      }

      // Prevent duplicate tracking for the same property in the same session
      if (_lastTrackedPropertyId == property.id) {
        return;
      }

      // Mark this property as tracked
      _lastTrackedPropertyId = property.id;

      // Log analytics
      await _analyticsService.logPropertyView(property.id!, property.title);

      // Get IP address for visit tracking
      final ipAddress = await AppIPHelper.getClientIp();

      // Increment visit counter with IP address
      await _firestoreService.incrementPropertyVisit(property.id!, ipAddress);
    } catch (e) {
      // Silently fail - analytics shouldn't break the page
      final errorString = e.toString();
      if (!errorString.contains('permission-denied')) {
        // Only log non-permission errors for debugging
      }
      // Reset tracking flag on error so it can be retried
      if (_lastTrackedPropertyId == property.id) {
        _lastTrackedPropertyId = null;
      }
    }
  }

  void setCurrentImageIndex(int index) {
    currentImageIndex.value = index;
  }

  void openInquiryForm() {
    if (property.value?.id != null) {
      Get.toNamed(
        ClientConstants.routeClientContact,
        arguments: property.value!.id,
      );
    }
  }
}
