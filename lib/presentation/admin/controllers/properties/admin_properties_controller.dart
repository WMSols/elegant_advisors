import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elegant_advisors/data/services/firestore_service.dart';
import 'package:elegant_advisors/data/services/storage_service.dart';
import 'package:elegant_advisors/domain/models/property_model.dart';
import 'package:elegant_advisors/core/base/base_controller/app_base_controller.dart';
import 'package:elegant_advisors/core/constants/admin_constants.dart';
import 'package:elegant_advisors/core/utils/app_texts/app_texts.dart';
import 'package:elegant_advisors/core/widgets/feedback/app_alert_dialog.dart';
import 'package:elegant_advisors/core/widgets/feedback/app_snackbar.dart';

class AdminPropertiesController extends BaseController {
  final FirestoreService _firestoreService = FirestoreService();
  final StorageService _storageService = StorageService();

  final properties = <PropertyModel>[].obs;
  final searchQuery = ''.obs;
  final sortBy =
      'createdAt'.obs; // 'title', 'createdAt', 'updatedAt', 'price', 'status'
  final sortOrder = 'desc'.obs; // 'asc', 'desc'
  final statusFilter =
      Rxn<String>(); // null, 'available', 'sold', 'off_market', 'coming_soon'
  final publishedFilter = Rxn<bool>(); // null, true, false
  final featuredFilter = Rxn<bool>(); // null, true, false
  final deletingPropertyId =
      Rxn<String>(); // Track which property is being deleted
  TextEditingController? _searchController;

  StreamSubscription<List<PropertyModel>>? _propertiesStreamSubscription;
  bool _isDisposed = false;

  /// Safely get the search controller - lazy initializes if needed
  TextEditingController get searchController {
    if (_searchController == null || _isDisposed) {
      _initializeSearchController();
    } else {
      try {
        final _ = _searchController!.text;
      } catch (e) {
        _initializeSearchController();
      }
    }
    return _searchController!;
  }

  void _initializeSearchController() {
    _searchController?.removeListener(_onSearchChanged);
    _searchController?.dispose();
    _searchController = TextEditingController();
    _searchController!.addListener(_onSearchChanged);
    _isDisposed = false;
  }

  @override
  void onInit() {
    super.onInit();
    _initializeSearchController();
    loadProperties();
  }

  @override
  void onReady() {
    super.onReady();
    if (_isDisposed || _searchController == null) {
      _initializeSearchController();
    }
    loadProperties();
  }

  @override
  void onClose() {
    _isDisposed = true;
    _propertiesStreamSubscription?.cancel();
    _propertiesStreamSubscription = null;
    _searchController?.removeListener(_onSearchChanged);
    _searchController = null;
    super.onClose();
  }

  void _onSearchChanged() {
    if (!_isDisposed && _searchController != null) {
      try {
        updateSearchQuery(_searchController!.text);
      } catch (e) {
        // Controller might be disposed, ignore
      }
    }
  }

  Future<void> loadProperties() async {
    try {
      await _propertiesStreamSubscription?.cancel();
      _propertiesStreamSubscription = null;

      setLoading(true);

      _propertiesStreamSubscription = _firestoreService.getAllProperties().listen(
        (propertyList) {
          properties.assignAll(propertyList);
          setLoading(false);
        },
        onError: (error) {
          setLoading(false);
          // Ignore permission-denied errors if user is logged out (during logout)
          if (_shouldIgnoreError(error)) {
            return;
          }
          AppSnackbar.showError(
            'Failed to load properties: ${error.toString()}',
          );
        },
        cancelOnError: false,
      );
    } catch (e) {
      setLoading(false);
      AppSnackbar.showError('Failed to load properties');
    }
  }

