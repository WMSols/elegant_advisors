import 'dart:html' as html;

/// Web-specific implementation for AppIPHelper
class AppIPHelperWeb {
  AppIPHelperWeb._();

  /// Get user agent string
  ///
  /// Returns the user agent string from the browser's navigator object.
  /// Returns null if not available.
  static String? getUserAgent() {
    try {
      return html.window.navigator.userAgent;
    } catch (e) {
      return null;
    }
  }

  /// Get referrer URL
  ///
  /// Returns the referrer URL from the browser's document object.
  /// Returns null if not available or if the page was accessed directly.
  static String? getReferrer() {
    try {
      final referrer = html.document.referrer;
      return referrer.isEmpty ? null : referrer;
    } catch (e) {
      return null;
    }
  }
}
