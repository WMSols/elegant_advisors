import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:elegant_advisors/data/services/firestore_service.dart';
import 'package:elegant_advisors/domain/models/contact_submission_model.dart';
import 'package:elegant_advisors/core/base/base_controller/app_base_controller.dart';
import 'package:elegant_advisors/core/utils/app_validators/app_validators.dart';
import 'package:elegant_advisors/core/utils/app_helpers/language/app_localizations_helper.dart';

class ClientMyContactsController extends BaseController {
  final FirestoreService _firestoreService = FirestoreService();

  final contacts = <ContactSubmissionModel>[].obs;
  final emailController = TextEditingController();
  final selectedStatus = 'all'.obs;
  final userEmail = Rxn<String>();
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
  Key get scrollViewKey => ValueKey('my_contacts_scroll_$_keyCounter');

  @override
  void onInit() {
    super.onInit();
    // Reset formKey to ensure fresh key for each navigation
    // This prevents duplicate GlobalKey errors when navigating between screens
    _formKey = null;
    // Increment key counter to ensure unique key for each navigation
    _keyCounter++;
    scrollController.addListener(_onScroll);
    // Check if email is passed from route arguments
    final args = Get.arguments;
    if (args is String && args.isNotEmpty) {
      // Normalize email to lowercase to match database storage
      final normalizedEmail = args.trim().toLowerCase();
      userEmail.value = normalizedEmail;
      emailController.text = normalizedEmail;
      // Add delay to ensure Firestore write is complete (increased delay for eventual consistency)
      Future.delayed(const Duration(milliseconds: 2000), () {
        loadContacts(normalizedEmail);
      });
    }
  }

  @override
  void onReady() {
    super.onReady();
    // Reload contacts when screen becomes ready (in case of navigation from contact form)
    if (userEmail.value != null) {
      // Add a small delay to ensure Firestore write is visible
      Future.delayed(const Duration(milliseconds: 500), () {
        loadContacts(userEmail.value!);
      });
    }
  }

  @override
  void onClose() {
    emailController.dispose();
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

  void loadContacts(
    String email, {
    int retryCount = 0,
    int maxRetries = 3,
  }) async {
    final l10n = AppLocalizationsHelper.getLocalizations();
    if (email.trim().isEmpty) {
      showError(
        l10n?.myContactsEmailInvalid ?? 'Please enter a valid email address',
      );
      return;
    }

    final emailError = AppValidators.validateEmail(email);
    if (emailError != null) {
      showError(emailError);
      return;
    }

    executeAsync(() async {
      try {
        final normalizedEmail = email.trim().toLowerCase();
        userEmail.value = normalizedEmail;

        final fetchedContacts = await _firestoreService
            .getContactSubmissionsByEmailOnce(normalizedEmail);

        // Apply status filter
        var filtered = fetchedContacts;
        if (selectedStatus.value != 'all') {
          filtered = filtered
              .where((c) => c.status == selectedStatus.value)
              .toList();
        }

        contacts.value = filtered;
        clearError();
      } catch (e) {
        // Retry logic for eventual consistency (if we haven't exceeded max retries)
        if (retryCount < maxRetries) {
          final delayMs =
              (retryCount + 1) * 1000; // Exponential backoff: 1s, 2s, 3s
          await Future.delayed(Duration(milliseconds: delayMs));
          return loadContacts(
            email,
            retryCount: retryCount + 1,
            maxRetries: maxRetries,
          );
        }

        // Check if it's a Firestore index error
        final errorString = e.toString().toLowerCase();
        if (errorString.contains('index') ||
            errorString.contains('requires an index')) {
          showError(
            l10n?.myContactsErrorIndex ??
                'Failed to load contacts. Please ensure Firestore indexes are created. '
                    'Check the Firebase console for index creation links.',
          );
        } else {
          showError(
            l10n?.myContactsErrorLoadingGeneric ??
                'Failed to load contacts. Please try again.',
          );
        }
      }
    });
  }

  void viewContacts() {
    if (formKey.currentState?.validate() ?? false) {
      loadContacts(emailController.text.trim());
    }
  }

  void filterByStatus(String status) {
    selectedStatus.value = status;
    if (userEmail.value != null) {
      loadContacts(userEmail.value!);
    }
  }

  void clearFilters() {
    selectedStatus.value = 'all';
    if (userEmail.value != null) {
      loadContacts(userEmail.value!);
    }
  }

  void refreshContacts() {
    if (userEmail.value != null) {
      loadContacts(userEmail.value!);
    }
  }
}