  /// Check if error should be ignored (e.g., permission-denied during logout)
  bool _shouldIgnoreError(dynamic error) {
    // Check if it's a Firestore permission-denied error
    if (error is FirebaseException && error.code == 'permission-denied') {
      // Check if user is logged out (null current user)
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        // User is logged out, ignore this error (expected during logout)
        return true;
      }
    }
    return false;
  }

  // Computed list of filtered and sorted properties
  List<PropertyModel> get filteredProperties {
    final propertyList = properties.toList();
    final query = searchQuery.value.toLowerCase();
    final sortField = sortBy.value;
    final sortDirection = sortOrder.value;

    var result = propertyList;

    // Apply search filter
    if (query.isNotEmpty) {
      result = result.where((property) {
        return property.title.toLowerCase().contains(query) ||
            property.shortDescription.toLowerCase().contains(query) ||
            property.fullDescription.toLowerCase().contains(query) ||
            property.location.city.toLowerCase().contains(query) ||
            property.location.country.toLowerCase().contains(query) ||
            (property.location.area?.toLowerCase().contains(query) ?? false);
      }).toList();
    }

    // Apply status filter
    if (statusFilter.value != null) {
      result = result
          .where((property) => property.status == statusFilter.value)
          .toList();
    }

    // Apply published filter
    if (publishedFilter.value != null) {
      result = result
          .where((property) => property.isPublished == publishedFilter.value)
          .toList();
    }

    // Apply featured filter
    if (featuredFilter.value != null) {
      result = result
          .where((property) => property.isFeatured == featuredFilter.value)
          .toList();
    }

    // Apply sorting
    result.sort((a, b) {
      int comparison = 0;
      switch (sortField) {
        case 'title':
          comparison = a.title.compareTo(b.title);
          break;
        case 'createdAt':
          comparison = a.createdAt.compareTo(b.createdAt);
          break;
        case 'updatedAt':
          comparison = a.updatedAt.compareTo(b.updatedAt);
          break;
        case 'price':
          final priceA = a.price.amount ?? 0;
          final priceB = b.price.amount ?? 0;
          comparison = priceA.compareTo(priceB);
          break;
        case 'status':
          comparison = a.status.compareTo(b.status);
          break;
      }

      return sortDirection == 'asc' ? comparison : -comparison;
    });

    return result;
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
  }

  void updateSortBy(String field) {
    sortBy.value = field;
  }

  void toggleSortOrder() {
    sortOrder.value = sortOrder.value == 'asc' ? 'desc' : 'asc';
  }

  void updateStatusFilter(String? status) {
    statusFilter.value = status;
  }

  void updatePublishedFilter(bool? published) {
    publishedFilter.value = published;
  }

  void updateFeaturedFilter(bool? featured) {
    featuredFilter.value = featured;
  }

  void clearFilters() {
    statusFilter.value = null;
    publishedFilter.value = null;
    featuredFilter.value = null;
  }

  void navigateToAddProperty() {
    Get.toNamed(AdminConstants.routeAdminPropertyAdd);
  }

  void navigateToEditProperty(String propertyId) {
    Get.toNamed(
      AdminConstants.routeAdminPropertyEdit.replaceAll(':id', propertyId),
    );
  }

  Future<void> deleteProperty(String propertyId) async {
    final confirmed = await AppAlertDialog.show(
      title: AppTexts.adminPropertiesDeleteTitle,
      subtitle: AppTexts.adminPropertiesDeleteMessage,
      cancelText: AppTexts.adminPropertiesDeleteCancel,
      confirmText: AppTexts.adminPropertiesDeleteConfirm,
      isDestructive: true,
    );

    if (confirmed != true) return;

    deletingPropertyId.value = propertyId;
    clearError();

    try {
      // Get property to delete images
      final property = properties.firstWhere((p) => p.id == propertyId);

      // Delete all images from storage (including cover image if it exists separately)
      final allImageUrls = <String>[...property.images];
      if (property.coverImage != null &&
          !allImageUrls.contains(property.coverImage)) {
        allImageUrls.add(property.coverImage!);
      }

      if (allImageUrls.isNotEmpty) {
        await _storageService.deletePropertyImages(allImageUrls);
      }

      // Delete property folder from storage (catches any remaining files)
      await _storageService.deletePropertyFolder(propertyId);

      // Delete property from Firestore
      await _firestoreService.deleteProperty(propertyId);
      AppSnackbar.showSuccess('Property deleted successfully');
    } on Exception catch (e) {
      final errorMessage = e.toString().replaceFirst('Exception: ', '');
      AppSnackbar.showError(errorMessage);
    } catch (e) {
      AppSnackbar.showError('Failed to delete property');
    } finally {
      Future.delayed(const Duration(milliseconds: 500), () {
        deletingPropertyId.value = null;
      });
    }
  }

  Future<void> togglePropertyStatus(String propertyId, bool isPublished) async {
    executeAsync(() async {
      try {
        final property = properties.firstWhere((p) => p.id == propertyId);
        await _firestoreService.updateProperty(
          propertyId,
          property.copyWith(isPublished: !isPublished),
        );
        showSuccess('Property status updated');
      } catch (e) {
        showError('Failed to update property status');
      }
    });
  }

  /// Check if a specific property is being deleted
  bool isDeleting(String propertyId) {
    return deletingPropertyId.value == propertyId;
  }
}
