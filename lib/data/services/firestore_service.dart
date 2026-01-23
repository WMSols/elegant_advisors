import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elegant_advisors/domain/models/property_model.dart';
import 'package:elegant_advisors/domain/models/team_model.dart';
import 'package:elegant_advisors/domain/models/site_content_model.dart';
import 'package:elegant_advisors/domain/models/contact_submission_model.dart';
import 'package:elegant_advisors/domain/models/admin_user_model.dart';
import 'package:elegant_advisors/domain/models/visitor_model.dart';
import 'package:elegant_advisors/domain/models/visit_tracking_model.dart';
import 'package:elegant_advisors/core/utils/app_ip_helpers/app_ip_helper.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Properties Collection
  static const String propertiesCollection = 'properties';
  static const String teamCollection = 'team';
  static const String siteContentCollection = 'site_content';
  static const String contactSubmissionsCollection = 'contact_submissions';
  static const String adminUsersCollection = 'admin_users';
  static const String analyticsCollection = 'analytics_daily';
  static const String visitorsCollection = 'visitors';
  static const String visitTrackingCollection = 'visit_tracking';

  // Properties
  Stream<List<PropertyModel>> getPublishedProperties() {
    return _firestore
        .collection(propertiesCollection)
        .where('isPublished', isEqualTo: true)
        .orderBy('sortOrder')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => PropertyModel.fromJson(doc.data(), doc.id))
              .toList(),
        );
  }

  Future<List<PropertyModel>> getPublishedPropertiesOnce() async {
    final snapshot = await _firestore
        .collection(propertiesCollection)
        .where('isPublished', isEqualTo: true)
        .orderBy('sortOrder')
        .orderBy('createdAt', descending: true)
        .get();
    return snapshot.docs
        .map((doc) => PropertyModel.fromJson(doc.data(), doc.id))
        .toList();
  }

  Future<PropertyModel?> getPropertyById(String id) async {
    final doc = await _firestore.collection(propertiesCollection).doc(id).get();
    if (doc.exists) {
      return PropertyModel.fromJson(doc.data()!, doc.id);
    }
    return null;
  }

  Future<PropertyModel?> getPropertyBySlug(String slug) async {
    final snapshot = await _firestore
        .collection(propertiesCollection)
        .where('slug', isEqualTo: slug)
        .where('isPublished', isEqualTo: true)
        .limit(1)
        .get();
    if (snapshot.docs.isNotEmpty) {
      return PropertyModel.fromJson(
        snapshot.docs.first.data(),
        snapshot.docs.first.id,
      );
    }
    return null;
  }

  // Admin: Check if slug exists (for validation)
  Future<bool> propertySlugExists(String slug, {String? excludeId}) async {
    var query = _firestore
        .collection(propertiesCollection)
        .where('slug', isEqualTo: slug)
        .limit(1);

    final snapshot = await query.get();
    if (snapshot.docs.isEmpty) return false;

    // If excludeId is provided, check if the found document is different
    if (excludeId != null) {
      return snapshot.docs.first.id != excludeId;
    }

    return true;
  }

  // Admin: Properties CRUD
  Stream<List<PropertyModel>> getAllProperties() {
    return _firestore
        .collection(propertiesCollection)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => PropertyModel.fromJson(doc.data(), doc.id))
              .toList(),
        );
  }

  Future<String> createProperty(PropertyModel property) async {
    final docRef = await _firestore
        .collection(propertiesCollection)
        .add(property.toJson());
    return docRef.id;
  }

  Future<void> updateProperty(String id, PropertyModel property) async {
    await _firestore
        .collection(propertiesCollection)
        .doc(id)
        .update(property.toJson());
  }

  Future<void> deleteProperty(String id) async {
    await _firestore.collection(propertiesCollection).doc(id).delete();
  }

  // Team
  Stream<List<TeamModel>> getPublishedTeam() {
    return _firestore
        .collection(teamCollection)
        .where('isPublished', isEqualTo: true)
        .orderBy('sortOrder')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => TeamModel.fromJson(doc.data(), doc.id))
              .toList(),
        );
  }

  Future<List<TeamModel>> getPublishedTeamOnce() async {
    final snapshot = await _firestore
        .collection(teamCollection)
        .where('isPublished', isEqualTo: true)
        .orderBy('sortOrder')
        .get();
    return snapshot.docs
        .map((doc) => TeamModel.fromJson(doc.data(), doc.id))
        .toList();
  }

  // Admin: Team CRUD
  Stream<List<TeamModel>> getAllTeam() {
    return _firestore
        .collection(teamCollection)
        .orderBy('sortOrder')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => TeamModel.fromJson(doc.data(), doc.id))
              .toList(),
        );
  }

  Future<String> createTeamMember(TeamModel team) async {
    final docRef = await _firestore
        .collection(teamCollection)
        .add(team.toJson());
    return docRef.id;
  }

  Future<void> updateTeamMember(String id, TeamModel team) async {
    await _firestore.collection(teamCollection).doc(id).update(team.toJson());
  }

  Future<void> deleteTeamMember(String id) async {
    await _firestore.collection(teamCollection).doc(id).delete();
  }

  // Site Content
  Future<SiteContentModel?> getSiteContent(String pageId) async {
    final doc = await _firestore
        .collection(siteContentCollection)
        .doc(pageId)
        .get();
    if (doc.exists) {
      return SiteContentModel.fromJson(doc.data()!, doc.id);
    }
    return null;
  }

  Stream<SiteContentModel?> getSiteContentStream(String pageId) {
    return _firestore
        .collection(siteContentCollection)
        .doc(pageId)
        .snapshots()
        .map(
          (doc) => doc.exists
              ? SiteContentModel.fromJson(doc.data()!, doc.id)
              : null,
        );
  }

  // Admin: Site Content CRUD
  Stream<List<SiteContentModel>> getAllSiteContent() {
    return _firestore
        .collection(siteContentCollection)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => SiteContentModel.fromJson(doc.data(), doc.id))
              .toList(),
        );
  }

  Future<void> updateSiteContent(
    String pageId,
    SiteContentModel content,
  ) async {
    await _firestore
        .collection(siteContentCollection)
        .doc(pageId)
        .set(content.toJson(), SetOptions(merge: true));
  }

  // Contact Submissions
  Future<String> createContactSubmission(
    ContactSubmissionModel submission,
  ) async {
    final docRef = await _firestore
        .collection(contactSubmissionsCollection)
        .add(submission.toJson());
    return docRef.id;
  }

  // Client: Get contact submissions by email
  Stream<List<ContactSubmissionModel>> getContactSubmissionsByEmail(
    String email,
  ) {
    return _firestore
        .collection(contactSubmissionsCollection)
        .where('email', isEqualTo: email.trim().toLowerCase())
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => ContactSubmissionModel.fromJson(doc.data(), doc.id))
              .toList(),
        );
  }

  // Client: Get contact submissions by email (one-time fetch)
  Future<List<ContactSubmissionModel>> getContactSubmissionsByEmailOnce(
    String email,
  ) async {
    try {
      // Try query with orderBy first (requires composite index)
      final snapshot = await _firestore
          .collection(contactSubmissionsCollection)
          .where('email', isEqualTo: email.trim().toLowerCase())
          .orderBy('createdAt', descending: true)
          .get();
      return snapshot.docs
          .map((doc) => ContactSubmissionModel.fromJson(doc.data(), doc.id))
          .toList();
    } catch (e) {
      // If index error, fall back to query without orderBy and sort in memory
      final errorString = e.toString().toLowerCase();
      if (errorString.contains('index') ||
          errorString.contains('requires an index')) {
        // Fallback: query without orderBy and sort in memory
        final snapshot = await _firestore
            .collection(contactSubmissionsCollection)
            .where('email', isEqualTo: email.trim().toLowerCase())
            .get();
        final contacts = snapshot.docs
            .map((doc) => ContactSubmissionModel.fromJson(doc.data(), doc.id))
            .toList();
        // Sort by createdAt descending
        contacts.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        return contacts;
      }
      // Re-throw if it's not an index error
      rethrow;
    }
  }

  // Admin: Contact Submissions
  Stream<List<ContactSubmissionModel>> getAllContactSubmissions() {
    return _firestore
        .collection(contactSubmissionsCollection)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => ContactSubmissionModel.fromJson(doc.data(), doc.id))
              .toList(),
        );
  }

  Future<void> updateContactSubmissionStatus(String id, String status) async {
    await _firestore.collection(contactSubmissionsCollection).doc(id).update({
      'status': status,
    });
  }

  Future<void> deleteContactSubmission(String id) async {
    await _firestore.collection(contactSubmissionsCollection).doc(id).delete();
  }

  // Admin Users
  Future<AdminUserModel?> getAdminUser(String uid) async {
    final doc = await _firestore
        .collection(adminUsersCollection)
        .doc(uid)
        .get();
    if (doc.exists) {
      return AdminUserModel.fromJson(doc.data()!, doc.id);
    }
    return null;
  }

  Future<void> createAdminUser(String uid, AdminUserModel adminUser) async {
    await _firestore
        .collection(adminUsersCollection)
        .doc(uid)
        .set(adminUser.toJson());
  }

  // Admin: Get all admin users
  Stream<List<AdminUserModel>> getAllAdminUsers() {
    return _firestore
        .collection(adminUsersCollection)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => AdminUserModel.fromJson(doc.data(), doc.id))
              .toList(),
        );
  }

  Future<void> updateAdminUser(String uid, AdminUserModel adminUser) async {
    await _firestore
        .collection(adminUsersCollection)
        .doc(uid)
        .update(adminUser.toJson());
  }

  Future<void> deleteAdminUser(String uid) async {
    await _firestore.collection(adminUsersCollection).doc(uid).delete();
  }

  // Analytics - Daily Visitors
  Future<void> incrementDailyVisitor() async {
    final today = DateTime.now();
    final dateKey =
        '${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}';

    final docRef = _firestore.collection(analyticsCollection).doc(dateKey);
    await docRef.set({
      'date': dateKey,
      'visitors': FieldValue.increment(1),
      'lastUpdated': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  Future<Map<String, int>> getDailyVisitors(int days) async {
    final today = DateTime.now();
    final dates = List.generate(days, (i) {
      final date = today.subtract(Duration(days: i));
      return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    });

    final Map<String, int> result = {};
    for (final date in dates) {
      final doc = await _firestore
          .collection(analyticsCollection)
          .doc(date)
          .get();
      result[date] = doc.data()?['visitors'] ?? 0;
    }
    return result;
  }

  Future<int> getTodayVisitors() async {
    final today = DateTime.now();
    final dateKey =
        '${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}';
    final doc = await _firestore
        .collection(analyticsCollection)
        .doc(dateKey)
        .get();
    return doc.data()?['visitors'] ?? 0;
  }

  // Visitor Tracking
  Future<String> createVisitor(VisitorModel visitor) async {
    try {
      final visitorData = visitor.toJson();
      final docRef = await _firestore
          .collection(visitorsCollection)
          .add(visitorData);
      return docRef.id;
    } catch (e) {
      rethrow; // Re-throw to be caught by caller
    }
  }

  Stream<List<VisitorModel>> getVisitors({
    String? propertyId,
    DateTime? startDate,
    DateTime? endDate,
    int? limit,
  }) {
    Query query = _firestore.collection(visitorsCollection);

    if (propertyId != null) {
      query = query.where('propertyId', isEqualTo: propertyId);
    }

    if (startDate != null) {
      query = query.where(
        'visitedAt',
        isGreaterThanOrEqualTo: Timestamp.fromDate(startDate),
      );
    }

    if (endDate != null) {
      query = query.where(
        'visitedAt',
        isLessThanOrEqualTo: Timestamp.fromDate(endDate),
      );
    }

    query = query.orderBy('visitedAt', descending: true);

    if (limit != null) {
      query = query.limit(limit);
    }

    return query.snapshots().map(
      (snapshot) => snapshot.docs
          .map(
            (doc) => VisitorModel.fromJson(
              doc.data() as Map<String, dynamic>,
              doc.id,
            ),
          )
          .toList(),
    );
  }

  // Property Visit Tracking
  Future<void> incrementPropertyVisit(
    String propertyId,
    String? ipAddress,
  ) async {
    // Validate propertyId
    if (propertyId.isEmpty) {
      return;
    }

    final today = DateTime.now();
    final dateKey =
        '${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}';

    // Always create visitor record FIRST (before checking tracking document)
    // This ensures visitor record is created even if tracking document check fails
    bool isUniqueVisit = false;
    
    try {
      // Get additional visitor information
      final userAgent = AppIPHelper.getUserAgent();
      final referrer = AppIPHelper.getReferrer();

      final visitor = VisitorModel(
        ipAddress: ipAddress,
        userAgent: userAgent,
        referrer: referrer,
        propertyId: propertyId,
        pagePath: '/properties/$propertyId',
        visitedAt: DateTime.now(),
      );
      
      await createVisitor(visitor);
    } catch (e) {
      // Silently fail - visitor creation is not critical
    }

    // Check if this is a unique visit (by IP) for unique visit counting
    // Note: This query might fail due to permissions, but we'll try anyway
    if (ipAddress != null && ipAddress.isNotEmpty) {
      try {
        // Check if this IP visited this property today
        final todayVisits = await _firestore
            .collection(visitorsCollection)
            .where('propertyId', isEqualTo: propertyId)
            .where('ipAddress', isEqualTo: ipAddress)
            .where(
              'visitedAt',
              isGreaterThanOrEqualTo: Timestamp.fromDate(
                DateTime(today.year, today.month, today.day),
              ),
            )
            .limit(1) // Only need to know if any exist
            .get();

        isUniqueVisit = todayVisits.docs.isEmpty;
      } catch (e) {
        // Default to not unique if we can't check
        isUniqueVisit = false;
      }
    } else {
      isUniqueVisit = false;
    }

    // Update visit tracking using set with merge (no read permission needed)
    // This will create the document if it doesn't exist, or update if it does
    final trackingDocRef = _firestore
        .collection(visitTrackingCollection)
        .doc(propertyId);

    try {
      // Use set with merge to create or update
      // Use FieldValue.increment for counters (works even if field doesn't exist)
      final updateData = <String, dynamic>{
        'propertyId': propertyId,
        'totalVisits': FieldValue.increment(1),
        'lastVisitedAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      };

      // For unique visits, we need to increment only if it's unique
      // Since we can't read the current value, we'll use a transaction-like approach
      // But since we can't use transactions without read, we'll just set it
      // The unique visit count will be approximate (might be slightly off)
      if (isUniqueVisit) {
        updateData['uniqueVisits'] = FieldValue.increment(1);
      }

      // For date-wise tracking, we need to merge the visitsByDate map
      // Since we can't read, we'll use set with merge and increment
      // Note: This is approximate since we can't read current value
      updateData['visitsByDate.$dateKey'] = FieldValue.increment(1);

      await trackingDocRef.set(updateData, SetOptions(merge: true));
    } catch (e) {
      // Don't throw - visitor record is already created, which is the main goal
    }
  }

  Future<VisitTrackingModel?> getPropertyVisitTracking(
    String propertyId,
  ) async {
    final doc = await _firestore
        .collection(visitTrackingCollection)
        .doc(propertyId)
        .get();

    if (doc.exists) {
      return VisitTrackingModel.fromJson(doc.data()!, doc.id);
    }
    return null;
  }

  Stream<List<VisitTrackingModel>> getTopViewedProperties({int limit = 10}) {
    return _firestore
        .collection(visitTrackingCollection)
        .orderBy('totalVisits', descending: true)
        .limit(limit)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => VisitTrackingModel.fromJson(doc.data(), doc.id))
              .toList(),
        );
  }

  // Visitor Tracking Statistics
  /// Get total number of visitors (from visitors collection)
  Future<int> getTotalVisitorsCount() async {
    try {
      final snapshot = await _firestore
          .collection(visitorsCollection)
          .count()
          .get();
      return snapshot.count ?? 0;
    } catch (e) {
      return 0;
    }
  }

  /// Get today's visitors count (from visitors collection)
  Future<int> getTodayVisitorsCount() async {
    try {
      final today = DateTime.now();
      final startOfDay = DateTime(today.year, today.month, today.day);
      
      final snapshot = await _firestore
          .collection(visitorsCollection)
          .where(
            'visitedAt',
            isGreaterThanOrEqualTo: Timestamp.fromDate(startOfDay),
          )
          .count()
          .get();
      
      return snapshot.count ?? 0;
    } catch (e) {
      return 0;
    }
  }

  /// Get total property visits (sum of all totalVisits from visit_tracking)
  Future<int> getTotalPropertyVisits() async {
    try {
      final snapshot = await _firestore
          .collection(visitTrackingCollection)
          .get();
      
      int total = 0;
      for (var doc in snapshot.docs) {
        final data = doc.data();
        final visits = data['totalVisits'];
        if (visits != null) {
          total += (visits as num).toInt();
        }
      }
      
      return total;
    } catch (e) {
      print('Error getting total property visits: $e');
      return 0;
    }
  }

  /// Get total unique property visits (sum of all uniqueVisits from visit_tracking)
  Future<int> getTotalUniquePropertyVisits() async {
    try {
      final snapshot = await _firestore
          .collection(visitTrackingCollection)
          .get();
      
      int total = 0;
      for (var doc in snapshot.docs) {
        final data = doc.data();
        final visits = data['uniqueVisits'];
        if (visits != null) {
          total += (visits as num).toInt();
        }
      }
      
      return total;
    } catch (e) {
      return 0;
    }
  }
}
