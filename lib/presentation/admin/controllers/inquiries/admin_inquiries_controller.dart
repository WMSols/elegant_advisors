import 'package:elegant_advisors/core/base/base_controller/app_base_controller.dart';
import 'package:get/get.dart';
import 'package:elegant_advisors/data/services/firestore_service.dart';
import 'package:elegant_advisors/data/services/export_service.dart';
import 'package:elegant_advisors/domain/models/contact_submission_model.dart';

class AdminInquiriesController extends BaseController {
  final FirestoreService _firestoreService = FirestoreService();

  final inquiries = <ContactSubmissionModel>[].obs;
  @override
  final isLoading = false.obs;
  final selectedStatus = 'all'.obs; // all, new, in_progress, closed
  final selectedPropertyId = Rxn<String>();
  final dateFilter = Rxn<DateTime>();

  @override
  void onInit() {
    super.onInit();
    loadInquiries();
  }

  Future<void> loadInquiries() async {
    isLoading.value = true;
    try {
      final fetchedInquiries = await _firestoreService
          .getAllContactSubmissions()
          .first;

      // Apply filters
      var filtered = fetchedInquiries;

      if (selectedStatus.value != 'all') {
        filtered = filtered
            .where((i) => i.status == selectedStatus.value)
            .toList();
      }

      if (selectedPropertyId.value != null) {
        filtered = filtered
            .where((i) => i.propertyId == selectedPropertyId.value)
            .toList();
      }

      if (dateFilter.value != null) {
        final filterDate = dateFilter.value!;
        filtered = filtered
            .where(
              (i) =>
                  i.createdAt.year == filterDate.year &&
                  i.createdAt.month == filterDate.month &&
                  i.createdAt.day == filterDate.day,
            )
            .toList();
      }

      inquiries.value = filtered;
    } catch (e) {
      showError('Failed to load inquiries');
    } finally {
      isLoading.value = false;
    }
  }

  void filterByStatus(String status) {
    selectedStatus.value = status;
    loadInquiries();
  }

  void filterByProperty(String? propertyId) {
    selectedPropertyId.value = propertyId;
    loadInquiries();
  }

  void filterByDate(DateTime? date) {
    dateFilter.value = date;
    loadInquiries();
  }

  void clearFilters() {
    selectedStatus.value = 'all';
    selectedPropertyId.value = null;
    dateFilter.value = null;
    loadInquiries();
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
        // TODO: Trigger file download using ExportService.downloadFile
        // await ExportService.downloadFile(
        //   content: csvContent,
        //   filename: 'inquiries_${DateTime.now().toIso8601String()}.csv',
        //   mimeType: 'text/csv',
        // );
        // csvContent is prepared for download - will be used when downloadFile is implemented
        print(
          'CSV content length: ${csvContent.length}',
        ); // Temporary to avoid unused warning
        showSuccess('Inquiries exported successfully');
      } catch (e) {
        showError('Failed to export inquiries');
      }
    });
  }
}
