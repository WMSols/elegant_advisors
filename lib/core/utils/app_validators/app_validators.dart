/// Form AppValidators
/// Contains validation functions for form inputs
class AppValidators {
  /// Email validation with advanced checks
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    final trimmedValue = value.trim();

    // Check for spaces
    if (value.contains(' ')) {
      return 'Email cannot contain spaces';
    }

    // Check for @ symbol
    if (!trimmedValue.contains('@')) {
      return 'Email must contain @ symbol';
    }

    // Check for multiple @ symbols
    if (trimmedValue.split('@').length - 1 > 1) {
      return 'Email can only contain one @ symbol';
    }

    // Split email into local and domain parts
    final parts = trimmedValue.split('@');
    if (parts.length != 2) {
      return 'Please enter a valid email address';
    }

    final localPart = parts[0];
    final domainPart = parts[1];

    // Validate local part
    if (localPart.isEmpty) {
      return 'Email must have a name before @';
    }

    if (localPart.length > 64) {
      return 'Email name is too long (max 64 characters)';
    }

    // Validate domain part
    if (domainPart.isEmpty) {
      return 'Email must have a domain after @';
    }

    if (!domainPart.contains('.')) {
      return 'Email domain must contain a dot (.)';
    }

    // Check for consecutive dots
    if (domainPart.contains('..')) {
      return 'Email domain cannot contain consecutive dots';
    }

