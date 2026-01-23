import 'dart:html' as html;
import 'dart:convert';

/// Web-specific implementation for ExportService
class ExportServiceWeb {
  ExportServiceWeb._();

  /// Download file (for web)
  /// This triggers a browser download
  static Future<void> downloadFile({
    required String content,
    required String filename,
    required String mimeType,
  }) async {
    // Convert content to bytes
    final bytes = utf8.encode(content);
    final blob = html.Blob([bytes], mimeType);
    final url = html.Url.createObjectUrlFromBlob(blob);

    // Create anchor element and trigger download
    final anchor = html.AnchorElement(href: url)
      ..setAttribute('download', filename)
      ..style.display = 'none';

    html.document.body?.append(anchor);
    anchor.click();
    anchor.remove();

    // Clean up
    html.Url.revokeObjectUrl(url);
  }
}
