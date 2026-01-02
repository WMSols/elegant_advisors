import 'package:cloud_firestore/cloud_firestore.dart';

class VisitTrackingModel {
  final String? id;
  final String propertyId;
  final int totalVisits;
  final int uniqueVisits;
  final Map<String, int> visitsByDate; // Date string -> visit count
  final DateTime lastVisitedAt;
  final DateTime updatedAt;

  VisitTrackingModel({
    this.id,
    required this.propertyId,
    this.totalVisits = 0,
    this.uniqueVisits = 0,
    Map<String, int>? visitsByDate,
    DateTime? lastVisitedAt,
    DateTime? updatedAt,
  }) : visitsByDate = visitsByDate ?? {},
       lastVisitedAt = lastVisitedAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory VisitTrackingModel.fromJson(Map<String, dynamic> json, String id) {
    return VisitTrackingModel(
      id: id,
      propertyId: json['propertyId'] ?? '',
      totalVisits: json['totalVisits'] ?? 0,
      uniqueVisits: json['uniqueVisits'] ?? 0,
      visitsByDate: Map<String, int>.from(json['visitsByDate'] ?? {}),
      lastVisitedAt: (json['lastVisitedAt'] as Timestamp?)?.toDate(),
      updatedAt: (json['updatedAt'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'propertyId': propertyId,
      'totalVisits': totalVisits,
      'uniqueVisits': uniqueVisits,
      'visitsByDate': visitsByDate,
      'lastVisitedAt': Timestamp.fromDate(lastVisitedAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  VisitTrackingModel copyWith({
    String? id,
    String? propertyId,
    int? totalVisits,
    int? uniqueVisits,
    Map<String, int>? visitsByDate,
    DateTime? lastVisitedAt,
    DateTime? updatedAt,
  }) {
    return VisitTrackingModel(
      id: id ?? this.id,
      propertyId: propertyId ?? this.propertyId,
      totalVisits: totalVisits ?? this.totalVisits,
      uniqueVisits: uniqueVisits ?? this.uniqueVisits,
      visitsByDate: visitsByDate ?? this.visitsByDate,
      lastVisitedAt: lastVisitedAt ?? this.lastVisitedAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
