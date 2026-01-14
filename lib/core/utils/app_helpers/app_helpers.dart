import 'package:intl/intl.dart';

/// Helper Functions
/// Utility functions used across the app
class AppHelpers {
  /// Format date to readable string
  static String formatDate(DateTime date) {
    return DateFormat('MMM dd, yyyy').format(date);
  }

  /// Format time to readable string
  static String formatTime(DateTime date) {
    return DateFormat('hh:mm a').format(date);
  }

  /// Format date and time
  static String formatDateTime(DateTime date) {
    return DateFormat('MMM dd, yyyy • hh:mm a').format(date);
  }

  /// Get relative time (e.g., "2 minutes ago")
  static String getRelativeTime(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 365) {
      return '${(difference.inDays / 365).floor()} year${(difference.inDays / 365).floor() > 1 ? 's' : ''} ago';
    } else if (difference.inDays > 30) {
      return '${(difference.inDays / 30).floor()} month${(difference.inDays / 30).floor() > 1 ? 's' : ''} ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
    } else {
      return 'Just now';
    }
  }

  /// Capitalize first letter
  static String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  /// Truncate text with ellipsis
  static String truncate(String text, int maxLength) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength)}...';
  }

  /// Check if email is valid
  static bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  /// Generate a unique ID (simple version)
  static String generateId() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  /// Format currency amount
  static String formatCurrency(double amount, String currency) {
    final formatter = NumberFormat.currency(
      symbol: _getCurrencySymbol(currency),
      decimalDigits: 0,
    );
    return formatter.format(amount);
  }

  /// Get currency symbol
  static String _getCurrencySymbol(String currency) {
    switch (currency.toUpperCase()) {
      case 'EUR':
        return '€';
      case 'GBP':
        return '£';
      case 'USD':
        return '\$';
      default:
        return currency;
    }
  }

  /// Generate slug from title
  static String generateSlug(String title) {
    return title
        .toLowerCase()
        .trim()
        .replaceAll(RegExp(r'[^\w\s-]'), '') // Remove special characters
        .replaceAll(RegExp(r'\s+'), '-') // Replace spaces with hyphens
        .replaceAll(RegExp(r'-+'), '-') // Replace multiple hyphens with single
        .replaceAll(RegExp(r'^-|-$'), ''); // Remove leading/trailing hyphens
  }

  /// Format property price
  static String formatPropertyPrice(
    double? amount,
    String currency,
    bool isOnRequest,
  ) {
    if (isOnRequest) {
      return 'Price on Request'; // Will be replaced with AppTexts in widgets
    }
    if (amount == null) {
      return 'Price not set'; // Will be replaced with AppTexts in widgets
    }
    return formatCurrency(amount, currency);
  }

  /// Format property location (simple - city and country only)
  static String formatPropertyLocationSimple(String city, String country) {
    final parts = <String>[];
    if (city.isNotEmpty) parts.add(city);
    if (country.isNotEmpty) parts.add(country);
    return parts.join(', ');
  }

  /// Format property location (full - includes address and area)
  static String formatPropertyLocationFull(
    String country,
    String city,
    String? area,
    String? address,
  ) {
    final parts = <String>[];
    if (address != null && address.isNotEmpty) {
      parts.add(address);
    }
    if (area != null && area.isNotEmpty) {
      parts.add(area);
    }
    if (city.isNotEmpty) parts.add(city);
    if (country.isNotEmpty) parts.add(country);
    return parts.join(', ');
  }

  /// Format property specs
  static String formatPropertySpecs(
    String propertyType,
    int? bedrooms,
    int? bathrooms,
    double? areaSize,
    String? areaUnit,
  ) {
    final parts = <String>[];
    if (bedrooms != null) parts.add('$bedrooms bed');
    if (bathrooms != null) parts.add('$bathrooms bath');
    if (areaSize != null && areaUnit != null) {
      parts.add('$areaSize $areaUnit');
    }
    return parts.isEmpty ? propertyType : parts.join(' • ');
  }

  /// Format property specs for detail view (includes type label)
  static String formatPropertySpecsDetail(
    String propertyType,
    int? bedrooms,
    int? bathrooms,
    double? areaSize,
    String? areaUnit,
  ) {
    final parts = <String>[];
    parts.add('Type: $propertyType');
    if (bedrooms != null) parts.add('Bedrooms: $bedrooms');
    if (bathrooms != null) parts.add('Bathrooms: $bathrooms');
    if (areaSize != null && areaUnit != null) {
      parts.add('Area: $areaSize $areaUnit');
    }
    return parts.join(' • ');
  }
}
