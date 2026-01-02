import 'package:elegant_advisors/domain/models/contact_submission_model.dart';

/// Service for exporting data (CSV, Excel, etc.)
class ExportService {
  ExportService._();

  /// Export contact submissions to CSV format
  static String exportInquiriesToCSV(List<ContactSubmissionModel> inquiries) {
    final buffer = StringBuffer();

    // CSV Header
    buffer.writeln(
      'ID,Name,Email,Phone,Subject,Message,Property ID,Status,IP Address,Created At',
    );

    // CSV Rows
    for (final inquiry in inquiries) {
      buffer.writeln(
        [
          inquiry.id ?? '',
          _escapeCSV(inquiry.name),
          _escapeCSV(inquiry.email),
          _escapeCSV(inquiry.phone),
          _escapeCSV(inquiry.subject),
          _escapeCSV(inquiry.message),
          inquiry.propertyId ?? '',
          inquiry.status,
          inquiry.ipAddress ?? '',
          inquiry.createdAt.toIso8601String(),
        ].join(','),
      );
    }

    return buffer.toString();
  }

  /// Export contact submissions to Excel-compatible format (TSV)
  static String exportInquiriesToTSV(List<ContactSubmissionModel> inquiries) {
    final buffer = StringBuffer();

    // TSV Header
    buffer.writeln(
      'ID\tName\tEmail\tPhone\tSubject\tMessage\tProperty ID\tStatus\tIP Address\tCreated At',
    );

    // TSV Rows
    for (final inquiry in inquiries) {
      buffer.writeln(
        [
          inquiry.id ?? '',
          inquiry.name,
          inquiry.email,
          inquiry.phone,
          inquiry.subject,
          inquiry.message,
          inquiry.propertyId ?? '',
          inquiry.status,
          inquiry.ipAddress ?? '',
          inquiry.createdAt.toIso8601String(),
        ].join('\t'),
      );
    }

    return buffer.toString();
  }

  /// Escape CSV field value
  static String _escapeCSV(String value) {
    if (value.contains(',') || value.contains('"') || value.contains('\n')) {
      return '"${value.replaceAll('"', '""')}"';
    }
    return value;
  }

  /// Download file (for web)
  /// This would typically trigger a browser download
  static Future<void> downloadFile({
    required String content,
    required String filename,
    required String mimeType,
  }) async {
    // TODO: Implement file download for web
    // This would use dart:html or a package like file_picker
    throw UnimplementedError('File download not implemented');
  }
}