    // Advanced email regex
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9](?:[a-zA-Z0-9._-]*[a-zA-Z0-9])?@[a-zA-Z0-9](?:[a-zA-Z0-9.-]*[a-zA-Z0-9])?\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(trimmedValue)) {
      return 'Please enter a valid email address (e.g., name@example.com)';
    }

    // Check for invalid characters
    final invalidCharsRegex = RegExp(r'[<>()[\]\\,;:"\s]');
    if (invalidCharsRegex.hasMatch(trimmedValue)) {
      return 'Email contains invalid characters';
    }

    return null;
  }

  /// Password validation with advanced checks
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    // Minimum length
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }

    // Maximum length
    if (value.length > 128) {
      return 'Password is too long (max 128 characters)';
    }

    // Check for spaces
    if (value.contains(' ')) {
      return 'Password cannot contain spaces';
    }

    // Check for common weak passwords
    final weakPasswords = [
      'password',
      '123456',
      '12345678',
      'qwerty',
      'abc123',
      'password123',
    ];
    if (weakPasswords.contains(value.toLowerCase())) {
      return 'This password is too common. Please choose a stronger one';
    }

    // Check if password is all the same character
    if (value.split('').every((char) => char == value[0])) {
      return 'Password cannot be all the same character';
    }

    // Check if password is all numbers
    if (RegExp(r'^\d+$').hasMatch(value)) {
      return 'Password should contain letters, not just numbers';
    }

    // Check if password is all letters
    if (RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
      return 'For better security, add numbers or special characters';
    }

    return null;
  }

  /// Admin password validation with stricter requirements
  static String? validateAdminPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    // Minimum length for admin (stricter)
    if (value.length < 8) {
      return 'Admin password must be at least 8 characters long';
    }

    // Maximum length
    if (value.length > 128) {
      return 'Password is too long (max 128 characters)';
    }

    // Check for spaces
    if (value.contains(' ')) {
      return 'Password cannot contain spaces';
    }

    // Check for common weak passwords
    final weakPasswords = [
      'password',
      'admin',
      '123456',
      '12345678',
      'qwerty',
      'abc123',
      'password123',
      'admin123',
      'root',
      'administrator',
    ];
    if (weakPasswords.contains(value.toLowerCase())) {
      return 'This password is too common. Please choose a stronger one';
    }

    // Check if password is all the same character
    if (value.split('').every((char) => char == value[0])) {
      return 'Password cannot be all the same character';
    }

    // Check if password is all numbers
    if (RegExp(r'^\d+$').hasMatch(value)) {
      return 'Password must contain letters, not just numbers';
    }

    // Check if password is all letters
    if (RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
      return 'Password must contain numbers or special characters for security';
    }

    // Check for at least one uppercase letter
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password must contain at least one uppercase letter';
    }

    // Check for at least one lowercase letter
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Password must contain at least one lowercase letter';
    }

    // Check for at least one number
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password must contain at least one number';
    }

    return null;
  }

  /// Name validation with advanced checks
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }

    final trimmedValue = value.trim();

    // Minimum length
    if (trimmedValue.length < 2) {
      return 'Name must be at least 2 characters long';
    }

    // Maximum length
    if (trimmedValue.length > 50) {
      return 'Name must be less than 50 characters';
    }

    // Check for only spaces
    if (trimmedValue.isEmpty) {
      return 'Name cannot be only spaces';
    }

    // Check for numbers only
    if (RegExp(r'^\d+$').hasMatch(trimmedValue)) {
      return 'Name cannot be only numbers';
    }

    // Check for special characters (allow only common ones like hyphen, apostrophe)
    final invalidCharsRegex = RegExp(r'[!@#$%^&*()+=\[\]{}|;:"<>?/\\]');
    if (invalidCharsRegex.hasMatch(trimmedValue)) {
      return 'Name contains invalid characters. Only letters, spaces, hyphens, and apostrophes are allowed';
    }

    // Check for consecutive spaces
    if (trimmedValue.contains('  ')) {
      return 'Name cannot contain consecutive spaces';
    }

    // Check if name starts or ends with space
    if (value != trimmedValue) {
      return 'Name cannot start or end with spaces';
    }

    return null;
  }

  /// Age validation with advanced checks
  static String? validateAge(String? value) {
    if (value == null || value.isEmpty) {
      return 'Age is required';
    }

    final trimmedValue = value.trim();

    // Check for non-numeric characters
    if (!RegExp(r'^\d+$').hasMatch(trimmedValue)) {
      return 'Age must be a number';
    }

    final age = int.tryParse(trimmedValue);
    if (age == null) {
      return 'Please enter a valid age';
    }

    // Check minimum age
    if (age < 1) {
      return 'Age must be at least 1';
    }

    if (age < 18) {
      return 'You must be 18 years or older to use this app';
    }

    // Check maximum age (reasonable limit)
    if (age > 120) {
      return 'Please enter a valid age (maximum 120)';
    }

    return null;
  }

  /// Phone number validation with international format support
  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }

    final trimmedValue = value.trim();

    // Check for only spaces
    if (trimmedValue.isEmpty) {
      return 'Phone number cannot be only spaces';
    }

    // Remove common phone formatting characters for validation
    final cleanedPhone = trimmedValue
        .replaceAll(RegExp(r'[\s\-\(\)\+]'), ''); // Remove spaces, dashes, parentheses, plus

    // Check if phone contains only digits after cleaning
    if (!RegExp(r'^\d+$').hasMatch(cleanedPhone)) {
      return 'Phone number can only contain digits, spaces, dashes, parentheses, and +';
    }

    // Minimum length check (at least 7 digits, typical minimum for phone numbers)
    if (cleanedPhone.length < 7) {
      return 'Phone number must be at least 7 digits';
    }

    // Maximum length check (15 digits is ITU-T E.164 standard max)
    if (cleanedPhone.length > 15) {
      return 'Phone number is too long (maximum 15 digits)';
    }

    // Check for all same digits (e.g., 1111111)
    if (cleanedPhone.split('').every((char) => char == cleanedPhone[0])) {
      return 'Please enter a valid phone number';
    }

    return null;
  }

  /// Message validation with enhanced checks
  static String? validateMessage(String? value) {
    if (value == null || value.isEmpty) {
      return 'Message is required';
    }

    final trimmedValue = value.trim();

    // Check for only spaces
    if (trimmedValue.isEmpty) {
      return 'Message cannot be empty';
    }

    // Minimum length check
    if (trimmedValue.length < 10) {
      return 'Message must be at least 10 characters long';
    }

    // Maximum length check
    if (trimmedValue.length > 1000) {
      return 'Message must be less than 1000 characters';
    }

    // Check for only whitespace characters
    if (trimmedValue.split('').every((char) => char == ' ' || char == '\n' || char == '\t')) {
      return 'Message cannot contain only spaces';
    }

    // Check for excessive consecutive spaces
    if (trimmedValue.contains('   ')) {
      return 'Message cannot contain excessive spaces';
    }

    return null;
  }

  /// Required field validation
  static String? validateRequired(String? value, [String? fieldName]) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'This field'} is required';
    }
    return null;
  }

  /// Property title validation
  static String? validatePropertyTitle(String? value) {
    if (value == null || value.isEmpty) {
      return 'Property title is required';
    }
    if (value.trim().length < 3) {
      return 'Title must be at least 3 characters';
    }
    if (value.trim().length > 200) {
      return 'Title must be less than 200 characters';
    }
    return null;
  }

  /// Property slug validation
  static String? validatePropertySlug(String? value) {
    if (value == null || value.isEmpty) {
      return 'Slug is required';
    }
    if (!RegExp(r'^[a-z0-9]+(?:-[a-z0-9]+)*$').hasMatch(value)) {
      return 'Slug must contain only lowercase letters, numbers, and hyphens';
    }
    if (value.length < 3) {
      return 'Slug must be at least 3 characters';
    }
    if (value.length > 100) {
      return 'Slug must be less than 100 characters';
    }
    return null;
  }

  /// Property description validation
  static String? validatePropertyDescription(
    String? value, {
    bool isShort = false,
  }) {
    if (value == null || value.isEmpty) {
      return isShort
          ? 'Short description is required'
          : 'Description is required';
    }
    if (isShort) {
      if (value.trim().length < 10) {
        return 'Short description must be at least 10 characters';
      }
      if (value.trim().length > 500) {
        return 'Short description must be less than 500 characters';
      }
    } else {
      if (value.trim().length < 20) {
        return 'Description must be at least 20 characters';
      }
      if (value.trim().length > 5000) {
        return 'Description must be less than 5000 characters';
      }
    }
    return null;
  }

  /// Property location validation
  static String? validatePropertyLocation(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    if (value.trim().length < 2) {
      return '$fieldName must be at least 2 characters';
    }
    if (value.trim().length > 100) {
      return '$fieldName must be less than 100 characters';
    }
    return null;
  }

  /// Property price validation
  static String? validatePropertyPrice(String? value, bool isOnRequest) {
    if (isOnRequest) {
      return null; // Price is optional if on request
    }
    if (value == null || value.isEmpty) {
      return 'Price amount is required';
    }
    final price = double.tryParse(value);
    if (price == null) {
      return 'Please enter a valid number';
    }
    if (price < 0) {
      return 'Price cannot be negative';
    }
    if (price > 999999999) {
      return 'Price is too large';
    }
    return null;
  }

  /// Property type validation
  static String? validatePropertyType(String? value) {
    if (value == null || value.isEmpty) {
      return 'Property type is required';
    }
    if (value.trim().length < 2) {
      return 'Property type must be at least 2 characters';
    }
    if (value.trim().length > 50) {
      return 'Property type must be less than 50 characters';
    }
    return null;
  }

  /// Property numeric field validation (bedrooms, bathrooms, area)
  static String? validatePropertyNumeric(
    String? value,
    String fieldName, {
    int? max,
  }) {
    if (value == null || value.isEmpty) {
      return null; // Optional field
    }
    final numeric = int.tryParse(value);
    if (numeric == null) {
      return 'Please enter a valid number';
    }
    if (numeric < 0) {
      return '$fieldName cannot be negative';
    }
    if (max != null && numeric > max) {
      return '$fieldName cannot exceed $max';
    }
    return null;
  }

  /// Property area size validation
  static String? validatePropertyAreaSize(String? value) {
    if (value == null || value.isEmpty) {
      return 'Area size is required';
    }
    final area = double.tryParse(value);
    if (area == null) {
      return 'Please enter a valid number';
    }
    if (area < 0) {
      return 'Area size cannot be negative';
    }
    if (area > 1000000) {
      return 'Area size is too large';
    }
    return null;
  }

  /// Property area validation (neighborhood/area field)
  static String? validatePropertyArea(String? value) {
    if (value == null || value.isEmpty) {
      return 'Area is required';
    }
    if (value.trim().length < 2) {
      return 'Area must be at least 2 characters';
    }
    if (value.trim().length > 100) {
      return 'Area must be less than 100 characters';
    }
    return null;
  }

  /// Property address validation
  static String? validatePropertyAddress(String? value) {
    if (value == null || value.isEmpty) {
      return 'Address is required';
    }
    if (value.trim().length < 5) {
      return 'Address must be at least 5 characters';
    }
    if (value.trim().length > 200) {
      return 'Address must be less than 200 characters';
    }
    return null;
  }

  /// Property bedrooms validation (required)
  static String? validatePropertyBedroomsRequired(String? value) {
    if (value == null || value.isEmpty) {
      return 'Bedrooms is required';
    }
    return validatePropertyNumeric(value, 'Bedrooms', max: 50);
  }

  /// Property bathrooms validation (required)
  static String? validatePropertyBathroomsRequired(String? value) {
    if (value == null || value.isEmpty) {
      return 'Bathrooms is required';
    }
    return validatePropertyNumeric(value, 'Bathrooms', max: 50);
  }

  /// Property price validation (required when not on request)
  static String? validatePropertyPriceRequired(
    String? value,
    bool isOnRequest,
  ) {
    if (isOnRequest) {
      return null; // Price is optional if on request
    }
    if (value == null || value.isEmpty) {
      return 'Price amount is required';
    }
    return validatePropertyPrice(value, isOnRequest);
  }
}
