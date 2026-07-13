export 'package:elegant_advisors/core/l10n/app_localizations.dart';

import 'package:elegant_advisors/core/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Extension to easily access [AppLocalizations] from [BuildContext].
///
/// Import this file (not [AppLocalizations] alone) wherever you use `context.l10n`.
extension AppLocalizationsExtension on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}

/// Helper for accessing translations without [BuildContext].
/// Use in controllers or services where [BuildContext] is not available.
class AppLocalizationsHelper {
  AppLocalizationsHelper._();

  static AppLocalizations? getLocalizations() {
    try {
      final context = Get.context;
      if (context != null) {
        return AppLocalizations.of(context);
      }
    } catch (_) {
      // Context not available.
    }
    return null;
  }
}
