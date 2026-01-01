import 'package:cloud_firestore/cloud_firestore.dart';

class ContactSubmissionModel {
  final String? id;
  final String name;
  final String email;
  final String phone;
  final String subject;
  final String message;
  final String? propertyId;
  final String status; // new, in_progress, closed
  final DateTime createdAt;

  ContactSubmissionModel({
    this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.subject,
    required this.message,
    this.propertyId,
    this.status = 'new',
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory ContactSubmissionModel.fromJson(Map<String, dynamic> json, String id) {
    return ContactSubmissionModel(
      id: id,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      subject: json['subject'] ?? '',
      message: json['message'] ?? '',
      propertyId: json['propertyId'],
      status: json['status'] ?? 'new',
      createdAt: (json['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'subject': subject,
      'message': message,
      if (propertyId != null) 'propertyId': propertyId,
      'status': status,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  ContactSubmissionModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? subject,
    String? message,
    String? propertyId,
    String? status,
    DateTime? createdAt,
  }) {
    return ContactSubmissionModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      subject: subject ?? this.subject,
      message: message ?? this.message,
      propertyId: propertyId ?? this.propertyId,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
