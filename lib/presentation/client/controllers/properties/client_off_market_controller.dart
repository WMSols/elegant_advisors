import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:elegant_advisors/data/services/firestore_service.dart';
import 'package:elegant_advisors/data/services/analytics_service.dart';
import 'package:elegant_advisors/data/services/email_service.dart';
import 'package:elegant_advisors/domain/models/contact_submission_model.dart';
import 'package:elegant_advisors/core/utils/app_helpers/language/app_localizations_helper.dart';
import 'package:elegant_advisors/core/utils/app_spam_protection/app_spam_protection.dart';
import 'package:elegant_advisors/core/utils/app_helpers/ip_address/app_ip_helper.dart';
import 'package:elegant_advisors/core/base/base_controller/app_base_controller.dart';

class ClientOffMarketController extends BaseController {
  final FirestoreService _firestoreService = FirestoreService();
  final AnalyticsService _analyticsService = AnalyticsService();
  final EmailService _emailService = EmailService();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final messageController = TextEditingController();
  final honeypotController = TextEditingController();

  final scrollController = ScrollController();
  final showHeader = false.obs;
  int _keyCounter = 0;
  GlobalKey<FormState>? _formKey;
  GlobalKey? _formSectionKey;

  Key get scrollViewKey => ValueKey('off_market_scroll_$_keyCounter');

  GlobalKey<FormState> get formKey {
    _formKey ??= GlobalKey<FormState>();
    return _formKey!;
  }

  GlobalKey get formSectionKey {
    _formSectionKey ??= GlobalKey(debugLabel: 'off_market_form_section');
    return _formSectionKey!;
  }

  @override
  void onInit() {
    super.onInit();
    _formKey = null;
    _formSectionKey = null;
    _keyCounter++;
    scrollController.addListener(_onScroll);
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    messageController.dispose();
    honeypotController.dispose();
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    _formKey = null;
    _formSectionKey = null;
    super.onClose();
  }

  void _onScroll() {
    final show = scrollController.hasClients && scrollController.offset > 100;
    if (showHeader.value != show) {
      showHeader.value = show;
    }
  }

  void scrollToForm() {
    final context = formSectionKey.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  void submitForm() async {
    if (formKey.currentState?.validate() ?? false) {
      if (AppSpamProtection.isHoneypotFilled(honeypotController.text)) {
        return;
      }

      final l10n = AppLocalizationsHelper.getLocalizations();
      if (AppSpamProtection.isSuspiciousEmail(emailController.text.trim())) {
        showError(
          l10n?.contactFormEmailInvalid ??
              'Please provide a valid email address.',
        );
        return;
      }

      if (AppSpamProtection.containsSpamKeywords(
        messageController.text.trim(),
      )) {
        showError(
          l10n?.contactFormSpamDetected ??
              'Your message contains inappropriate content.',
        );
        return;
      }

      executeAsync(() async {
        try {
          final ipAddress = await AppIPHelper.getClientIp();
          final subject =
              l10n?.offMarketFormSubject ?? 'Request for Off Market Projects';

          final submission = ContactSubmissionModel(
            name: nameController.text.trim(),
            email: emailController.text.trim().toLowerCase(),
            phone: phoneController.text.trim(),
            subject: subject,
            message: messageController.text.trim(),
            propertyId: null,
            ipAddress: ipAddress,
          );

          await _firestoreService.createContactSubmission(submission);

          try {
            await _emailService.sendInquiryNotification(submission, null);
            await _emailService.sendInquiryConfirmation(submission);
          } catch (e) {
            // Log but don't fail
          }

          await _analyticsService.logContactSubmit();

          nameController.clear();
          emailController.clear();
          phoneController.clear();
          messageController.clear();
          honeypotController.clear();

          showSuccess(
            l10n?.offMarketFormSuccess ??
                "Your request has been sent. We'll contact you at the email you provided.",
          );

          return true;
        } catch (e) {
          final l10n = AppLocalizationsHelper.getLocalizations();
          showError(
            l10n?.offMarketFormErrorSubmit ??
                'Failed to submit. Please try again.',
          );
          return false;
        }
      });
    }
  }
}
