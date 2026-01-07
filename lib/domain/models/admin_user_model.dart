import 'package:cloud_firestore/cloud_firestore.dart';

class AdminUserModel {
  final String? id;
  final String email;
  final String name;
  final DateTime createdAt;

  AdminUserModel({
    this.id,
    required this.email,
    required this.name,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory AdminUserModel.fromJson(Map<String, dynamic> json, String id) {
    return AdminUserModel(
      id: id,
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      createdAt: (json['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
