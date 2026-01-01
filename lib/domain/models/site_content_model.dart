import 'package:cloud_firestore/cloud_firestore.dart';

class SiteContentModel {
  final String? id;
  final String title;
  final List<ContentSection> sections;
  final DateTime? lastUpdatedAt;
  final bool isPublished;

  SiteContentModel({
    this.id,
    required this.title,
    required this.sections,
    DateTime? lastUpdatedAt,
    this.isPublished = false,
  }) : lastUpdatedAt = lastUpdatedAt ?? DateTime.now();

  factory SiteContentModel.fromJson(Map<String, dynamic> json, String id) {
    return SiteContentModel(
      id: id,
      title: json['title'] ?? '',
      sections: (json['sections'] as List<dynamic>?)
              ?.map((e) => ContentSection.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      lastUpdatedAt: (json['lastUpdatedAt'] as Timestamp?)?.toDate(),
      isPublished: json['isPublished'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'sections': sections.map((e) => e.toJson()).toList(),
      'lastUpdatedAt': Timestamp.fromDate(lastUpdatedAt!),
      'isPublished': isPublished,
    };
  }

  SiteContentModel copyWith({
    String? id,
    String? title,
    List<ContentSection>? sections,
    DateTime? lastUpdatedAt,
    bool? isPublished,
  }) {
    return SiteContentModel(
      id: id ?? this.id,
      title: title ?? this.title,
      sections: sections ?? this.sections,
      lastUpdatedAt: lastUpdatedAt ?? this.lastUpdatedAt,
      isPublished: isPublished ?? this.isPublished,
    );
  }
}

class ContentSection {
  final String sectionTitle;
  final String sectionBody;
  final String? sectionImageUrl;
  final int sectionOrder;

  ContentSection({
    required this.sectionTitle,
    required this.sectionBody,
    this.sectionImageUrl,
    this.sectionOrder = 0,
  });

  factory ContentSection.fromJson(Map<String, dynamic> json) {
    return ContentSection(
      sectionTitle: json['sectionTitle'] ?? '',
      sectionBody: json['sectionBody'] ?? '',
      sectionImageUrl: json['sectionImageUrl'],
      sectionOrder: json['sectionOrder'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sectionTitle': sectionTitle,
      'sectionBody': sectionBody,
      if (sectionImageUrl != null) 'sectionImageUrl': sectionImageUrl,
      'sectionOrder': sectionOrder,
    };
  }
}
