class TeamModel {
  final String? id;
  final String name;
  final String role;
  final String bio;
  final String? photoUrl;
  final String? email;
  final String? linkedinUrl;
  final int sortOrder;
  final bool isPublished;

  TeamModel({
    this.id,
    required this.name,
    required this.role,
    required this.bio,
    this.photoUrl,
    this.email,
    this.linkedinUrl,
    this.sortOrder = 0,
    this.isPublished = false,
  });

  factory TeamModel.fromJson(Map<String, dynamic> json, String id) {
    return TeamModel(
      id: id,
      name: json['name'] ?? '',
      role: json['role'] ?? '',
      bio: json['bio'] ?? '',
      photoUrl: json['photoUrl'],
      email: json['email'],
      linkedinUrl: json['linkedinUrl'],
      sortOrder: json['sortOrder'] ?? 0,
      isPublished: json['isPublished'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'role': role,
      'bio': bio,
      if (photoUrl != null) 'photoUrl': photoUrl,
      if (email != null) 'email': email,
      if (linkedinUrl != null) 'linkedinUrl': linkedinUrl,
      'sortOrder': sortOrder,
      'isPublished': isPublished,
    };
  }

  TeamModel copyWith({
    String? id,
    String? name,
    String? role,
    String? bio,
    String? photoUrl,
    String? email,
    String? linkedinUrl,
    int? sortOrder,
    bool? isPublished,
  }) {
    return TeamModel(
      id: id ?? this.id,
      name: name ?? this.name,
      role: role ?? this.role,
      bio: bio ?? this.bio,
      photoUrl: photoUrl ?? this.photoUrl,
      email: email ?? this.email,
      linkedinUrl: linkedinUrl ?? this.linkedinUrl,
      sortOrder: sortOrder ?? this.sortOrder,
      isPublished: isPublished ?? this.isPublished,
    );
  }
}
