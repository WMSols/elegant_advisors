import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:elegant_advisors/data/services/firestore_service.dart';
import 'package:elegant_advisors/data/services/analytics_service.dart';
import 'package:elegant_advisors/data/services/email_service.dart';
import 'package:elegant_advisors/domain/models/contact_submission_model.dart';
import 'package:elegant_advisors/core/utils/app_texts/app_texts.dart';
import 'package:elegant_advisors/core/utils/app_spam_protection/app_spam_protection.dart';
import 'package:elegant_advisors/core/utils/app_ip_helpers/app_ip_helper.dart';
import 'package:elegant_advisors/core/base/base_controller/app_base_controller.dart';

class ClientContactController extends BaseController {
  final FirestoreService _firestoreService = FirestoreService();
  final AnalyticsService _analyticsService = AnalyticsService();
  final EmailService _emailService = EmailService();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final messageController = TextEditingController();
  final subjectController = TextEditingController();
  final honeypotController = TextEditingController(); // Spam protection

  final formKey = GlobalKey<FormState>();
  String? propertyId; // Optional: if inquiry is about a specific property

  @override
  void onInit() {
    super.onInit();
    // Get propertyId from route arguments if provided
    final args = Get.arguments;
    if (args is String) {
      propertyId = args;
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    messageController.dispose();
    subjectController.dispose();
    super.onClose();
  }

  void submitForm() async {
    if (formKey.currentState?.validate() ?? false) {
      // Spam protection check
      if (AppSpamProtection.isHoneypotFilled(honeypotController.text)) {
        // Silently reject - don't show error to bots
        return;
      }

      // Additional spam checks
      if (AppSpamProtection.isSuspiciousEmail(emailController.text.trim())) {
        showError('Please provide a valid email address.');
        return;
      }

      if (AppSpamProtection.containsSpamKeywords(
        messageController.text.trim(),
      )) {
        showError('Your message contains inappropriate content.');
        return;
      }

      executeAsync(() async {
        try {
          // Get IP address
          final ipAddress = await AppIPHelper.getClientIp();

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
            ipAddress: ipAddress,
          );

          await _firestoreService.createContactSubmission(submission);

          // Send email notifications
          try {
            // TODO: Get property if propertyId is set
            await _emailService.sendInquiryNotification(submission, null);
            // Optionally send confirmation to user
            // await _emailService.sendInquiryConfirmation(submission);
          } catch (e) {
            // Log but don't fail the submission
            print('Failed to send email notification: $e');
          }

          // Log analytics event
          await _analyticsService.logContactSubmit();

          // Clear form
          nameController.clear();
          emailController.clear();
          phoneController.clear();
          messageController.clear();
          subjectController.clear();
          honeypotController.clear();
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
