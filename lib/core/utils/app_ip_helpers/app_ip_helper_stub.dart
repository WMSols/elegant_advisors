// Stub file for non-web platforms
// This file is used when dart:html is not available

/// Stub implementation for non-web platforms
class AppIPHelperWeb {
  AppIPHelperWeb._();

  /// Get user agent string - returns null on non-web platforms
  static String? getUserAgent() {
    return null;
  }

  /// Get referrer URL - returns null on non-web platforms
  static String? getReferrer() {
    return null;
  }
}
