import 'package:elegant_advisors/core/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Extension to easily access AppLocalizations from BuildContext
extension AppLocalizationsExtension on BuildContext {
  /// Get AppLocalizations instance
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}

/// Helper class for accessing translations without BuildContext
/// Use this in controllers or services where BuildContext is not available
class AppLocalizationsHelper {
  AppLocalizationsHelper._();

  /// Get translations from GetX context
  /// Note: This requires GetMaterialApp to be initialized
  static AppLocalizations? getLocalizations() {
    try {
      final context = Get.context;
      if (context != null) {
        return AppLocalizations.of(context);
      }
    } catch (e) {
      // Context not available
    }
    return null;
  }
}
