import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:elegant_advisors/data/services/firestore_service.dart';
import 'package:elegant_advisors/data/services/storage_service.dart';
import 'package:elegant_advisors/domain/models/property_model.dart';
import 'package:elegant_advisors/core/base/base_controller/app_base_controller.dart';
import 'package:elegant_advisors/core/utils/app_validators/app_validators.dart';
import 'package:elegant_advisors/core/utils/app_helpers/app_helpers.dart';
import 'package:elegant_advisors/core/constants/admin_constants.dart';
import 'package:elegant_advisors/core/widgets/feedback/app_snackbar.dart';

class AdminPropertyFormController extends BaseController {
  final FirestoreService _firestoreService = FirestoreService();
  final StorageService _storageService = StorageService();
  final ImagePicker _imagePicker = ImagePicker();

  final isEditMode = false.obs;
  final property = Rxn<PropertyModel>();

  // Form Controllers
  final titleController = TextEditingController();
  final slugController = TextEditingController();
  final shortDescriptionController = TextEditingController();
  final fullDescriptionController = TextEditingController();
  final countryController = TextEditingController();
  final cityController = TextEditingController();
  final areaController = TextEditingController();
  final addressController = TextEditingController();
  final priceAmountController = TextEditingController();
  final propertyTypeController = TextEditingController();
  final bedroomsController = TextEditingController();
  final bathroomsController = TextEditingController();
  final areaSizeController = TextEditingController();
  final featureController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  // Observable State
  final currency = 'EUR'.obs;
  final isOnRequest = false.obs;
  final areaUnit = 'sqm'.obs;
  final status = 'available'.obs;
  final isFeatured = false.obs;
  final isPublished = false.obs;
  final features = <String>[].obs;
  final images = <String>[].obs; // URLs
  final imageFiles =
      <XFile>[].obs; // Local files to upload (XFile works on web and mobile)
  final deletedImages = <String>[]
      .obs; // Track images deleted during editing to remove from storage
  final coverImageIndex = Rxn<int>();
  final slugChecking = false.obs;
  final slugError = Rxn<String>();
  final locationLat = Rxn<double>();
  final locationLng = Rxn<double>();
  final formValidationErrors = <String>[].obs;

  String? get propertyId => Get.parameters['id'];
  static const int maxImages = 5;

  @override
  void onInit() {
    super.onInit();
    _setupTitleListener();
    if (propertyId != null) {
      isEditMode.value = true;
      loadProperty();
    }
  }

  @override
  void onClose() {
    titleController.dispose();
    slugController.dispose();
    shortDescriptionController.dispose();
    fullDescriptionController.dispose();
    countryController.dispose();
    cityController.dispose();
    areaController.dispose();
    addressController.dispose();
    priceAmountController.dispose();
    propertyTypeController.dispose();
    bedroomsController.dispose();
    bathroomsController.dispose();
    areaSizeController.dispose();
    featureController.dispose();
    super.onClose();
  }

  void _setupTitleListener() {
    titleController.addListener(() {
      // Always auto-generate slug from title (only in create mode)
      if (!isEditMode.value) {
        final slug = AppHelpers.generateSlug(titleController.text);
        slugController.text = slug;
        if (slug.isNotEmpty) {
          _checkSlugUniqueness(slug);
        }
      }
    });
  }

  Future<void> _checkSlugUniqueness(String slug) async {
    if (slug.isEmpty) {
      slugError.value = null;
      return;
    }

    slugChecking.value = true;
    slugError.value = null;

    try {
      final exists = await _firestoreService.propertySlugExists(
        slug,
        excludeId: propertyId,
      );
      if (exists) {
        slugError.value = 'This slug is already in use';
      }
    } catch (e) {
      // Silently fail - don't block user
    } finally {
      slugChecking.value = false;
    }
  }

  Future<void> loadProperty() async {
    if (propertyId == null) return;

    setLoading(true);
    clearError();

    try {
      final loadedProperty = await _firestoreService.getPropertyById(
        propertyId!,
      );
      if (loadedProperty != null) {
        property.value = loadedProperty;
        _populateForm(loadedProperty);
      } else {
        AppSnackbar.showError('Property not found');
        Get.back();
      }
    } catch (e) {
      showError('Failed to load property');
      Get.back();
    } finally {
      setLoading(false);
    }
  }

