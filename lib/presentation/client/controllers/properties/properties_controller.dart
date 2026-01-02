import 'package:get/get.dart';
import 'package:elegant_advisors/data/services/firestore_service.dart';
import 'package:elegant_advisors/data/services/analytics_service.dart';
import 'package:elegant_advisors/domain/models/property_model.dart';
import 'package:elegant_advisors/presentation/base_controller.dart';

class PropertiesController extends BaseController {
  final FirestoreService _firestoreService = FirestoreService();
  final AnalyticsService _analyticsService = AnalyticsService();

  final properties = <PropertyModel>[].obs;
  final featuredProperties = <PropertyModel>[].obs;
  final isLoadingProperties = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadProperties();
  }

  Future<void> loadProperties() async {
    isLoadingProperties.value = true;
    try {
      final fetchedProperties = await _firestoreService
          .getPublishedPropertiesOnce();
      properties.value = fetchedProperties;
      featuredProperties.value = fetchedProperties
          .where((p) => p.isFeatured)
          .toList();
    } catch (e) {
      showError('Failed to load properties');
    } finally {
      isLoadingProperties.value = false;
    }
  }

  Future<void> viewProperty(PropertyModel property) async {
    await _analyticsService.logPropertyView(property.id ?? '', property.title);
  }

  PropertyModel? getPropertyBySlug(String slug) {
    try {
      return properties.firstWhere((p) => p.slug == slug);
    } catch (e) {
      return null;
    }
  }
}
