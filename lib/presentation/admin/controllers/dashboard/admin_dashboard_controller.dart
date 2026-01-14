import 'package:get/get.dart';
import 'package:elegant_advisors/data/services/firestore_service.dart';
import 'package:elegant_advisors/data/services/auth_service.dart';
import 'package:elegant_advisors/core/base/base_controller/app_base_controller.dart';
import 'package:elegant_advisors/core/constants/admin_constants.dart';

class AdminDashboardController extends BaseController {
  final FirestoreService _firestoreService = FirestoreService();
  final AuthService _authService = AuthService();

  final todayVisitors = 0.obs;
  final yesterdayVisitors = 0.obs;
  final propertiesCount = 0.obs;
  final publishedPropertiesCount = 0.obs;
  final teamCount = 0.obs;
  final newInquiriesCount = 0.obs;
  final adminName = 'Admin'.obs;

  @override
  void onInit() {
    super.onInit();
    loadAdminName();
    loadDashboardData();
  }

  Future<void> loadAdminName() async {
    try {
      final adminUser = await _authService.getAdminUserData();
      if (adminUser != null) {
        adminName.value = adminUser.name.isNotEmpty
            ? adminUser.name
            : (adminUser.email.split('@').first);
      } else {
        final user = _authService.currentUser;
        if (user != null) {
          adminName.value = user.email?.split('@').first ?? 'Admin';
        }
      }
    } catch (e) {
      // Fallback to email if name loading fails
      final user = _authService.currentUser;
      if (user != null) {
        adminName.value = user.email?.split('@').first ?? 'Admin';
      }
    }
  }

  Future<void> loadDashboardData() async {
    await Future.wait([
      loadVisitorStats(),
      loadPropertiesCount(),
      loadTeamCount(),
      loadInquiriesCount(),
    ]);
  }

  Future<void> loadVisitorStats() async {
    try {
      todayVisitors.value = await _firestoreService.getTodayVisitors();
      final yesterday = DateTime.now().subtract(const Duration(days: 1));
      final yesterdayKey =
          '${yesterday.year}-${yesterday.month.toString().padLeft(2, '0')}-${yesterday.day.toString().padLeft(2, '0')}';
      final stats = await _firestoreService.getDailyVisitors(2);
      yesterdayVisitors.value = stats[yesterdayKey] ?? 0;
    } catch (e) {
      showError('Failed to load visitor stats');
    }
  }

  Future<void> loadPropertiesCount() async {
    try {
      final properties = await _firestoreService.getAllProperties().first;
      propertiesCount.value = properties.length;
      publishedPropertiesCount.value = properties
          .where((p) => p.isPublished)
          .length;
    } catch (e) {
      showError('Failed to load properties count');
    }
  }

  Future<void> loadTeamCount() async {
    try {
      final team = await _firestoreService.getAllTeam().first;
      teamCount.value = team.length;
    } catch (e) {
      // showError('Failed to load team count');
    }
  }

  Future<void> loadInquiriesCount() async {
    try {
      final inquiries = await _firestoreService
          .getAllContactSubmissions()
          .first;
      newInquiriesCount.value = inquiries
          .where((i) => i.status == 'new')
          .length;
    } catch (e) {
      showError('Failed to load inquiries count');
    }
  }

  Future<void> logout() async {
    await _authService.signOut();
    Get.offAllNamed(AdminConstants.routeAdminLogin);
  }
}