  void _populateForm(PropertyModel prop) {
    titleController.text = prop.title;
    slugController.text = prop.slug;
    shortDescriptionController.text = prop.shortDescription;
    fullDescriptionController.text = prop.fullDescription;
    countryController.text = prop.location.country;
    cityController.text = prop.location.city;
    areaController.text = prop.location.area ?? '';
    addressController.text = prop.location.address ?? '';
    locationLat.value = prop.location.lat;
    locationLng.value = prop.location.lng;
    priceAmountController.text = prop.price.amount?.toString() ?? '';
    currency.value = prop.price.currency;
    isOnRequest.value = prop.price.isOnRequest;
    propertyTypeController.text = prop.specs.propertyType;
    bedroomsController.text = prop.specs.bedrooms?.toString() ?? '';
    bathroomsController.text = prop.specs.bathrooms?.toString() ?? '';
    areaSizeController.text = prop.specs.areaSize?.toString() ?? '';
    areaUnit.value = prop.specs.areaUnit ?? 'sqm';
    status.value = prop.status;
    isFeatured.value = prop.isFeatured;
    isPublished.value = prop.isPublished;
    features.assignAll(prop.features);
    images.assignAll(prop.images);
    deletedImages.clear(); // Clear deleted images when loading property
    coverImageIndex.value = prop.coverImage != null && prop.images.isNotEmpty
        ? prop.images.indexOf(prop.coverImage!)
        : (prop.images.isNotEmpty ? 0 : null);
  }

  void setLocationCoordinates(double? lat, double? lng) {
    locationLat.value = lat;
    locationLng.value = lng;
  }

  void onSlugChanged(String value) {
    _checkSlugUniqueness(value);
  }

  void addFeature() {
    final feature = featureController.text.trim();
    if (feature.isNotEmpty && !features.contains(feature)) {
      features.add(feature);
      featureController.clear();
    }
  }

  void removeFeature(String feature) {
    features.remove(feature);
  }

  Future<void> pickImages() async {
    if (images.length + imageFiles.length >= maxImages) {
      AppSnackbar.showError('Maximum $maxImages images allowed');
      return;
    }

    try {
      final pickedFiles = await _imagePicker.pickMultiImage();
      if (pickedFiles.isNotEmpty) {
        final remainingSlots = maxImages - (images.length + imageFiles.length);
        final filesToAdd = pickedFiles.take(remainingSlots).toList();
        imageFiles.addAll(filesToAdd);

        if (pickedFiles.length > remainingSlots) {
          AppSnackbar.showInfo(
            'Only ${remainingSlots} image(s) added. Maximum $maxImages images allowed.',
          );
        }
      }
    } catch (e) {
      AppSnackbar.showError('Failed to pick images');
    }
  }

  void removeImage(int index) {
    if (index < images.length) {
      // Track deleted image URL for storage deletion
      final deletedImageUrl = images[index];
      if (isEditMode.value) {
        deletedImages.add(deletedImageUrl);
      }
      images.removeAt(index);
      if (coverImageIndex.value == index) {
        coverImageIndex.value = null;
      } else if (coverImageIndex.value != null &&
          coverImageIndex.value! > index) {
        coverImageIndex.value = coverImageIndex.value! - 1;
      }
    } else {
      final fileIndex = index - images.length;
      if (fileIndex < imageFiles.length) {
        imageFiles.removeAt(fileIndex);
      }
    }
  }

  void setCoverImage(int index) {
    // Can set cover image for both uploaded images and local files
    if (index >= 0 && index < (images.length + imageFiles.length)) {
      coverImageIndex.value = index;
    }
  }

