import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Controller for managing application language/locale
class LanguageController extends GetxController {
  static const String _localeKey = 'app_locale';

  // Supported locales
  static const Locale english = Locale('en');
  static const Locale portuguese = Locale('pt');
  static const List<Locale> supportedLocales = [english, portuguese];

  // Current locale
  final _currentLocale = english.obs;
  Locale get currentLocale => _currentLocale.value;

  // Flag image paths for language selector
  String get currentFlagImage {
    switch (_currentLocale.value.languageCode) {
      case 'pt':
        return 'assets/images/home/portugal_flag.png';
      case 'en':
      default:
        return 'assets/images/home/england_flag.png';
    }
  }

  @override
  void onInit() {
    super.onInit();
    _loadSavedLocale();
  }

  /// Load saved locale from SharedPreferences
  Future<void> _loadSavedLocale() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedLocaleCode = prefs.getString(_localeKey);

      if (savedLocaleCode != null) {
        final locale = Locale(savedLocaleCode);
        if (supportedLocales.contains(locale)) {
          _currentLocale.value = locale;
          Get.updateLocale(locale);
        }
      }
    } catch (e) {
      // If loading fails, use default locale (English)
      _currentLocale.value = english;
    }
  }

  /// Change language and persist preference
  Future<void> changeLanguage(Locale locale) async {
    if (!supportedLocales.contains(locale)) {
      return;
    }

    try {
      // Update GetX locale
      Get.updateLocale(locale);

      // Update current locale
      _currentLocale.value = locale;

      // Persist to SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_localeKey, locale.languageCode);
    } catch (e) {
      // Handle error silently or show error message
    }
  }

  /// Change language by flag image path (for compatibility with existing code)
  Future<void> changeLanguageByFlag(String flagImagePath) async {
    Locale? locale;

    if (flagImagePath.contains('portugal_flag')) {
      locale = portuguese;
    } else if (flagImagePath.contains('england_flag')) {
      locale = english;
    }

    if (locale != null) {
      await changeLanguage(locale);
    }
  }

  /// Check if a locale is currently selected
  bool isLocaleSelected(Locale locale) {
    return _currentLocale.value.languageCode == locale.languageCode;
  }

  /// Get flag image path for a locale
  static String getFlagImageForLocale(Locale locale) {
    switch (locale.languageCode) {
      case 'pt':
        return 'assets/images/home/portugal_flag.png';
      case 'en':
      default:
        return 'assets/images/home/england_flag.png';
    }
  }
}
