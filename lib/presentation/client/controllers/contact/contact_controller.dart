import 'package:flutter/material.dart';
import '../../../../data/services/firestore_service.dart';
import '../../../../data/services/analytics_service.dart';
import '../../../../domain/models/contact_submission_model.dart';
import '../../../../core/utils/app_texts/app_texts.dart';
import '../../../base_controller.dart';

class ContactController extends BaseController {
  final FirestoreService _firestoreService = FirestoreService();
  final AnalyticsService _analyticsService = AnalyticsService();
  
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final messageController = TextEditingController();
  final subjectController = TextEditingController();
  
  final formKey = GlobalKey<FormState>();
  String? propertyId; // Optional: if inquiry is about a specific property

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    messageController.dispose();
    subjectController.dispose();
    super.onClose();
  }

  void submitForm() {
    if (formKey.currentState?.validate() ?? false) {
      executeAsync(() async {
        try {
          // Create contact submission
          final submission = ContactSubmissionModel(
            name: nameController.text.trim(),
            email: emailController.text.trim(),
            phone: phoneController.text.trim(),
            subject: subjectController.text.trim().isEmpty 
                ? 'General Inquiry' 
                : subjectController.text.trim(),
            message: messageController.text.trim(),
            propertyId: propertyId,
          );

          await _firestoreService.createContactSubmission(submission);
          
          // Log analytics event
          await _analyticsService.logContactSubmit();
          
          // Clear form
          nameController.clear();
          emailController.clear();
          phoneController.clear();
          messageController.clear();
          subjectController.clear();
          propertyId = null;
          
          showSuccess(AppTexts.contactSuccessMessage);
          return true;
        } catch (e) {
          showError('Failed to submit. Please try again.');
          return false;
        }
      });
    }
  }
}
