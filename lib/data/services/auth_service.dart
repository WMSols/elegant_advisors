import 'package:firebase_auth/firebase_auth.dart';
import 'package:elegant_advisors/domain/models/admin_user_model.dart';
import 'package:elegant_advisors/data/services/firestore_service.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirestoreService _firestoreService = FirestoreService();

  User? get currentUser => _auth.currentUser;
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  /// Sign in with email and password
  /// Returns user credential on success
  /// Throws formatted error message on failure
  Future<UserCredential> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      return credential;
    } on FirebaseAuthException catch (e) {
      // Handle specific Firebase Auth errors with user-friendly messages
      String errorMessage;
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'No account found with this email address.';
          break;
        case 'wrong-password':
          errorMessage = 'Incorrect password. Please try again.';
          break;
        case 'invalid-email':
          errorMessage = 'Invalid email address format.';
          break;
        case 'user-disabled':
          errorMessage =
              'This account has been disabled. Please contact support.';
          break;
        case 'too-many-requests':
          errorMessage =
              'Too many failed login attempts. Please try again later.';
          break;
        case 'operation-not-allowed':
          errorMessage = 'Email/password sign-in is not enabled.';
          break;
        case 'network-request-failed':
          errorMessage =
              'Network error. Please check your internet connection.';
          break;
        case 'invalid-credential':
          errorMessage =
              'Invalid email or password. Please check your credentials.';
          break;
        default:
          errorMessage =
              'Login failed: ${e.message ?? 'Unknown error occurred'}';
      }
      throw Exception(errorMessage);
    } catch (e) {
      // Handle non-Firebase errors
      if (e is Exception) {
        rethrow;
      }
      throw Exception('An unexpected error occurred. Please try again.');
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
