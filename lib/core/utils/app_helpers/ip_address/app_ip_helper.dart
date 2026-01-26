import 'package:http/http.dart' as http;
import 'app_ip_helper_stub.dart'
    if (dart.library.html) 'app_ip_helper_web.dart';

/// Helper utility for getting client IP address and browser information
///
/// For web applications, IP address is obtained via third-party API (ipify.org).
/// User agent and referrer are obtained directly from the browser.
class AppIPHelper {
  AppIPHelper._();

  // Cache IP address for the session to avoid multiple API calls
  static String? _cachedIpAddress;
  static bool _isFetchingIp = false;

  /// Get client IP address
  ///
  /// Uses ipify.org API to get the client's public IP address.
  /// The result is cached for the session to avoid multiple API calls.
  /// Returns null if the API call fails or times out.
  static Future<String?> getClientIp() async {
    // Return cached IP if available
    if (_cachedIpAddress != null) {
      return _cachedIpAddress;
    }

    // Prevent multiple simultaneous requests
    if (_isFetchingIp) {
      // Wait a bit and return cached value if available
      await Future.delayed(const Duration(milliseconds: 500));
      return _cachedIpAddress;
    }

    _isFetchingIp = true;

    try {
      // Use ipify.org API - free, simple, and reliable
      // Timeout after 5 seconds to avoid blocking
      final response = await http
          .get(Uri.parse('https://api.ipify.org?format=text'))
          .timeout(
            const Duration(seconds: 5),
            onTimeout: () {
              throw Exception('IP detection timeout');
            },
          );

      if (response.statusCode == 200) {
        final ipAddress = response.body.trim();
        // Validate IP address format (basic check)
        if (_isValidIpAddress(ipAddress)) {
          _cachedIpAddress = ipAddress;
          return ipAddress;
        }
      }
    } catch (e) {
      // Silently fail - IP detection is not critical
    } finally {
      _isFetchingIp = false;
    }

    return null;
  }

  /// Validate IP address format (basic validation)
  static bool _isValidIpAddress(String ip) {
    // Basic IPv4 validation
    final ipv4Regex = RegExp(r'^(\d{1,3}\.){3}\d{1,3}$');

    // Basic IPv6 validation (simplified)
    final ipv6Regex = RegExp(r'^([0-9a-fA-F]{0,4}:){2,7}[0-9a-fA-F]{0,4}$');

    if (ipv4Regex.hasMatch(ip)) {
      // Validate each octet is 0-255
      final parts = ip.split('.');
      for (final part in parts) {
        final num = int.tryParse(part);
        if (num == null || num < 0 || num > 255) {
          return false;
        }
      }
      return true;
    }

    return ipv6Regex.hasMatch(ip);
  }

  /// Get user agent string
  ///
  /// Returns the user agent string from the browser's navigator object.
  /// Returns null if not available (e.g., not running on web).
  static String? getUserAgent() {
    return AppIPHelperWeb.getUserAgent();
  }

  /// Get referrer URL
  ///
  /// Returns the referrer URL from the browser's document object.
  /// Returns null if not available or if the page was accessed directly.
  static String? getReferrer() {
    return AppIPHelperWeb.getReferrer();
  }

  /// Clear cached IP address
  ///
  /// Useful for testing or when you need to force a fresh IP lookup.
  static void clearCache() {
    _cachedIpAddress = null;
    _isFetchingIp = false;
  }
}
