import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:elegant_advisors/data/services/auth_service.dart';
import 'package:elegant_advisors/core/base/base_controller/app_base_controller.dart';
import 'package:elegant_advisors/core/constants/admin_constants.dart';

class AdminLoginController extends BaseController {
  final AuthService _authService = AuthService();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  Future<void> login() async {
    // Validate form fields with strict validations
    if (!(formKey.currentState?.validate() ?? false)) {
      return;
    }

    setLoading(true);
    clearError();

    try {
      // Sign in with Firebase Authentication
      await _authService.signInWithEmailAndPassword(
        emailController.text.trim(),
        passwordController.text,
      );

      // Verify user has admin privileges in Firestore
      final isAdmin = await _authService.isAdmin();
      if (!isAdmin) {
        // User authenticated but not an admin - sign them out
        await _authService.signOut();
        showError(
          'Access denied. This account does not have admin privileges. '
          'Please contact your administrator.',
        );
        return;
      }

      // Successfully authenticated as admin - navigate to dashboard
      showSuccess('Login successful!');
      Get.offAllNamed(AdminConstants.routeAdminDashboard);
    } on Exception catch (e) {
      // Handle formatted error messages from AuthService
      final errorMessage = e.toString().replaceFirst('Exception: ', '');
      showError(errorMessage);
    } catch (e) {
      // Handle unexpected errors
      showError('An unexpected error occurred. Please try again.');
    } finally {
      setLoading(false);
    }
  }
}