  Future<void> saveProperty() async {
    // Ensure slug is auto-generated from title if not in edit mode
    if (!isEditMode.value &&
        slugController.text.isEmpty &&
        titleController.text.isNotEmpty) {
      final slug = AppHelpers.generateSlug(titleController.text);
      slugController.text = slug;
      if (slug.isNotEmpty) {
        await _checkSlugUniqueness(slug);
      }
    }

    // Collect all validation errors
    formValidationErrors.clear();
    final errors = collectValidationErrors();

    // Check slug uniqueness
    if (slugError.value != null) {
      errors.add('Slug: ${slugError.value}');
    }

    // If there are errors, show them and return
    if (errors.isNotEmpty) {
      formValidationErrors.assignAll(errors);
      return;
    }

    // Validate form state
    if (!(formKey.currentState?.validate() ?? false)) {
      return;
    }

    setLoading(true);
    clearError();

    try {
      // Build property model
      final propertyData = _buildPropertyModel();
      String? finalPropertyId = propertyId;

      // Create or update property first to get an ID
      if (isEditMode.value && propertyId != null) {
        await _firestoreService.updateProperty(propertyId!, propertyData);
        finalPropertyId = propertyId;
        AppSnackbar.showSuccess('Property updated successfully');
      } else {
        // Create new property
        finalPropertyId = await _firestoreService.createProperty(propertyData);
        AppSnackbar.showSuccess('Property created successfully');
      }

      // Delete removed images from storage (only in edit mode)
      if (isEditMode.value &&
          deletedImages.isNotEmpty &&
          finalPropertyId != null) {
        await _storageService.deletePropertyImages(deletedImages);
        deletedImages.clear();
      }

      // Upload new images if any (after property is created/updated)
      if (imageFiles.isNotEmpty && finalPropertyId != null) {
        final uploadedUrls = await _storageService.uploadPropertyImages(
          imageFiles,
          finalPropertyId,
        );

        // If cover image was set to a local file, update it to point to the uploaded image
        String? finalCoverImage;
        if (coverImageIndex.value != null) {
          if (coverImageIndex.value! < images.length) {
            // Cover image was an uploaded image
            finalCoverImage = images[coverImageIndex.value!];
          } else {
            // Cover image was a local file - use the corresponding uploaded image
            final localFileIndex = coverImageIndex.value! - images.length;
            if (localFileIndex < uploadedUrls.length) {
              finalCoverImage = uploadedUrls[localFileIndex];
            } else if (uploadedUrls.isNotEmpty) {
              // Fallback to first uploaded image
              finalCoverImage = uploadedUrls.first;
            } else if (images.isNotEmpty) {
              // Fallback to first existing image
              finalCoverImage = images.first;
            }
          }
        } else if (images.isNotEmpty) {
          // No cover image set, use first existing image
          finalCoverImage = images.first;
        } else if (uploadedUrls.isNotEmpty) {
          // No existing images, use first uploaded image
          finalCoverImage = uploadedUrls.first;
        }

        // Update property with new image URLs and cover image
        final updatedProperty = propertyData.copyWith(
          images: [...images, ...uploadedUrls],
          coverImage: finalCoverImage,
        );
        await _firestoreService.updateProperty(
          finalPropertyId,
          updatedProperty,
        );
        imageFiles.clear();
      } else if (isEditMode.value && finalPropertyId != null) {
        // Even if no new images, update property in case images were deleted
        await _firestoreService.updateProperty(finalPropertyId, propertyData);
      }

      // Clear loading state before navigation
      setLoading(false);

      // Small delay to ensure UI is ready
      await Future.delayed(const Duration(milliseconds: 100));

      // Navigate back
      Get.offNamedUntil(
        AdminConstants.routeAdminProperties,
        (route) =>
            route.settings.name == AdminConstants.routeAdminProperties ||
            route.settings.name == AdminConstants.routeAdminDashboard ||
            route.settings.name == AdminConstants.routeAdminLogin ||
            route.settings.name == null,
      );
    } on Exception catch (e) {
      final errorMessage = e.toString().replaceFirst('Exception: ', '');
      AppSnackbar.showError(errorMessage);
      setLoading(false);
    } catch (e) {
      AppSnackbar.showError('Failed to save property');
      setLoading(false);
    }
  }

  PropertyModel _buildPropertyModel() {
    // Cover image can only be set from uploaded images (URLs), not local files
    // If cover image index points to a local file, use first uploaded image or null
    final coverImage =
        coverImageIndex.value != null && coverImageIndex.value! < images.length
        ? images[coverImageIndex.value!]
        : (images.isNotEmpty ? images.first : null);

    return PropertyModel(
      id: propertyId,
      title: titleController.text.trim(),
      slug: slugController.text.trim(),
      shortDescription: shortDescriptionController.text.trim(),
      fullDescription: fullDescriptionController.text.trim(),
      location: PropertyLocation(
        country: countryController.text.trim(),
        city: cityController.text.trim(),
        area: areaController.text.trim(),
        address: addressController.text.trim(),
        lat: locationLat.value,
        lng: locationLng.value,
      ),
      price: PropertyPrice(
        amount: isOnRequest.value
            ? null
            : double.tryParse(priceAmountController.text),
        currency: currency.value,
        isOnRequest: isOnRequest.value,
      ),
      specs: PropertySpecs(
        bedrooms: int.tryParse(bedroomsController.text),
        bathrooms: int.tryParse(bathroomsController.text),
        areaSize: double.tryParse(areaSizeController.text),
        areaUnit: areaUnit.value,
        propertyType: propertyTypeController.text.trim(),
      ),
      features: features.toList(),
      status: status.value,
      images: images.toList(),
      coverImage: coverImage,
      isFeatured: isFeatured.value,
      isPublished: isPublished.value,
      createdAt: property.value?.createdAt,
      updatedAt: DateTime.now(),
    );
  }

