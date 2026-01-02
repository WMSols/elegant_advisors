/// Spam protection utilities for contact forms
class AppSpamProtection {
  AppSpamProtection._();

  /// Honeypot field name (hidden field that should remain empty)
  static const String honeypotFieldName = 'website';

  /// Rate limiting: Maximum submissions per IP per hour
  static const int maxSubmissionsPerHour = 5;

  /// Rate limiting: Maximum submissions per IP per day
  static const int maxSubmissionsPerDay = 20;

  /// Check if honeypot field is filled (indicates bot)
  static bool isHoneypotFilled(String? honeypotValue) {
    return honeypotValue != null && honeypotValue.isNotEmpty;
  }

  /// Check if email contains suspicious patterns
  static bool isSuspiciousEmail(String email) {
    final suspiciousPatterns = [
      r'\.(ru|tk|ml|ga|cf)$', // Suspicious TLDs
      r'[0-9]{10,}', // Too many numbers
      r'[a-z]{20,}', // Too many consecutive letters
    ];

    for (final pattern in suspiciousPatterns) {
      if (RegExp(pattern, caseSensitive: false).hasMatch(email)) {
        return true;
      }
    }
    return false;
  }

  /// Check if message contains spam keywords
  static bool containsSpamKeywords(String message) {
    final spamKeywords = [
      'viagra',
      'casino',
      'lottery',
      'winner',
      'click here',
      'limited time',
      'act now',
      'buy now',
      'cheap',
      'discount',
      'free money',
    ];

    final lowerMessage = message.toLowerCase();
    for (final keyword in spamKeywords) {
      if (lowerMessage.contains(keyword)) {
        return true;
      }
    }
    return false;
  }

  /// Check if submission rate is too high
  /// This should be checked against stored submission timestamps per IP
  static bool isRateLimitExceeded({
    required int submissionsLastHour,
    required int submissionsLastDay,
  }) {
    return submissionsLastHour >= maxSubmissionsPerHour ||
        submissionsLastDay >= maxSubmissionsPerDay;
  }

  /// Validate submission for spam
  /// Returns true if submission is likely spam
  static bool isSpam({
    String? honeypotValue,
    required String email,
    required String message,
    int? submissionsLastHour,
    int? submissionsLastDay,
  }) {
    // Check honeypot
    if (isHoneypotFilled(honeypotValue)) {
      return true;
    }

    // Check suspicious email
    if (isSuspiciousEmail(email)) {
      return true;
    }

    // Check spam keywords
    if (containsSpamKeywords(message)) {
      return true;
    }

    // Check rate limiting
    if (submissionsLastHour != null && submissionsLastDay != null) {
      if (isRateLimitExceeded(
        submissionsLastHour: submissionsLastHour,
        submissionsLastDay: submissionsLastDay,
      )) {
        return true;
      }
    }

    return false;
  }
}
