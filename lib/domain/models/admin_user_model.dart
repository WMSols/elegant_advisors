import 'package:cloud_firestore/cloud_firestore.dart';

class AdminUserModel {
  final String? id;
  final String email;
  final String name;
  final String role; // super_admin, admin
  final DateTime createdAt;

  AdminUserModel({
    this.id,
    required this.email,
    required this.name,
    required this.role,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory AdminUserModel.fromJson(Map<String, dynamic> json, String id) {
    return AdminUserModel(
      id: id,
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      role: json['role'] ?? 'admin',
      createdAt: (json['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
      'role': role,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