  // Validators
  String? validateTitle(String? value) =>
      AppValidators.validatePropertyTitle(value);
  String? validateSlug(String? value) {
    final result = AppValidators.validatePropertySlug(value);
    if (result != null) return result;
    if (slugError.value != null) return slugError.value;
    return null;
  }

  String? validateShortDescription(String? value) =>
      AppValidators.validatePropertyDescription(value, isShort: true);
  String? validateFullDescription(String? value) =>
      AppValidators.validatePropertyDescription(value, isShort: false);
  String? validateCountry(String? value) =>
      AppValidators.validatePropertyLocation(value, 'Country');
  String? validateCity(String? value) =>
      AppValidators.validatePropertyLocation(value, 'City');
  String? validatePrice(String? value) =>
      AppValidators.validatePropertyPriceRequired(value, isOnRequest.value);
  String? validatePropertyType(String? value) =>
      AppValidators.validatePropertyType(value);
  String? validateBedrooms(String? value) =>
      AppValidators.validatePropertyBedroomsRequired(value);
  String? validateBathrooms(String? value) =>
      AppValidators.validatePropertyBathroomsRequired(value);
  String? validateAreaSize(String? value) =>
      AppValidators.validatePropertyAreaSize(value);
  String? validateArea(String? value) =>
      AppValidators.validatePropertyArea(value);
  String? validateAddress(String? value) =>
      AppValidators.validatePropertyAddress(value);

  /// Collect all validation errors
  List<String> collectValidationErrors() {
    final errors = <String>[];

    // Ensure slug is auto-generated from title if not in edit mode
    if (!isEditMode.value &&
        slugController.text.isEmpty &&
        titleController.text.isNotEmpty) {
      final slug = AppHelpers.generateSlug(titleController.text);
      slugController.text = slug;
      if (slug.isNotEmpty) {
        _checkSlugUniqueness(slug);
      }
    }

    if (formKey.currentState != null) {
      formKey.currentState!.validate();
    }

    // Check each field manually
    if (validateTitle(titleController.text) != null) {
      errors.add('Title: ${validateTitle(titleController.text)}');
    }
    // Slug is auto-generated, but we still validate it
    if (slugController.text.isEmpty) {
      errors.add('Slug: Slug is required (auto-generated from title)');
    } else if (validateSlug(slugController.text) != null) {
      errors.add('Slug: ${validateSlug(slugController.text)}');
    }
    if (validateShortDescription(shortDescriptionController.text) != null) {
      errors.add(
        'Short Description: ${validateShortDescription(shortDescriptionController.text)}',
      );
    }
    if (validateFullDescription(fullDescriptionController.text) != null) {
      errors.add(
        'Full Description: ${validateFullDescription(fullDescriptionController.text)}',
      );
    }
    if (validateCountry(countryController.text) != null) {
      errors.add('Country: ${validateCountry(countryController.text)}');
    }
    if (validateCity(cityController.text) != null) {
      errors.add('City: ${validateCity(cityController.text)}');
    }
    if (validateArea(areaController.text) != null) {
      errors.add('Area: ${validateArea(areaController.text)}');
    }
    if (validateAddress(addressController.text) != null) {
      errors.add('Address: ${validateAddress(addressController.text)}');
    }
    if (locationLat.value == null || locationLng.value == null) {
      errors.add('Location: Please select a location on the map');
    }
    if (validatePrice(priceAmountController.text) != null) {
      errors.add('Price: ${validatePrice(priceAmountController.text)}');
    }
    if (validatePropertyType(propertyTypeController.text) != null) {
      errors.add(
        'Property Type: ${validatePropertyType(propertyTypeController.text)}',
      );
    }
    if (validateBedrooms(bedroomsController.text) != null) {
      errors.add('Bedrooms: ${validateBedrooms(bedroomsController.text)}');
    }
    if (validateBathrooms(bathroomsController.text) != null) {
      errors.add('Bathrooms: ${validateBathrooms(bathroomsController.text)}');
    }
    if (validateAreaSize(areaSizeController.text) != null) {
      errors.add('Area Size: ${validateAreaSize(areaSizeController.text)}');
    }
    if (features.isEmpty) {
      errors.add('Features: At least one feature is required');
    }
    if (images.isEmpty && imageFiles.isEmpty) {
      errors.add('Images: At least one image is required');
    }

    return errors;
  }
}
