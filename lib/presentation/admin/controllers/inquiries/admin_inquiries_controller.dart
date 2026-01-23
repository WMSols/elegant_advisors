import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:elegant_advisors/core/base/base_controller/app_base_controller.dart';
import 'package:elegant_advisors/data/services/firestore_service.dart';
import 'package:elegant_advisors/data/services/storage_service.dart';
import 'package:elegant_advisors/data/services/export_service.dart';
import 'package:elegant_advisors/data/services/email_service.dart';
import 'package:elegant_advisors/domain/models/contact_submission_model.dart';
import 'package:elegant_advisors/core/widgets/feedback/app_alert_dialog.dart';
import 'package:elegant_advisors/core/widgets/feedback/app_snackbar.dart';
import 'package:elegant_advisors/core/utils/app_texts/app_texts.dart';
import 'package:elegant_advisors/core/constants/admin_constants.dart';
import 'package:elegant_advisors/presentation/admin/widgets/properties/detail_dialog/admin_property_detail_dialog.dart';
import 'package:elegant_advisors/presentation/admin/widgets/inquiries/detail_dialog/admin_inquiry_reply_dialog.dart';

class AdminInquiriesController extends BaseController {
  final FirestoreService _firestoreService = FirestoreService();
  final StorageService _storageService = StorageService();
  final EmailService _emailService = EmailService();

