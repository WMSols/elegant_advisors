import 'package:get/get.dart';
import 'package:elegant_advisors/data/services/firestore_service.dart';
import 'package:elegant_advisors/domain/models/property_model.dart';
import 'package:elegant_advisors/core/base/base_controller/app_base_controller.dart';
import 'package:elegant_advisors/core/constants/admin_constants.dart';

class AdminPropertiesController extends BaseController {
  final FirestoreService _firestoreService = FirestoreService();

  final properties = <PropertyModel>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadProperties();
  }

  Future<void> loadProperties() async {
    isLoading.value = true;
    try {
      final fetchedProperties = await _firestoreService
          .getAllProperties()
          .first;
      properties.value = fetchedProperties;
    } catch (e) {
      showError('Failed to load properties');
    } finally {
      isLoading.value = false;
    }
  }

  void navigateToAddProperty() {
    Get.toNamed(
      AdminConstants.routeAdminPropertyAdd,
      // Transition is handled by route configuration for smooth navigation
    );
  }

  void navigateToEditProperty(String propertyId) {
    Get.toNamed(
      AdminConstants.routeAdminPropertyEdit.replaceAll(':id', propertyId),
      // Transition is handled by route configuration for smooth navigation
    );
  }

  Future<void> deleteProperty(String propertyId) async {
    // TODO: Show confirmation dialog
    executeAsync(() async {
      try {
        await _firestoreService.deleteProperty(propertyId);
        await loadProperties();
        showSuccess('Property deleted successfully');
      } catch (e) {
        showError('Failed to delete property');
      }
    });
  }

  Future<void> togglePropertyStatus(String propertyId, bool isPublished) async {
    executeAsync(() async {
      try {
        final property = properties.firstWhere((p) => p.id == propertyId);
        await _firestoreService.updateProperty(
          propertyId,
          property.copyWith(isPublished: !isPublished),
        );
        await loadProperties();
        showSuccess('Property status updated');
      } catch (e) {
        showError('Failed to update property status');
      }
    });
  }
}
