import 'package:get/get.dart';
import 'package:elegant_advisors/data/services/firestore_service.dart';
import 'package:elegant_advisors/data/services/analytics_service.dart';
import 'package:elegant_advisors/domain/models/property_model.dart';
import 'package:elegant_advisors/core/base/base_controller/app_base_controller.dart';

class PropertyDetailController extends BaseController {
  final FirestoreService _firestoreService = FirestoreService();
  final AnalyticsService _analyticsService = AnalyticsService();

  final property = Rxn<PropertyModel>();
  final isLoading = false.obs;
  final currentImageIndex = 0.obs;

  String? get slug => Get.parameters['slug'];

  @override
  void onInit() {
    super.onInit();
    if (slug != null) {
      loadProperty();
    }
  }

  Future<void> loadProperty() async {
    if (slug == null) return;

    isLoading.value = true;
    try {
      final loadedProperty = await _firestoreService.getPropertyBySlug(slug!);
      if (loadedProperty != null) {
        property.value = loadedProperty;
        // Track property visit
        await trackPropertyVisit(loadedProperty);
      } else {
        showError('Property not found');
        Get.back();
      }
    } catch (e) {
      showError('Failed to load property');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> trackPropertyVisit(PropertyModel property) async {
    try {
      // Log analytics
      await _analyticsService.logPropertyView(
        property.id ?? '',
        property.title,
      );

      // Increment visit counter
      // TODO: Get IP address from request
      await _firestoreService.incrementPropertyVisit(
        property.id ?? '',
        null, // IP address - to be implemented
      );
    } catch (e) {
      // Silently fail - analytics shouldn't break the page
      print('Failed to track property visit: $e');
    }
  }

  void setCurrentImageIndex(int index) {
    currentImageIndex.value = index;
  }

  void openInquiryForm() {
    // TODO: Navigate to contact form with property ID pre-filled
    // Get.toNamed(ClientConstants.routeContact, arguments: property.value?.id);
  }
}
