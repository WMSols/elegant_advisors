import 'package:firebase_analytics/firebase_analytics.dart';
import 'firestore_service.dart';

class AnalyticsService {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
  final FirestoreService _firestoreService = FirestoreService();

  Future<void> logPageView({required String pageName, String? pagePath}) async {
    try {
      await _analytics.logScreenView(screenName: pageName, screenClass: pageName);
      await _firestoreService.incrementDailyVisitor();
    } catch (e) {
      print('Analytics error: $e');
    }
  }

  Future<void> logPropertyView(String propertyId, String propertyTitle) async {
    try {
      await _analytics.logEvent(
        name: 'property_view',
        parameters: {'property_id': propertyId, 'property_title': propertyTitle},
      );
    } catch (e) {
      print('Analytics error: $e');
    }
  }

  Future<void> logContactSubmit() async {
    try {
      await _analytics.logEvent(name: 'contact_submit', parameters: {});
    } catch (e) {
      print('Analytics error: $e');
    }
  }

  Future<void> logEvent(String eventName, Map<String, Object> parameters) async {
    try {
      await _analytics.logEvent(name: eventName, parameters: parameters);
    } catch (e) {
      print('Analytics error: $e');
    }
  }
}
