import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:elegant_advisors/data/services/firestore_service.dart';
import 'package:elegant_advisors/data/services/storage_service.dart';
import 'package:elegant_advisors/data/services/translation_service.dart';
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
            'Only $remainingSlots image(s) added. Maximum $maxImages images allowed.',
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
      // Show translation progress
      AppSnackbar.showInfo('Translating to Portuguese...');

      // Build property model with automatic translation
      final propertyData = await _buildPropertyModelWithTranslation();
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

  /// Build property model with automatic English to Portuguese translation
  Future<PropertyModel> _buildPropertyModelWithTranslation() async {
    // Cover image can only be set from uploaded images (URLs), not local files
    // If cover image index points to a local file, use first uploaded image or null
    final coverImage =
        coverImageIndex.value != null && coverImageIndex.value! < images.length
        ? images[coverImageIndex.value!]
        : (images.isNotEmpty ? images.first : null);

    // Get English text values from form
    final titleEn = titleController.text.trim();
    final shortDescEn = shortDescriptionController.text.trim();
    final fullDescEn = fullDescriptionController.text.trim();
    final featuresListEn = features.toList();
    final countryEn = countryController.text.trim();
    final cityEn = cityController.text.trim();
    final areaEn = areaController.text.trim();
    final addressEn = addressController.text.trim();
    final propertyTypeEn = propertyTypeController.text.trim();

    // Check if editing existing property with multilingual data
    final existingProperty = property.value;
    final isEditingMultilingual =
        existingProperty != null && existingProperty.isMultilingual;

    // Translate all English text to Portuguese with error tracking
    final translationErrors = <String>[];

    final titleResult = await TranslationService.translateToPortuguese(titleEn);
    final titlePt = titleResult.translatedText;
    if (!titleResult.success && titleResult.errorMessage != null) {
      translationErrors.add('Title: ${titleResult.errorMessage}');
    }

    final shortDescResult = await TranslationService.translateToPortuguese(
      shortDescEn,
    );
    final shortDescPt = shortDescResult.translatedText;
    if (!shortDescResult.success && shortDescResult.errorMessage != null) {
      translationErrors.add(
        'Short Description: ${shortDescResult.errorMessage}',
      );
    }

    final fullDescResult = await TranslationService.translateToPortuguese(
      fullDescEn,
    );
    final fullDescPt = fullDescResult.translatedText;
    if (!fullDescResult.success && fullDescResult.errorMessage != null) {
      translationErrors.add('Full Description: ${fullDescResult.errorMessage}');
    }

    final countryResult = await TranslationService.translateToPortuguese(
      countryEn,
    );
    final countryPt = countryResult.translatedText;
    if (!countryResult.success && countryResult.errorMessage != null) {
      translationErrors.add('Country: ${countryResult.errorMessage}');
    }

    final cityResult = await TranslationService.translateToPortuguese(cityEn);
    final cityPt = cityResult.translatedText;
    if (!cityResult.success && cityResult.errorMessage != null) {
      translationErrors.add('City: ${cityResult.errorMessage}');
    }

    final areaPt = areaEn.isNotEmpty
        ? (await TranslationService.translateToPortuguese(
            areaEn,
          )).translatedText
        : '';

    final addressPt = addressEn.isNotEmpty
        ? (await TranslationService.translateToPortuguese(
            addressEn,
          )).translatedText
        : '';

    final propertyTypeResult = await TranslationService.translateToPortuguese(
      propertyTypeEn,
    );
    final propertyTypePt = propertyTypeResult.translatedText;
    if (!propertyTypeResult.success &&
        propertyTypeResult.errorMessage != null) {
      translationErrors.add(
        'Property Type: ${propertyTypeResult.errorMessage}',
      );
    }

    // Translate features list
    final featuresResults = await TranslationService.translateListToPortuguese(
      featuresListEn,
    );
    final featuresListPt = featuresResults
        .map((r) => r.translatedText)
        .toList();
    final failedFeatures = featuresResults
        .where((r) => !r.success)
        .map((r) => r.errorMessage ?? 'Translation failed')
        .toList();
    if (failedFeatures.isNotEmpty) {
      translationErrors.add('Features: ${failedFeatures.join(', ')}');
    }

    // Show success message if all translations succeeded
    // Note: If translations fail, we silently use English as fallback (no warning shown)
    if (translationErrors.isEmpty) {
      final cachedCount = [
        titleResult,
        shortDescResult,
        fullDescResult,
        countryResult,
        cityResult,
        propertyTypeResult,
        ...featuresResults,
      ].where((r) => r.fromCache).length;

      if (cachedCount > 0) {
        AppSnackbar.showSuccess(
          'Translation completed! ($cachedCount from cache)',
        );
      } else {
        AppSnackbar.showSuccess('Translation completed successfully!');
      }
    }

    // Helper function to create or update multilingual map
    Map<String, String> createOrUpdateMultilingualMap(
      dynamic existingValue,
      String englishValue,
      String portugueseValue,
    ) {
      if (isEditingMultilingual && existingValue is Map<String, dynamic>) {
        // Preserve existing Portuguese translation if it exists and is different from English
        final map = Map<String, String>.from(
          existingValue.map((k, v) => MapEntry(k, v.toString())),
        );
        map['en'] = englishValue;
        // Only update Portuguese if it was the same as English (meaning it needs translation)
        // Otherwise, preserve the existing Portuguese translation
        if (map['pt'] == map['en'] || map['pt'] == null || map['pt']!.isEmpty) {
          map['pt'] = portugueseValue;
        }
        return map;
      } else {
        // Create new multilingual map with English and Portuguese
        return {'en': englishValue, 'pt': portugueseValue};
      }
    }

    // Build multilingual maps with translations
    final titleMap = createOrUpdateMultilingualMap(
      existingProperty?.rawTitle,
      titleEn,
      titlePt,
    );
    final shortDescMap = createOrUpdateMultilingualMap(
      existingProperty?.rawShortDescription,
      shortDescEn,
      shortDescPt,
    );
    final fullDescMap = createOrUpdateMultilingualMap(
      existingProperty?.rawFullDescription,
      fullDescEn,
      fullDescPt,
    );
    final countryMap = createOrUpdateMultilingualMap(
      existingProperty?.location.rawCountry,
      countryEn,
      countryPt,
    );
    final cityMap = createOrUpdateMultilingualMap(
      existingProperty?.location.rawCity,
      cityEn,
      cityPt,
    );
    final areaMap = areaEn.isNotEmpty
        ? createOrUpdateMultilingualMap(
            existingProperty?.location.rawArea,
            areaEn,
            areaPt,
          )
        : null;
    final addressMap = addressEn.isNotEmpty
        ? createOrUpdateMultilingualMap(
            existingProperty?.location.rawAddress,
            addressEn,
            addressPt,
          )
        : null;
    final propertyTypeMap = createOrUpdateMultilingualMap(
      existingProperty?.specs.rawPropertyType,
      propertyTypeEn,
      propertyTypePt,
    );

    // Build features map with translations
    Map<String, List<String>> featuresMap;
    if (isEditingMultilingual) {
      final existingFeatures =
          existingProperty.rawFeatures as Map<String, dynamic>;
      featuresMap = Map<String, List<String>>.from(
        existingFeatures.map(
          (k, v) => MapEntry(
            k,
            v is List ? v.map((e) => e.toString()).toList() : [v.toString()],
          ),
        ),
      );
      featuresMap['en'] = featuresListEn;
      // Only update Portuguese if it was the same as English
      if (featuresMap['pt'] == null ||
          (featuresMap['pt']?.length == featuresListEn.length &&
              featuresMap['pt']!.every(
                (item) => featuresListEn.contains(item),
              ))) {
        featuresMap['pt'] = featuresListPt;
      }
    } else {
      featuresMap = {'en': featuresListEn, 'pt': featuresListPt};
    }

    return PropertyModel(
      id: propertyId,
      title: titleMap,
      slug: slugController.text.trim(),
      shortDescription: shortDescMap,
      fullDescription: fullDescMap,
      location: PropertyLocation(
        country: countryMap,
        city: cityMap,
        area: areaMap,
        address: addressMap,
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
        propertyType: propertyTypeMap,
      ),
      features: featuresMap,
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
