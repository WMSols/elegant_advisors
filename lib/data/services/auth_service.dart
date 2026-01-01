import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/models/admin_user_model.dart';
import 'firestore_service.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirestoreService _firestoreService = FirestoreService();

  User? get currentUser => _auth.currentUser;
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<UserCredential?> signInWithEmailAndPassword(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print('Sign in error: $e');
      rethrow;
    }
  }

  Future<void> signOut() async => await _auth.signOut();

  Future<bool> isAdmin() async {
    final user = currentUser;
    if (user == null) return false;
    final adminUser = await _firestoreService.getAdminUser(user.uid);
    return adminUser != null;
  }

  Future<AdminUserModel?> getAdminUserData() async {
    final user = currentUser;
    if (user == null) return null;
    return await _firestoreService.getAdminUser(user.uid);
  }

  Future<void> createAdminUser(AdminUserModel adminUser) async {
    final user = currentUser;
    if (user == null) throw Exception('No authenticated user');
    await _firestoreService.createAdminUser(user.uid, adminUser);
  }
}
