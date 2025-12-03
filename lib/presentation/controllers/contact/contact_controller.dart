import 'package:flutter/material.dart';
import '../../../core/utils/app_texts/app_texts.dart';
import '../base_controller.dart';

class ContactController extends BaseController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final messageController = TextEditingController();
  
  final formKey = GlobalKey<FormState>();

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    messageController.dispose();
    super.onClose();
  }

  void submitForm() {
    if (formKey.currentState?.validate() ?? false) {
      // Use base controller's loading state
      executeAsync(() async {
        // TODO: Handle form submission when backend is ready
        await Future.delayed(const Duration(seconds: 2));
        showSuccess(AppTexts.contactSuccessMessage);
        return true;
      });
    }
  }
}

