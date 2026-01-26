import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

/// Service for translating text from English to Portuguese
/// Uses free translation APIs (LibreTranslate or MyMemory)
/// Includes caching and error handling
class TranslationService {
  TranslationService._();

  // LibreTranslate public API endpoint (free, no API key required)
  static const String _libreTranslateUrl =
      'https://libretranslate.com/translate';

  // MyMemory Translation API (free tier: 10,000 words/day)
  static const String _myMemoryUrl = 'https://api.mymemory.translated.net/get';

  // Cache keys
  static const String _cachePrefix = 'translation_cache_';
  static const int _maxCacheSize = 1000; // Maximum cached translations

  // In-memory cache for faster access
  static final Map<String, String> _memoryCache = {};

  /// Translation result with error information
  static Future<TranslationResult> translateToPortuguese(
    String englishText,
  ) async {
    if (englishText.trim().isEmpty) {
      return TranslationResult(
        originalText: englishText,
        translatedText: englishText,
        success: true,
        fromCache: false,
      );
    }

    // Check memory cache first
    final cacheKey = _getCacheKey(englishText);
    if (_memoryCache.containsKey(cacheKey)) {
      return TranslationResult(
        originalText: englishText,
        translatedText: _memoryCache[cacheKey]!,
        success: true,
        fromCache: true,
      );
    }

    // Check persistent cache
    final cachedTranslation = await _getCachedTranslation(englishText);
    if (cachedTranslation != null) {
      // Store in memory cache for faster future access
      _memoryCache[cacheKey] = cachedTranslation;
      return TranslationResult(
        originalText: englishText,
        translatedText: cachedTranslation,
        success: true,
        fromCache: true,
      );
    }

    // Try LibreTranslate first (free, no API key) with retry
    String? translated;
    String? errorMessage;

    for (int attempt = 0; attempt < 2; attempt++) {
      try {
        translated = await _translateWithLibreTranslate(englishText);
        if (translated.isNotEmpty && translated != englishText) {
          // Cache the successful translation
          await _cacheTranslation(englishText, translated);
          _memoryCache[cacheKey] = translated;
          return TranslationResult(
            originalText: englishText,
            translatedText: translated,
            success: true,
            fromCache: false,
            apiUsed: 'LibreTranslate',
          );
        }
      } catch (e) {
        errorMessage = 'LibreTranslate: ${e.toString()}';
        // Wait before retry (exponential backoff)
        if (attempt < 1) {
          await Future.delayed(Duration(milliseconds: 500 * (attempt + 1)));
        }
      }
    }

    // Fallback to MyMemory Translation API with retry
    for (int attempt = 0; attempt < 2; attempt++) {
      try {
        translated = await _translateWithMyMemory(englishText);
        if (translated.isNotEmpty && translated != englishText) {
          // Cache the successful translation
          await _cacheTranslation(englishText, translated);
          _memoryCache[cacheKey] = translated;
          return TranslationResult(
            originalText: englishText,
            translatedText: translated,
            success: true,
            fromCache: false,
            apiUsed: 'MyMemory',
          );
        }
      } catch (e) {
        errorMessage = errorMessage != null
            ? '$errorMessage | MyMemory: ${e.toString()}'
            : 'MyMemory: ${e.toString()}';
        // Wait before retry (exponential backoff)
        if (attempt < 1) {
          await Future.delayed(Duration(milliseconds: 500 * (attempt + 1)));
        }
      }
    }

    // If both APIs fail, return original text with error info
    return TranslationResult(
      originalText: englishText,
      translatedText: englishText, // Fallback to original
      success: false,
      fromCache: false,
      errorMessage: errorMessage ?? 'Translation failed: Both APIs unavailable',
    );
  }

  /// Get cache key for a text
  static String _getCacheKey(String text) {
    return '$_cachePrefix${text.hashCode}';
  }

