import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elegant_advisors/core/utils/app_helpers/language/multilingual_helper.dart';

class SiteContentModel {
  final String? id;
  final dynamic _title; // Can be String or Map<String, String>
  final List<ContentSection> sections;
  final DateTime? lastUpdatedAt;
  final bool isPublished;

  // Localized getter
  String get title => MultilingualHelper.getLocalizedText(_title);

  SiteContentModel({
    this.id,
    dynamic title,
    required this.sections,
    DateTime? lastUpdatedAt,
    this.isPublished = false,
  }) : _title = title ?? '',
       lastUpdatedAt = lastUpdatedAt ?? DateTime.now();

  factory SiteContentModel.fromJson(Map<String, dynamic> json, String id) {
    return SiteContentModel(
      id: id,
      title: json['title'],
      sections:
          (json['sections'] as List<dynamic>?)
              ?.map((e) => ContentSection.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      lastUpdatedAt: (json['lastUpdatedAt'] as Timestamp?)?.toDate(),
      isPublished: json['isPublished'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': _title,
      'sections': sections.map((e) => e.toJson()).toList(),
      'lastUpdatedAt': Timestamp.fromDate(lastUpdatedAt!),
      'isPublished': isPublished,
    };
  }

  SiteContentModel copyWith({
    String? id,
    dynamic title,
    List<ContentSection>? sections,
    DateTime? lastUpdatedAt,
    bool? isPublished,
  }) {
    return SiteContentModel(
      id: id ?? this.id,
      title: title ?? _title,
      sections: sections ?? this.sections,
      lastUpdatedAt: lastUpdatedAt ?? this.lastUpdatedAt,
      isPublished: isPublished ?? this.isPublished,
    );
  }
}

class ContentSection {
  final dynamic _sectionTitle; // Can be String or Map<String, String>
  final dynamic _sectionBody; // Can be String or Map<String, String>
  final String? sectionImageUrl;
  final int sectionOrder;

  // Localized getters
  String get sectionTitle => MultilingualHelper.getLocalizedText(_sectionTitle);
  String get sectionBody => MultilingualHelper.getLocalizedText(_sectionBody);

  ContentSection({
    dynamic sectionTitle,
    dynamic sectionBody,
    this.sectionImageUrl,
    this.sectionOrder = 0,
  }) : _sectionTitle = sectionTitle ?? '',
       _sectionBody = sectionBody ?? '';

  factory ContentSection.fromJson(Map<String, dynamic> json) {
    return ContentSection(
      sectionTitle: json['sectionTitle'],
      sectionBody: json['sectionBody'],
      sectionImageUrl: json['sectionImageUrl'],
      sectionOrder: json['sectionOrder'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sectionTitle': _sectionTitle,
      'sectionBody': _sectionBody,
      if (sectionImageUrl != null) 'sectionImageUrl': sectionImageUrl,
      'sectionOrder': sectionOrder,
    };
  }
}
