import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:elegant_advisors/data/services/firestore_service.dart';
import 'package:elegant_advisors/data/services/auth_service.dart';
import 'package:elegant_advisors/domain/models/admin_user_model.dart';
import 'package:elegant_advisors/core/base/base_controller/app_base_controller.dart';
import 'package:elegant_advisors/core/utils/app_validators/app_validators.dart';
import 'package:elegant_advisors/core/constants/admin_constants.dart';
import 'package:elegant_advisors/core/widgets/feedback/app_snackbar.dart';

class AdminCreateEditAdminController extends BaseController {
  final FirestoreService _firestoreService = FirestoreService();
  final AuthService _authService = AuthService();

  final isEditMode = false.obs;
  final admin = Rxn<AdminUserModel>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  String? get adminId => Get.parameters['id'];

  @override
  void onInit() {
    super.onInit();
    if (adminId != null) {
      isEditMode.value = true;
      loadAdmin();
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  Future<void> loadAdmin() async {
    if (adminId == null) return;

    setLoading(true);
    clearError();

    try {
      final loadedAdmin = await _firestoreService.getAdminUser(adminId!);
      if (loadedAdmin != null) {
        admin.value = loadedAdmin;
        nameController.text = loadedAdmin.name;
        emailController.text = loadedAdmin.email;
        // Set obscured placeholder for password in edit mode
        passwordController.text = '••••••••';
      } else {
        AppSnackbar.showError('Admin user not found');
        Get.back();
      }
    } catch (e) {
      AppSnackbar.showError('Failed to load admin user');
      Get.back();
    } finally {
      setLoading(false);
    }
  }

  Future<void> saveAdmin() async {
    // Validate form fields
    if (!(formKey.currentState?.validate() ?? false)) {
      return;
    }

    setLoading(true);
    clearError();

    try {
      if (isEditMode.value && adminId != null) {
        // Update existing admin
        await _updateAdmin();
      } else {
        // Create new admin
        await _createAdmin();
      }
    } on Exception catch (e) {
      final errorMessage = e.toString().replaceFirst('Exception: ', '');
      AppSnackbar.showError(errorMessage);
    } catch (e) {
      AppSnackbar.showError('Failed to save admin');
    } finally {
      setLoading(false);
    }
  }

  Future<void> _createAdmin() async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text;

    // Create admin via Cloud Function
    await _authService.createAdminUserViaFunction(
      email: email,
      password: password,
      name: name,
    );

    AppSnackbar.showSuccess('Admin created successfully');
    
    // Clear loading state before navigation
    setLoading(false);
    
    // Small delay to ensure UI is ready before navigation
    await Future.delayed(const Duration(milliseconds: 100));
    
    // Navigate back to manage admins screen
    // Use offNamedUntil to preserve the manage admins controller and its stream
    // This ensures real-time updates continue to work
    Get.offNamedUntil(
      AdminConstants.routeAdminManageAdmins,
      (route) => route.settings.name == AdminConstants.routeAdminManageAdmins ||
          route.settings.name == AdminConstants.routeAdminDashboard ||
          route.settings.name == AdminConstants.routeAdminLogin ||
          route.settings.name == null,
    );
  }

  Future<void> _updateAdmin() async {
    if (adminId == null || admin.value == null) return;

    final name = nameController.text.trim();

    // In edit mode, only name can be updated
    // Email and password are disabled and cannot be changed
    if (name == admin.value!.name) {
      // No changes made
      AppSnackbar.showInfo('No changes to save');
      return;
    }

    // Update admin name directly in Firestore (no need for Cloud Function)
    // Since we're only updating the name field, we can use Firestore directly
    final updatedAdmin = AdminUserModel(
      id: adminId,
      name: name,
      email: admin.value!.email, // Keep existing email
      createdAt: admin.value!.createdAt, // Keep existing createdAt
    );

    await _firestoreService.updateAdminUser(adminId!, updatedAdmin);

    AppSnackbar.showSuccess('Admin updated successfully');
    
    // Clear loading state before navigation
    setLoading(false);
    
    // Small delay to ensure UI is ready before navigation
    await Future.delayed(const Duration(milliseconds: 100));
    
    // Navigate back to manage admins screen
    // Use offNamedUntil to preserve the manage admins controller and its stream
    // This ensures real-time updates continue to work
    Get.offNamedUntil(
      AdminConstants.routeAdminManageAdmins,
      (route) => route.settings.name == AdminConstants.routeAdminManageAdmins ||
          route.settings.name == AdminConstants.routeAdminDashboard ||
          route.settings.name == AdminConstants.routeAdminLogin ||
          route.settings.name == null,
    );
  }

  // Validators
  String? validateName(String? value) {
    return AppValidators.validateName(value);
  }

  String? validateEmail(String? value) {
    return AppValidators.validateEmail(value);
  }

  String? validatePassword(String? value) {
    if (isEditMode.value) {
      // In edit mode, password is optional
      if (value == null || value.isEmpty) {
        return null; // No error if empty
      }
      // If provided, validate it
      return AppValidators.validateAdminPassword(value);
    } else {
      // In create mode, password is required
      return AppValidators.validateAdminPassword(value);
    }
  }
}
