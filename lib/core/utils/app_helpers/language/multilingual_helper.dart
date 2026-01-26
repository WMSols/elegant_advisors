import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:elegant_advisors/presentation/admin/controllers/language/language_controller.dart';

/// Helper utility for extracting localized text from multilingual fields
/// Supports both old format (String) and new format (Map with String keys and String values)
class MultilingualHelper {
  MultilingualHelper._();

  /// Get the current locale from LanguageController
  static Locale get currentLocale {
    try {
      final languageController = Get.find<LanguageController>();
      return languageController.currentLocale;
    } catch (e) {
      // Fallback to English if controller not found
      return const Locale('en');
    }
  }

  /// Extract localized text from a field that can be either:
  /// - String (old format, backward compatible)
  /// - Map (new multilingual format: {"en": "English", "pt": "Portuguese"})
  ///
  /// Returns the text in the current locale, or falls back to English, or the original string
  static String getLocalizedText(dynamic field) {
    if (field == null) return '';

    // If it's already a String (old format), return as-is
    if (field is String) {
      return field;
    }

    // If it's a Map (new multilingual format)
    if (field is Map<String, dynamic>) {
      final locale = currentLocale;
      final localeCode = locale.languageCode;

      // Try current locale first
      if (field.containsKey(localeCode) && field[localeCode] != null) {
        return field[localeCode].toString();
      }

      // Fallback to English
      if (field.containsKey('en') && field['en'] != null) {
        return field['en'].toString();
      }

      // Fallback to Portuguese
      if (field.containsKey('pt') && field['pt'] != null) {
        return field['pt'].toString();
      }

      // Fallback to first available value
      if (field.isNotEmpty) {
        return field.values.first.toString();
      }
    }

    return '';
  }

  /// Extract localized text from a list that can be either:
  /// - List (old format)
  /// - Map (new multilingual format: {"en": [...], "pt": [...]})
  static List<String> getLocalizedList(dynamic field) {
    if (field == null) return [];

    // If it's already a List<String> (old format), return as-is
    if (field is List) {
      return field.map((e) => e.toString()).toList();
    }

    // If it's a Map (new multilingual format)
    if (field is Map<String, dynamic>) {
      final locale = currentLocale;
      final localeCode = locale.languageCode;

      // Try current locale first
      if (field.containsKey(localeCode) && field[localeCode] != null) {
        final value = field[localeCode];
        if (value is List) {
          return value.map((e) => e.toString()).toList();
        }
      }

      // Fallback to English
      if (field.containsKey('en') && field['en'] != null) {
        final value = field['en'];
        if (value is List) {
          return value.map((e) => e.toString()).toList();
        }
      }

      // Fallback to Portuguese
      if (field.containsKey('pt') && field['pt'] != null) {
        final value = field['pt'];
        if (value is List) {
          return value.map((e) => e.toString()).toList();
        }
      }

      // Fallback to first available list
      for (final value in field.values) {
        if (value is List) {
          return value.map((e) => e.toString()).toList();
        }
      }
    }

    return [];
  }

  /// Create a multilingual map from a single string (for backward compatibility when saving)
  static Map<String, String> createMultilingualMap(
    String text, {
    String? locale,
  }) {
    final targetLocale = locale ?? currentLocale.languageCode;
    return {targetLocale: text};
  }

  /// Create a multilingual map from a list (for backward compatibility when saving)
  static Map<String, List<String>> createMultilingualListMap(
    List<String> list, {
    String? locale,
  }) {
    final targetLocale = locale ?? currentLocale.languageCode;
    return {targetLocale: list};
  }
}
