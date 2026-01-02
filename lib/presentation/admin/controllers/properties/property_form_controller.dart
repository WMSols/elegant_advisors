import 'package:get/get.dart';
import 'package:elegant_advisors/data/services/firestore_service.dart';
import 'package:elegant_advisors/domain/models/property_model.dart';
import 'package:elegant_advisors/core/base/base_controller/app_base_controller.dart';

class PropertyFormController extends BaseController {
  final FirestoreService _firestoreService = FirestoreService();
  // StorageService will be used when implementing image upload
  // final StorageService _storageService = StorageService();

  final isEditMode = false.obs;
  final isLoading = false.obs;
  final property = Rxn<PropertyModel>();

  String? get propertyId => Get.parameters['id'];

  @override
  void onInit() {
    super.onInit();
    if (propertyId != null) {
      isEditMode.value = true;
      loadProperty();
    }
  }

  Future<void> loadProperty() async {
    if (propertyId == null) return;

    isLoading.value = true;
    try {
      final loadedProperty = await _firestoreService.getPropertyById(
        propertyId!,
      );
      property.value = loadedProperty;
    } catch (e) {
      showError('Failed to load property');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> saveProperty(PropertyModel propertyData) async {
    isLoading.value = true;
    try {
      if (isEditMode.value && propertyId != null) {
        await _firestoreService.updateProperty(propertyId!, propertyData);
        showSuccess('Property updated successfully');
      } else {
        await _firestoreService.createProperty(propertyData);
        showSuccess('Property created successfully');
      }
      Get.back();
    } catch (e) {
      showError('Failed to save property');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> uploadImages(List<String> imagePaths) async {
    // TODO: Implement image upload
    // - Compress images
    // - Upload to storage
    // - Get download URLs
    // - Update property with image URLs
  }
}
