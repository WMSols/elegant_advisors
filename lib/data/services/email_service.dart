import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/foundation.dart';
import 'package:elegant_advisors/domain/models/contact_submission_model.dart';
import 'package:elegant_advisors/domain/models/property_model.dart';

/// Email service for sending notifications and confirmations
///
/// This service handles:
/// - Inquiry notification emails to admins
/// - Admin alerts
/// - Confirmation emails to users (optional)
///
/// Uses Firebase Cloud Functions for email delivery
class EmailService {
  final FirebaseFunctions _functions = FirebaseFunctions.instance;

  /// Send inquiry notification email to admin
  Future<void> sendInquiryNotification(
    ContactSubmissionModel inquiry,
    PropertyModel? property,
  ) async {
    try {
      final callable = _functions.httpsCallable('sendInquiryNotification');

      // Convert models to JSON for Cloud Function
      final inquiryData = {
        'id': inquiry.id,
        'name': inquiry.name,
        'email': inquiry.email,
        'phone': inquiry.phone,
        'subject': inquiry.subject,
        'message': inquiry.message,
        'propertyId': inquiry.propertyId,
        'status': inquiry.status,
        'ipAddress': inquiry.ipAddress,
        'createdAt': inquiry.createdAt.toIso8601String(),
      };

      Map<String, dynamic>? propertyData;
      if (property != null) {
        propertyData = {
          'id': property.id,
          'title': property.title,
          'slug': property.slug,
          'shortDescription': property.shortDescription,
          'location': {
            'country': property.location.country,
            'city': property.location.city,
            'area': property.location.area,
            'address': property.location.address,
          },
          'price': {
            'amount': property.price.amount,
            'currency': property.price.currency,
            'isOnRequest': property.price.isOnRequest,
          },
        };
      }

      await callable.call({'inquiry': inquiryData, 'property': propertyData});
    } on FirebaseFunctionsException catch (e) {
      // Log error but don't throw - email failure shouldn't break the flow
      debugPrint(
        'Failed to send inquiry notification: ${e.code} - ${e.message}',
      );
      rethrow;
    } catch (e) {
      debugPrint('Error sending inquiry notification: $e');
      rethrow;
    }
  }

  /// Send admin alert (e.g., new property added, system errors)
  Future<void> sendAdminAlert({
    required String subject,
    required String message,
    String? priority,
  }) async {
    try {
      final callable = _functions.httpsCallable('sendAdminAlert');

      await callable.call({
        'subject': subject,
        'message': message,
        'priority': priority ?? 'medium',
      });
    } on FirebaseFunctionsException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'invalid-argument':
          errorMessage = e.message ?? 'Invalid input provided';
          break;
        case 'permission-denied':
          errorMessage = 'You do not have permission to send admin alerts';
          break;
        case 'unauthenticated':
          errorMessage = 'You must be logged in to send admin alerts';
          break;
        default:
          errorMessage = e.message ?? 'Failed to send admin alert';
      }
      throw Exception(errorMessage);
    } catch (e) {
      throw Exception('Failed to send admin alert: ${e.toString()}');
    }
  }

  /// Send confirmation email to user after inquiry submission
  Future<void> sendInquiryConfirmation(ContactSubmissionModel inquiry) async {
    try {
      final callable = _functions.httpsCallable('sendInquiryConfirmation');

      // Convert model to JSON for Cloud Function
      final inquiryData = {
        'id': inquiry.id,
        'name': inquiry.name,
        'email': inquiry.email,
        'phone': inquiry.phone,
        'subject': inquiry.subject,
        'message': inquiry.message,
        'propertyId': inquiry.propertyId,
        'status': inquiry.status,
        'ipAddress': inquiry.ipAddress,
        'createdAt': inquiry.createdAt.toIso8601String(),
      };

      await callable.call({'inquiry': inquiryData});
    } on FirebaseFunctionsException catch (e) {
      // Log error but don't throw - confirmation email failure shouldn't break the flow
      debugPrint('Failed to send confirmation email: ${e.code} - ${e.message}');
      rethrow;
    } catch (e) {
      debugPrint('Error sending confirmation email: $e');
      rethrow;
    }
  }

  /// Send property inquiry notification (when inquiry is about specific property)
  /// This is a convenience method that calls sendInquiryNotification with property
  Future<void> sendPropertyInquiryNotification(
    ContactSubmissionModel inquiry,
    PropertyModel property,
  ) async {
    return sendInquiryNotification(inquiry, property);
  }

  /// Send reply email to user for an inquiry
  /// Requires admin authentication
  Future<void> sendInquiryReply(
    ContactSubmissionModel inquiry,
    String replyMessage,
  ) async {
    try {
      final callable = _functions.httpsCallable('sendInquiryReply');

      // Convert model to JSON for Cloud Function
      final inquiryData = {
        'id': inquiry.id,
        'name': inquiry.name,
        'email': inquiry.email,
        'phone': inquiry.phone,
        'subject': inquiry.subject,
        'message': inquiry.message,
        'propertyId': inquiry.propertyId,
        'status': inquiry.status,
        'ipAddress': inquiry.ipAddress,
        'createdAt': inquiry.createdAt.toIso8601String(),
      };

      await callable.call({
        'inquiry': inquiryData,
        'replyMessage': replyMessage.trim(),
      });
    } on FirebaseFunctionsException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'invalid-argument':
          errorMessage = e.message ?? 'Invalid input provided';
          break;
        case 'permission-denied':
          errorMessage = 'You do not have permission to send replies';
          break;
        case 'unauthenticated':
          errorMessage = 'You must be logged in to send replies';
          break;
        default:
          errorMessage = e.message ?? 'Failed to send reply email';
      }
      throw Exception(errorMessage);
    } catch (e) {
      throw Exception('Failed to send reply email: ${e.toString()}');
    }
  }
}
