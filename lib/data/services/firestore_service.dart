import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elegant_advisors/domain/models/property_model.dart';
import 'package:elegant_advisors/domain/models/team_model.dart';
import 'package:elegant_advisors/domain/models/site_content_model.dart';
import 'package:elegant_advisors/domain/models/contact_submission_model.dart';
import 'package:elegant_advisors/domain/models/admin_user_model.dart';
import 'package:elegant_advisors/domain/models/visitor_model.dart';
import 'package:elegant_advisors/domain/models/visit_tracking_model.dart';

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
    final docRef = await _firestore
        .collection(visitorsCollection)
        .add(visitor.toJson());
    return docRef.id;
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
    final today = DateTime.now();
    final dateKey =
        '${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}';

    final trackingDocRef = _firestore
        .collection(visitTrackingCollection)
        .doc(propertyId);

    final trackingDoc = await trackingDocRef.get();

    if (trackingDoc.exists) {
      final currentData = trackingDoc.data() as Map<String, dynamic>;
      final currentTotal = currentData['totalVisits'] ?? 0;
      final currentUnique = currentData['uniqueVisits'] ?? 0;
      final visitsByDate = Map<String, int>.from(
        currentData['visitsByDate'] ?? {},
      );

      // Increment total visits
      final newTotal = currentTotal + 1;

      // Check if this is a unique visit (by IP)
      int newUnique = currentUnique;
      if (ipAddress != null) {
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
            .get();

        if (todayVisits.docs.isEmpty) {
          newUnique = currentUnique + 1;
        }
      }

      // Update date-wise tracking
      visitsByDate[dateKey] = (visitsByDate[dateKey] ?? 0) + 1;

      await trackingDocRef.update({
        'totalVisits': newTotal,
        'uniqueVisits': newUnique,
        'visitsByDate': visitsByDate,
        'lastVisitedAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } else {
      // Create new tracking document
      final visitsByDate = {dateKey: 1};
      await trackingDocRef.set({
        'propertyId': propertyId,
        'totalVisits': 1,
        'uniqueVisits': ipAddress != null ? 1 : 0,
        'visitsByDate': visitsByDate,
        'lastVisitedAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });
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
}
