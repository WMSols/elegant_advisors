// Stub file for non-web platforms
// This file is used when dart:html is not available

/// Stub implementation for non-web platforms
class ExportServiceWeb {
  ExportServiceWeb._();

  /// Download file - no-op on non-web platforms
  static Future<void> downloadFile({
    required String content,
    required String filename,
    required String mimeType,
  }) async {
    // No-op on non-web platforms
  }
}
