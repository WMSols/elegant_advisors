import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:elegant_advisors/data/services/firestore_service.dart';
import 'package:elegant_advisors/data/services/analytics_service.dart';
import 'package:elegant_advisors/data/services/email_service.dart';
import 'package:elegant_advisors/domain/models/contact_submission_model.dart';
import 'package:elegant_advisors/domain/models/property_model.dart';
import 'package:elegant_advisors/core/utils/app_texts/app_texts.dart';
import 'package:elegant_advisors/core/utils/app_spam_protection/app_spam_protection.dart';
import 'package:elegant_advisors/core/utils/app_ip_helpers/app_ip_helper.dart';
import 'package:elegant_advisors/core/base/base_controller/app_base_controller.dart';
import 'package:elegant_advisors/core/constants/client_constants.dart';

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

  String? propertyId; // Optional: if inquiry is about a specific property
  final scrollController = ScrollController();
  final showHeader = false.obs;
  int _keyCounter = 0;
  GlobalKey<FormState>? _formKey;

  // Recreate formKey on each onInit to avoid duplicate GlobalKey issues
  // This ensures a fresh key when navigating to this screen
  GlobalKey<FormState> get formKey {
    _formKey ??= GlobalKey<FormState>();
    return _formKey!;
  }

  // Use ValueKey instead of GlobalKey to avoid duplicate key issues
  // ValueKey with a counter ensures unique keys without GlobalKey conflicts
  Key get scrollViewKey => ValueKey('contact_scroll_$_keyCounter');

  @override
  void onInit() {
    super.onInit();
    // Reset formKey to ensure fresh key for each navigation
    // This prevents duplicate GlobalKey errors when navigating between screens
    _formKey = null;
    // Increment key counter to ensure unique key for each navigation
    _keyCounter++;
    scrollController.addListener(_onScroll);
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
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    // Clear formKey to ensure clean state
    _formKey = null;
    super.onClose();
  }

  void _onScroll() {
    final show = scrollController.hasClients && scrollController.offset > 100;
    if (showHeader.value != show) {
      showHeader.value = show;
    }
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

          // Get property if propertyId is set (needed for subject generation)
          PropertyModel? property;
          if (propertyId != null) {
            property = await _firestoreService.getPropertyById(propertyId!);
          }

          // Generate subject based on context
          String subject;
          if (subjectController.text.trim().isNotEmpty) {
            // User provided a subject
            subject = subjectController.text.trim();
          } else if (property != null && property.title.isNotEmpty) {
            // Property inquiry - use property title
            subject = 'Inquiry about ${property.title}';
          } else {
            // General inquiry
            subject = 'General Inquiry';
          }

          // Create contact submission
          final submission = ContactSubmissionModel(
            name: nameController.text.trim(),
            email: emailController.text
                .trim()
                .toLowerCase(), // Store in lowercase for consistent queries
            phone: phoneController.text.trim(),
            subject: subject,
            message: messageController.text.trim(),
            propertyId: propertyId,
            ipAddress: ipAddress,
          );

          await _firestoreService.createContactSubmission(submission);

          // Send email notifications
          try {
            // Send notification to admin
            await _emailService.sendInquiryNotification(submission, property);

            // Send confirmation to user (optional - uncomment to enable)
            await _emailService.sendInquiryConfirmation(submission);
          } catch (e) {
            // Log but don't fail the submission
            // Email notification failure is logged but doesn't break the flow
          }

          // Log analytics event
          await _analyticsService.logContactSubmit();

          // Store email before clearing (use lowercase to match database)
          final submittedEmail = emailController.text.trim().toLowerCase();

          // Clear form
          nameController.clear();
          emailController.clear();
          phoneController.clear();
          messageController.clear();
          subjectController.clear();
          honeypotController.clear();
          propertyId = null;

          showSuccess(AppTexts.contactSuccessMessage);

          // Navigate to my contacts page with email after a delay
          // Use longer delay and add retry mechanism for Firestore eventual consistency
          // Delete contact controller to ensure clean state and prevent GlobalKey conflicts
          Future.delayed(const Duration(milliseconds: 2000), () {
            // Delete contact controller to ensure clean state
            if (Get.isRegistered<ClientContactController>()) {
              Get.delete<ClientContactController>(force: true);
            }
            // Use offNamed to replace current route and ensure fresh controller instance
            Get.offNamed(
              ClientConstants.routeClientContacts,
              arguments: submittedEmail,
            );
          });

          return true;
        } catch (e) {
          showError('Failed to submit. Please try again.');
          return false;
        }
      });
    }
  }
}
