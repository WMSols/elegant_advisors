import 'package:get/get.dart';
import 'package:elegant_advisors/data/services/firestore_service.dart';
import 'package:elegant_advisors/data/services/analytics_service.dart';
import 'package:elegant_advisors/domain/models/property_model.dart';
import 'package:elegant_advisors/core/base/base_controller/app_base_controller.dart';
import 'package:elegant_advisors/core/constants/client_constants.dart';

class ClientPropertyDetailController extends BaseController {
  final FirestoreService _firestoreService = FirestoreService();
  final AnalyticsService _analyticsService = AnalyticsService();

  final property = Rxn<PropertyModel>();
  final relatedProperties = <PropertyModel>[].obs;
  @override
  final isLoading = false.obs;
  final isLoadingRelated = false.obs;
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
        // Load related properties
        loadRelatedProperties(loadedProperty);
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

  Future<void> loadRelatedProperties(PropertyModel currentProperty) async {
    if (currentProperty.id == null) return;

    isLoadingRelated.value = true;
    try {
      final allProperties = await _firestoreService.getPublishedPropertiesOnce();
      
      // Filter related properties: same location or same type, exclude current
      final related = allProperties.where((p) {
        if (p.id == currentProperty.id) return false;
        
        final sameLocation = p.location.city == currentProperty.location.city &&
            p.location.country == currentProperty.location.country;
        final sameType = p.specs.propertyType == currentProperty.specs.propertyType;
        
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
      print('Failed to load related properties: $e');
    } finally {
      isLoadingRelated.value = false;
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
    if (property.value?.id != null) {
      Get.toNamed(
        ClientConstants.routeClientContact,
        arguments: property.value!.id,
      );
    }
  }
}
