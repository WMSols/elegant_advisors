import 'package:cloud_firestore/cloud_firestore.dart';

class VisitorModel {
  final String? id;
  final String? ipAddress;
  final String? userAgent;
  final String? referrer;
  final String? country;
  final String? city;
  final DateTime visitedAt;
  final String? propertyId; // If visiting a property detail page
  final String pagePath;

  VisitorModel({
    this.id,
    this.ipAddress,
    this.userAgent,
    this.referrer,
    this.country,
    this.city,
    DateTime? visitedAt,
    this.propertyId,
    required this.pagePath,
  }) : visitedAt = visitedAt ?? DateTime.now();

  factory VisitorModel.fromJson(Map<String, dynamic> json, String id) {
    return VisitorModel(
      id: id,
      ipAddress: json['ipAddress'],
      userAgent: json['userAgent'],
      referrer: json['referrer'],
      country: json['country'],
      city: json['city'],
      visitedAt: (json['visitedAt'] as Timestamp?)?.toDate(),
      propertyId: json['propertyId'],
      pagePath: json['pagePath'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (ipAddress != null) 'ipAddress': ipAddress,
      if (userAgent != null) 'userAgent': userAgent,
      if (referrer != null) 'referrer': referrer,
      if (country != null) 'country': country,
      if (city != null) 'city': city,
      'visitedAt': Timestamp.fromDate(visitedAt),
      if (propertyId != null) 'propertyId': propertyId,
      'pagePath': pagePath,
    };
  }

  VisitorModel copyWith({
    String? id,
    String? ipAddress,
    String? userAgent,
    String? referrer,
    String? country,
    String? city,
    DateTime? visitedAt,
    String? propertyId,
    String? pagePath,
  }) {
    return VisitorModel(
      id: id ?? this.id,
      ipAddress: ipAddress ?? this.ipAddress,
      userAgent: userAgent ?? this.userAgent,
      referrer: referrer ?? this.referrer,
      country: country ?? this.country,
      city: city ?? this.city,
      visitedAt: visitedAt ?? this.visitedAt,
      propertyId: propertyId ?? this.propertyId,
      pagePath: pagePath ?? this.pagePath,
    );
  }
}
