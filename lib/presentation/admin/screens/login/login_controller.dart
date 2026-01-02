import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:elegant_advisors/data/services/auth_service.dart';
import 'package:elegant_advisors/core/base/base_controller/app_base_controller.dart';

class LoginController extends BaseController {
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
    if (formKey.currentState?.validate() ?? false) {
      setLoading(true);
      try {
        await _authService.signInWithEmailAndPassword(
          emailController.text.trim(),
          passwordController.text,
        );

        // Check if user is admin
        final isAdmin = await _authService.isAdmin();
        if (!isAdmin) {
          await _authService.signOut();
          showError('Access denied. Admin privileges required.');
          return;
        }

        Get.offAllNamed('/dashboard');
      } catch (e) {
        showError('Login failed: ${e.toString()}');
      } finally {
        setLoading(false);
      }
    }
  }
}