  final inquiries = <ContactSubmissionModel>[].obs;
  @override
  final isLoading = false.obs;
  final searchQuery = ''.obs;
  final sortBy = 'createdAt'.obs; // 'name', 'email', 'subject', 'status', 'createdAt'
  final sortOrder = 'desc'.obs; // 'asc', 'desc'
  final statusFilter = Rxn<String>(); // null, 'new', 'in_progress', 'closed'
  final selectedPropertyId = Rxn<String>();
  final dateFilter = Rxn<DateTime>();
  final deletingInquiryId = Rxn<String>(); // Track which inquiry is being deleted
  final propertyNames = <String, String>{}.obs; // Cache property names: propertyId -> propertyName
  TextEditingController? _searchController;
  StreamSubscription<List<ContactSubmissionModel>>? _inquiriesStreamSubscription;
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
    loadInquiries();
  }

  @override
  void onReady() {
    super.onReady();
    if (_isDisposed || _searchController == null) {
      _initializeSearchController();
    }
    loadInquiries();
  }

  @override
  void onClose() {
    _isDisposed = true;
    _inquiriesStreamSubscription?.cancel();
    _inquiriesStreamSubscription = null;
    _searchController?.removeListener(_onSearchChanged);
    _searchController?.dispose();
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

  Future<void> loadInquiries() async {
    try {
      await _inquiriesStreamSubscription?.cancel();
      _inquiriesStreamSubscription = null;

      setLoading(true);

      _inquiriesStreamSubscription = _firestoreService
          .getAllContactSubmissions()
          .listen(
        (inquiryList) async {
          inquiries.assignAll(inquiryList);
          // Load property names for inquiries with propertyId
          await _loadPropertyNames(inquiryList);
          setLoading(false);
        },
        onError: (error) {
          setLoading(false);
          showError('Failed to load inquiries: ${error.toString()}');
        },
        cancelOnError: false,
      );
    } catch (e) {
      setLoading(false);
      showError('Failed to load inquiries');
    }
  }

  // Computed list of filtered and sorted inquiries
  List<ContactSubmissionModel> get filteredInquiries {
    final inquiryList = inquiries.toList();
    final query = searchQuery.value.toLowerCase();
    final sortField = sortBy.value;
    final sortDirection = sortOrder.value;

    var result = inquiryList;

    // Apply search filter
    if (query.isNotEmpty) {
      result = result.where((inquiry) {
        return inquiry.name.toLowerCase().contains(query) ||
            inquiry.email.toLowerCase().contains(query) ||
            inquiry.subject.toLowerCase().contains(query) ||
            inquiry.message.toLowerCase().contains(query) ||
            (inquiry.phone?.toLowerCase().contains(query) ?? false);
      }).toList();
    }

    // Apply status filter
    if (statusFilter.value != null) {
      result = result
          .where((inquiry) => inquiry.status == statusFilter.value)
          .toList();
    }

    // Apply property filter
    if (selectedPropertyId.value != null) {
      result = result
          .where((inquiry) => inquiry.propertyId == selectedPropertyId.value)
          .toList();
    }

    // Apply date filter
    if (dateFilter.value != null) {
      final filterDate = dateFilter.value!;
      result = result
          .where(
            (i) =>
                i.createdAt.year == filterDate.year &&
                i.createdAt.month == filterDate.month &&
                i.createdAt.day == filterDate.day,
          )
          .toList();
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
        case 'subject':
          comparison = a.subject.compareTo(b.subject);
          break;
        case 'status':
          comparison = a.status.compareTo(b.status);
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

  void updateStatusFilter(String? status) {
    statusFilter.value = status;
  }

  void filterByProperty(String? propertyId) {
    selectedPropertyId.value = propertyId;
  }

  void filterByDate(DateTime? date) {
    dateFilter.value = date;
  }

  void clearFilters() {
    statusFilter.value = null;
    selectedPropertyId.value = null;
    dateFilter.value = null;
  }

  Future<void> updateInquiryStatus(String inquiryId, String status) async {
    executeAsync(() async {
      try {
        await _firestoreService.updateContactSubmissionStatus(
          inquiryId,
          status,
        );
        await loadInquiries();
        showSuccess('Inquiry status updated');
      } catch (e) {
        showError('Failed to update inquiry status');
      }
    });
  }

  Future<void> exportInquiries() async {
    executeAsync(() async {
      try {
        final csvContent = ExportService.exportInquiriesToCSV(inquiries);
        final filename =
            'inquiries_${DateTime.now().toIso8601String().split('T')[0]}.csv';
        await ExportService.downloadFile(
          content: csvContent,
          filename: filename,
          mimeType: 'text/csv',
        );
        showSuccess('Inquiries exported successfully');
      } catch (e) {
        showError('Failed to export inquiries: ${e.toString()}');
      }
    });
  }

  Future<void> deleteInquiry(String inquiryId) async {
    final confirmed = await AppAlertDialog.show(
      title: AppTexts.adminInquiriesDeleteTitle,
      subtitle: AppTexts.adminInquiriesDeleteMessage,
      cancelText: AppTexts.adminInquiriesDeleteCancel,
      confirmText: AppTexts.adminInquiriesDeleteConfirm,
      isDestructive: true,
    );

    if (confirmed != true) return;

    deletingInquiryId.value = inquiryId;
    clearError();

    try {
      await _firestoreService.deleteContactSubmission(inquiryId);
      AppSnackbar.showSuccess('Inquiry deleted successfully');
    } catch (e) {
      AppSnackbar.showError('Failed to delete inquiry');
    } finally {
      Future.delayed(const Duration(milliseconds: 500), () {
        deletingInquiryId.value = null;
      });
    }
  }

  Future<void> replyToInquiry(ContactSubmissionModel inquiry) async {
    Get.dialog(
      AdminInquiryReplyDialog(
        inquiry: inquiry,
        onSend: (replyMessage) async {
          return _sendReplyEmail(inquiry, replyMessage);
        },
      ),
    );
  }

  Future<void> _sendReplyEmail(
    ContactSubmissionModel inquiry,
    String replyMessage,
  ) async {
    try {
      final result = await executeAsync(() async {
        await _emailService.sendInquiryReply(inquiry, replyMessage);
        
        // Optionally update inquiry status to "in_progress" if it's "new"
        if (inquiry.status == 'new' && inquiry.id != null) {
          await _firestoreService.updateContactSubmissionStatus(
            inquiry.id!,
            'in_progress',
          );
        }
        return true; // Return a value to indicate success
      });
      
      // Only show success if executeAsync completed successfully (not null)
      if (result != null) {
        // Show success message immediately
        showSuccess(AppTexts.adminInquiryReplySuccess);
        // Wait a bit to ensure message is visible
        await Future.delayed(const Duration(milliseconds: 500));
      } else {
        // executeAsync returned null, indicating an error occurred
        showError(AppTexts.adminInquiryReplyError);
        throw Exception(AppTexts.adminInquiryReplyError);
      }
    } catch (e) {
      final errorMessage = e.toString().replaceFirst('Exception: ', '');
      // Only show error if it hasn't been shown already
      if (errorMessage != AppTexts.adminInquiryReplyError) {
        showError(
          errorMessage.isEmpty
              ? AppTexts.adminInquiryReplyError
              : errorMessage,
        );
      }
      rethrow;
    }
  }

  Future<void> viewProperty(String? propertyId) async {
    if (propertyId == null) return;

    try {
      // Fetch the property
      final property = await _firestoreService.getPropertyById(propertyId);
      if (property == null) {
        showError('Property not found');
        return;
      }

      // Show property detail dialog
      Get.dialog(
        AdminPropertyDetailDialog(
          property: property,
          onEdit: () {
            Get.back();
            navigateToEditProperty(propertyId);
          },
          onDelete: () {
            Get.back();
            deletePropertyFromInquiry(propertyId);
          },
          onTogglePublish: () {
            Get.back();
            togglePropertyStatus(propertyId, property.isPublished);
          },
        ),
      );
    } catch (e) {
      showError('Failed to load property: ${e.toString()}');
    }
  }

  void navigateToEditProperty(String propertyId) {
    Get.toNamed(
      AdminConstants.routeAdminPropertyEdit.replaceAll(':id', propertyId),
    );
  }

  Future<void> deletePropertyFromInquiry(String propertyId) async {
    final confirmed = await AppAlertDialog.show(
      title: AppTexts.adminPropertiesDeleteTitle,
      subtitle: AppTexts.adminPropertiesDeleteMessage,
      cancelText: AppTexts.adminPropertiesDeleteCancel,
      confirmText: AppTexts.adminPropertiesDeleteConfirm,
      isDestructive: true,
    );

    if (confirmed != true) return;

    executeAsync(() async {
      try {
        // Get property to delete images
        final property = await _firestoreService.getPropertyById(propertyId);
        if (property == null) {
          showError('Property not found');
          return;
        }

        // Delete all images from storage
        final allImageUrls = <String>[...property.images];
        if (property.coverImage != null &&
            !allImageUrls.contains(property.coverImage)) {
          allImageUrls.add(property.coverImage!);
        }

        if (allImageUrls.isNotEmpty) {
          await _storageService.deletePropertyImages(allImageUrls);
        }

        // Delete property folder from storage
        await _storageService.deletePropertyFolder(propertyId);

        // Delete property from Firestore
        await _firestoreService.deleteProperty(propertyId);
        AppSnackbar.showSuccess('Property deleted successfully');
      } on Exception catch (e) {
        final errorMessage = e.toString().replaceFirst('Exception: ', '');
        AppSnackbar.showError(errorMessage);
      } catch (e) {
        AppSnackbar.showError('Failed to delete property');
      }
    });
  }

  Future<void> togglePropertyStatus(
    String propertyId,
    bool isPublished,
  ) async {
    executeAsync(() async {
      try {
        final property = await _firestoreService.getPropertyById(propertyId);
        if (property == null) {
          showError('Property not found');
          return;
        }
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

  void viewInquiryDetails(ContactSubmissionModel inquiry) {
    // This will be handled by the dialog in the screen
    // Controller doesn't need to do anything here
  }

  /// Load property names for inquiries that have propertyId
  Future<void> _loadPropertyNames(
    List<ContactSubmissionModel> inquiryList,
  ) async {
    final propertyIds = inquiryList
        .where((inquiry) => inquiry.propertyId != null)
        .map((inquiry) => inquiry.propertyId!)
        .toSet()
        .where((id) => !propertyNames.containsKey(id))
        .toList();

    if (propertyIds.isEmpty) return;

    try {
      for (final propertyId in propertyIds) {
        try {
          final property = await _firestoreService.getPropertyById(propertyId);
          if (property != null) {
            propertyNames[propertyId] = property.title;
          } else {
            propertyNames[propertyId] = 'Property not found';
          }
        } catch (e) {
          // Property might not exist, continue with others
          propertyNames[propertyId] = 'Property not found';
        }
      }
    } catch (e) {
      // Silently fail - property names are optional
    }
  }

  /// Get property name for a given propertyId
  String? getPropertyName(String? propertyId) {
    if (propertyId == null) return null;
    return propertyNames[propertyId];
  }

  /// Check if a specific inquiry is being deleted
  bool isDeleting(String inquiryId) {
    return deletingInquiryId.value == inquiryId;
  }
}
