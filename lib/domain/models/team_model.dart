import 'package:elegant_advisors/core/utils/app_helpers/language/multilingual_helper.dart';

class TeamModel {
  final String? id;
  final dynamic _name; // Can be String or Map<String, String>
  final dynamic _role; // Can be String or Map<String, String>
  final dynamic _bio; // Can be String or Map<String, String>
  final String? photoUrl;
  final String? email;
  final String? linkedinUrl;
  final int sortOrder;
  final bool isPublished;

  // Localized getters
  String get name => MultilingualHelper.getLocalizedText(_name);
  String get role => MultilingualHelper.getLocalizedText(_role);
  String get bio => MultilingualHelper.getLocalizedText(_bio);

  TeamModel({
    this.id,
    dynamic name,
    dynamic role,
    dynamic bio,
    this.photoUrl,
    this.email,
    this.linkedinUrl,
    this.sortOrder = 0,
    this.isPublished = false,
  }) : _name = name ?? '',
       _role = role ?? '',
       _bio = bio ?? '';

  factory TeamModel.fromJson(Map<String, dynamic> json, String id) {
    return TeamModel(
      id: id,
      name: json['name'],
      role: json['role'],
      bio: json['bio'],
      photoUrl: json['photoUrl'],
      email: json['email'],
      linkedinUrl: json['linkedinUrl'],
      sortOrder: json['sortOrder'] ?? 0,
      isPublished: json['isPublished'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': _name,
      'role': _role,
      'bio': _bio,
      if (photoUrl != null) 'photoUrl': photoUrl,
      if (email != null) 'email': email,
      if (linkedinUrl != null) 'linkedinUrl': linkedinUrl,
      'sortOrder': sortOrder,
      'isPublished': isPublished,
    };
  }

  TeamModel copyWith({
    String? id,
    dynamic name,
    dynamic role,
    dynamic bio,
    String? photoUrl,
    String? email,
    String? linkedinUrl,
    int? sortOrder,
    bool? isPublished,
  }) {
    return TeamModel(
      id: id ?? this.id,
      name: name ?? _name,
      role: role ?? _role,
      bio: bio ?? _bio,
      photoUrl: photoUrl ?? this.photoUrl,
      email: email ?? this.email,
      linkedinUrl: linkedinUrl ?? this.linkedinUrl,
      sortOrder: sortOrder ?? this.sortOrder,
      isPublished: isPublished ?? this.isPublished,
    );
  }
}
