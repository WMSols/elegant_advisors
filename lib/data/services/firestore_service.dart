import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elegant_advisors/domain/models/property_model.dart';
import 'package:elegant_advisors/domain/models/team_model.dart';
import 'package:elegant_advisors/domain/models/site_content_model.dart';
import 'package:elegant_advisors/domain/models/contact_submission_model.dart';
import 'package:elegant_advisors/domain/models/admin_user_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Properties Collection
  static const String propertiesCollection = 'properties';
  static const String teamCollection = 'team';
  static const String siteContentCollection = 'site_content';
  static const String contactSubmissionsCollection = 'contact_submissions';
  static const String adminUsersCollection = 'admin_users';
  static const String analyticsCollection = 'analytics_daily';

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
}