  /// Get cached translation from SharedPreferences
  static Future<String?> _getCachedTranslation(String englishText) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cacheKey = _getCacheKey(englishText);
      return prefs.getString(cacheKey);
    } catch (e) {
      return null;
    }
  }

  /// Cache translation to SharedPreferences
  static Future<void> _cacheTranslation(
    String englishText,
    String portugueseText,
  ) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cacheKey = _getCacheKey(englishText);
      await prefs.setString(cacheKey, portugueseText);

      // Manage cache size - remove oldest entries if cache is too large
      await _manageCacheSize(prefs);
    } catch (e) {
      // Silently fail - caching is not critical
    }
  }

  /// Manage cache size to prevent it from growing too large
  static Future<void> _manageCacheSize(SharedPreferences prefs) async {
    try {
      final allKeys = prefs.getKeys();
      final translationKeys = allKeys
          .where((key) => key.startsWith(_cachePrefix))
          .toList();

      if (translationKeys.length > _maxCacheSize) {
        // Remove oldest 20% of cache entries
        final keysToRemove = translationKeys.take(
          (translationKeys.length * 0.2).round(),
        );
        for (final key in keysToRemove) {
          await prefs.remove(key);
          _memoryCache.remove(key);
        }
      }
    } catch (e) {
      // Silently fail
    }
  }

  /// Clear all cached translations
  static Future<void> clearCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final allKeys = prefs.getKeys();
      final translationKeys = allKeys
          .where((key) => key.startsWith(_cachePrefix))
          .toList();

      for (final key in translationKeys) {
        await prefs.remove(key);
      }
      _memoryCache.clear();
    } catch (e) {
      // Silently fail
    }
  }

  /// Translate using LibreTranslate (free, open-source)
  static Future<String> _translateWithLibreTranslate(String text) async {
    try {
      final response = await http
          .post(
            Uri.parse(_libreTranslateUrl),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'q': text,
              'source': 'en',
              'target': 'pt',
              'format': 'text',
            }),
          )
          .timeout(
            const Duration(seconds: 15),
            onTimeout: () {
              throw Exception('LibreTranslate request timeout');
            },
          );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['translatedText'] != null) {
          final translated = data['translatedText'].toString().trim();
          if (translated.isNotEmpty) {
            return translated;
          }
        }
        throw Exception('LibreTranslate: Invalid response format');
      } else if (response.statusCode == 429) {
        throw Exception(
          'LibreTranslate: Rate limit exceeded. Please try again later.',
        );
      } else if (response.statusCode >= 500) {
        throw Exception(
          'LibreTranslate: Server error (${response.statusCode})',
        );
      } else {
        throw Exception(
          'LibreTranslate: Request failed (${response.statusCode})',
        );
      }
    } on http.ClientException {
      throw Exception(
        'LibreTranslate: Network error. Check your internet connection.',
      );
    } on FormatException {
      throw Exception('LibreTranslate: Invalid response format');
    } catch (e) {
      if (e is Exception) {
        rethrow;
      }
      throw Exception('LibreTranslate: ${e.toString()}');
    }
  }

  /// Translate using MyMemory Translation API (free tier)
  static Future<String> _translateWithMyMemory(String text) async {
    try {
      // MyMemory has a 500 character limit per request
      if (text.length > 500) {
        throw Exception('MyMemory: Text too long (max 500 characters)');
      }

      final uri = Uri.parse(
        _myMemoryUrl,
      ).replace(queryParameters: {'q': text, 'langpair': 'en|pt'});

      final response = await http
          .get(uri)
          .timeout(
            const Duration(seconds: 15),
            onTimeout: () {
              throw Exception('MyMemory request timeout');
            },
          );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['responseData'] != null &&
            data['responseData']['translatedText'] != null) {
          final translated = data['responseData']['translatedText']
              .toString()
              .trim();
          if (translated.isNotEmpty) {
            return translated;
          }
        }
        throw Exception('MyMemory: Invalid response format');
      } else if (response.statusCode == 429) {
        throw Exception(
          'MyMemory: Rate limit exceeded. Daily limit may be reached.',
        );
      } else if (response.statusCode >= 500) {
        throw Exception('MyMemory: Server error (${response.statusCode})');
      } else {
        throw Exception('MyMemory: Request failed (${response.statusCode})');
      }
    } on http.ClientException {
      throw Exception(
        'MyMemory: Network error. Check your internet connection.',
      );
    } on FormatException {
      throw Exception('MyMemory: Invalid response format');
    } catch (e) {
      if (e is Exception) {
        rethrow;
      }
      throw Exception('MyMemory: ${e.toString()}');
    }
  }

  /// Translate a list of strings from English to Portuguese
  /// Returns list of TranslationResult for better error handling
  static Future<List<TranslationResult>> translateListToPortuguese(
    List<String> englishList,
  ) async {
    if (englishList.isEmpty) {
      return [];
    }

    final results = <TranslationResult>[];
    for (final item in englishList) {
      final result = await translateToPortuguese(item);
      results.add(result);

      // Small delay to avoid rate limiting (only if not from cache)
      if (!result.fromCache) {
        await Future.delayed(const Duration(milliseconds: 300));
      }
    }

    return results;
  }

  /// Legacy method for backward compatibility
  /// Returns just the translated string (uses original text if translation fails)
  static Future<String> translateToPortugueseLegacy(String englishText) async {
    final result = await translateToPortuguese(englishText);
    return result.translatedText;
  }
}

/// Result of a translation operation
class TranslationResult {
  final String originalText;
  final String translatedText;
  final bool success;
  final bool fromCache;
  final String? apiUsed;
  final String? errorMessage;

  TranslationResult({
    required this.originalText,
    required this.translatedText,
    required this.success,
    required this.fromCache,
    this.apiUsed,
    this.errorMessage,
  });

  /// Check if translation actually changed the text
  bool get hasTranslation => translatedText != originalText;
}
