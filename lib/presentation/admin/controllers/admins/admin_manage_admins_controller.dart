import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elegant_advisors/data/services/firestore_service.dart';
import 'package:elegant_advisors/data/services/auth_service.dart';
import 'package:elegant_advisors/domain/models/admin_user_model.dart';
import 'package:elegant_advisors/core/base/base_controller/app_base_controller.dart';
import 'package:elegant_advisors/core/constants/admin_constants.dart';
import 'package:elegant_advisors/core/utils/app_texts/app_texts.dart';
import 'package:elegant_advisors/core/widgets/feedback/app_alert_dialog.dart';
import 'package:elegant_advisors/core/widgets/feedback/app_snackbar.dart';

class AdminManageAdminsController extends BaseController {
  final FirestoreService _firestoreService = FirestoreService();
  final AuthService _authService = AuthService();

  final admins = <AdminUserModel>[].obs;
  final searchQuery = ''.obs;
  final sortBy = 'name'.obs; // 'name', 'email', 'createdAt'
  final sortOrder = 'asc'.obs; // 'asc', 'desc'
  final deletingAdminId = Rxn<String>(); // Track which admin is being deleted
  TextEditingController? _searchController;
  
  /// Safely get the search controller - lazy initializes if needed
  TextEditingController get searchController {
    // Check if controller needs to be recreated
    if (_searchController == null || _isDisposed) {
      _initializeSearchController();
    } else {
      // Verify controller is not disposed by trying to access it
      try {
        // Try to access a property to check if disposed
        final _ = _searchController!.text;
      } catch (e) {
        // Controller is disposed, recreate it
        _initializeSearchController();
      }
    }
    return _searchController!;
  }
  
  StreamSubscription<List<AdminUserModel>>? _adminsStreamSubscription;
  bool _isDisposed = false;

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
    loadAdmins();
  }

  @override
  void onReady() {
    super.onReady();
    // Re-initialize controller if it was disposed (e.g., when navigating back)
    if (_isDisposed || _searchController == null) {
      _initializeSearchController();
    }
    // Ensure stream is active - always reload to get latest data
    // This ensures real-time updates work even after navigation
    loadAdmins();
  }

  @override
  void onClose() {
    _isDisposed = true;
    _adminsStreamSubscription?.cancel();
    _adminsStreamSubscription = null;
    // Remove listener but don't dispose controller yet
    // The controller will be garbage collected when GetX deletes this controller instance
    // Disposing here causes issues during navigation transitions when widget tree
    // might still reference the controller
    _searchController?.removeListener(_onSearchChanged);
    // Set to null so getter will recreate if accessed (shouldn't happen, but safe)
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

  Future<void> loadAdmins() async {
    try {
      // Cancel existing subscription if any
      await _adminsStreamSubscription?.cancel();
      _adminsStreamSubscription = null;
      
      setLoading(true);
      
      // Create new stream subscription
      _adminsStreamSubscription = _firestoreService.getAllAdminUsers().listen(
        (adminList) {
          // Use assignAll to properly update RxList and trigger reactivity
          // This ensures GetX detects the change and updates the UI
          admins.assignAll(adminList);
          setLoading(false);
        },
        onError: (error) {
          setLoading(false);
          // Ignore permission-denied errors if user is logged out (during logout)
          if (_shouldIgnoreError(error)) {
            return;
          }
          AppSnackbar.showError('Failed to load admins: ${error.toString()}');
        },
        cancelOnError: false, // Keep listening even if there's an error
      );
    } catch (e) {
      setLoading(false);
      AppSnackbar.showError('Failed to load admins');
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

  // Computed list of filtered and sorted admins - using computed for reactivity
  List<AdminUserModel> get filteredAdmins {
    // Access all observables to ensure reactivity
    final adminList = admins.toList();
    final query = searchQuery.value;
    final sortField = sortBy.value;
    final sortDirection = sortOrder.value;

    var result = adminList;

    // Apply search filter
    if (query.isNotEmpty) {
      final lowerQuery = query.toLowerCase();
      result = result.where((admin) {
        return admin.name.toLowerCase().contains(lowerQuery) ||
            admin.email.toLowerCase().contains(lowerQuery);
      }).toList();
    }

    // Apply sorting
    result.sort((a, b) {
      int comparison = 0;
      switch (sortField) {
        case 'name':
          comparison = a.name.compareTo(b.name);
          break;
        case 'email':
          comparison = a.email.compareTo(b.email);
          break;
        case 'createdAt':
          comparison = a.createdAt.compareTo(b.createdAt);
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

  void navigateToCreateAdmin() {
    Get.toNamed(AdminConstants.routeAdminCreateAdmin);
  }

  void navigateToEditAdmin(String adminId) {
    Get.toNamed(
      AdminConstants.routeAdminEditAdmin.replaceAll(':id', adminId),
    );
  }

  Future<void> deleteAdmin(String adminId) async {
    // Show confirmation dialog using AppAlertDialog
    final confirmed = await AppAlertDialog.show(
      title: AppTexts.adminManageAdminsDeleteTitle,
      subtitle: AppTexts.adminManageAdminsDeleteMessage,
      cancelText: AppTexts.adminManageAdminsDeleteCancel,
      confirmText: AppTexts.adminManageAdminsDeleteConfirm,
      isDestructive: true,
    );

    if (confirmed != true) return;

    // Set deleting state for this specific admin
    deletingAdminId.value = adminId;
    clearError();

    try {
      await _authService.deleteAdminUserViaFunction(adminId);
      AppSnackbar.showSuccess('Admin deleted successfully');
      // List will update automatically via Firestore stream
      // The stream will detect the deletion and update the list
    } on Exception catch (e) {
      final errorMessage = e.toString().replaceFirst('Exception: ', '');
      AppSnackbar.showError(errorMessage);
    } catch (e) {
      AppSnackbar.showError('Failed to delete admin');
    } finally {
      // Clear deleting state after a short delay to allow stream to update
      Future.delayed(const Duration(milliseconds: 500), () {
        deletingAdminId.value = null;
      });
    }
  }

  /// Check if a specific admin is being deleted
  bool isDeleting(String adminId) {
    return deletingAdminId.value == adminId;
  }
}
