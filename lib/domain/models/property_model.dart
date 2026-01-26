import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elegant_advisors/core/utils/app_helpers/language/multilingual_helper.dart';

class PropertyModel {
  final String? id;
  // Store multilingual data (can be String or Map<String, String>)
  final dynamic _title;
  final String slug;
  final dynamic _shortDescription;
  final dynamic _fullDescription;
  final PropertyLocation location;
  final PropertyPrice price;
  final PropertySpecs specs;
  final dynamic _features; // Can be List<String> or Map<String, List<String>>
  final String status; // available, sold, off_market, coming_soon
  final List<String> images;
  final String? coverImage;
  final bool isFeatured;
  final int sortOrder;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isPublished;

  // Localized getters that automatically extract text based on current locale
  String get title => MultilingualHelper.getLocalizedText(_title);
  String get shortDescription =>
      MultilingualHelper.getLocalizedText(_shortDescription);
  String get fullDescription =>
      MultilingualHelper.getLocalizedText(_fullDescription);
  List<String> get features => MultilingualHelper.getLocalizedList(_features);

  // Helper methods to access raw multilingual data (for admin editing)
  dynamic get rawTitle => _title;
  dynamic get rawShortDescription => _shortDescription;
  dynamic get rawFullDescription => _fullDescription;
  dynamic get rawFeatures => _features;

  // Check if a field is multilingual (Map format)
  bool get isMultilingual {
    return _title is Map<String, dynamic>;
  }

  PropertyModel({
    this.id,
    dynamic title,
    required this.slug,
    dynamic shortDescription,
    dynamic fullDescription,
    required this.location,
    required this.price,
    required this.specs,
    dynamic features,
    required this.status,
    required this.images,
    this.coverImage,
    this.isFeatured = false,
    this.sortOrder = 0,
    DateTime? createdAt,
    DateTime? updatedAt,
    this.isPublished = false,
  }) : _title = title ?? '',
       _shortDescription = shortDescription ?? '',
       _fullDescription = fullDescription ?? '',
       _features = features ?? [],
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory PropertyModel.fromJson(Map<String, dynamic> json, String id) {
    return PropertyModel(
      id: id,
      title: json['title'],
      slug: json['slug'] ?? '',
      shortDescription: json['shortDescription'],
      fullDescription: json['fullDescription'],
      location: PropertyLocation.fromJson(json['location'] ?? {}),
      price: PropertyPrice.fromJson(json['price'] ?? {}),
      specs: PropertySpecs.fromJson(json['specs'] ?? {}),
      features: json['features'],
      status: json['status'] ?? 'available',
      images: List<String>.from(json['images'] ?? []),
      coverImage: json['coverImage'],
      isFeatured: json['isFeatured'] ?? false,
      sortOrder: json['sortOrder'] ?? 0,
      createdAt: (json['createdAt'] as Timestamp?)?.toDate(),
      updatedAt: (json['updatedAt'] as Timestamp?)?.toDate(),
      isPublished: json['isPublished'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': _title,
      'slug': slug,
      'shortDescription': _shortDescription,
      'fullDescription': _fullDescription,
      'location': location.toJson(),
      'price': price.toJson(),
      'specs': specs.toJson(),
      'features': _features,
      'status': status,
      'images': images,
      'coverImage': coverImage,
      'isFeatured': isFeatured,
      'sortOrder': sortOrder,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
      'isPublished': isPublished,
    };
  }

  PropertyModel copyWith({
    String? id,
    dynamic title,
    String? slug,
    dynamic shortDescription,
    dynamic fullDescription,
    PropertyLocation? location,
    PropertyPrice? price,
    PropertySpecs? specs,
    dynamic features,
    String? status,
    List<String>? images,
    String? coverImage,
    bool? isFeatured,
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isPublished,
  }) {
    return PropertyModel(
      id: id ?? this.id,
      title: title ?? _title,
      slug: slug ?? this.slug,
      shortDescription: shortDescription ?? _shortDescription,
      fullDescription: fullDescription ?? _fullDescription,
      location: location ?? this.location,
      price: price ?? this.price,
      specs: specs ?? this.specs,
      features: features ?? _features,
      status: status ?? this.status,
      images: images ?? this.images,
      coverImage: coverImage ?? this.coverImage,
      isFeatured: isFeatured ?? this.isFeatured,
      sortOrder: sortOrder ?? this.sortOrder,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isPublished: isPublished ?? this.isPublished,
    );
  }
}

class PropertyLocation {
  final dynamic _country; // Can be String or Map<String, String>
  final dynamic _city; // Can be String or Map<String, String>
  final dynamic _area; // Can be String or Map<String, String>
  final dynamic _address; // Can be String or Map<String, String>
  final double? lat;
  final double? lng;

  // Localized getters
  String get country => MultilingualHelper.getLocalizedText(_country);
  String get city => MultilingualHelper.getLocalizedText(_city);
  String? get area =>
      _area != null ? MultilingualHelper.getLocalizedText(_area) : null;
  String? get address =>
      _address != null ? MultilingualHelper.getLocalizedText(_address) : null;

  // Helper methods to access raw multilingual data (for admin editing)
  dynamic get rawCountry => _country;
  dynamic get rawCity => _city;
  dynamic get rawArea => _area;
  dynamic get rawAddress => _address;

  PropertyLocation({
    dynamic country,
    dynamic city,
    dynamic area,
    dynamic address,
    this.lat,
    this.lng,
  }) : _country = country ?? '',
       _city = city ?? '',
       _area = area,
       _address = address;

  factory PropertyLocation.fromJson(Map<String, dynamic> json) {
    return PropertyLocation(
      country: json['country'],
      city: json['city'],
      area: json['area'],
      address: json['address'],
      lat: json['lat']?.toDouble(),
      lng: json['lng']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'country': _country,
      'city': _city,
      if (_area != null) 'area': _area,
      if (_address != null) 'address': _address,
      if (lat != null) 'lat': lat,
      if (lng != null) 'lng': lng,
    };
  }
}

class PropertyPrice {
  final double? amount;
  final String currency;
  final bool isOnRequest;

  PropertyPrice({this.amount, this.currency = 'EUR', this.isOnRequest = false});

  factory PropertyPrice.fromJson(Map<String, dynamic> json) {
    return PropertyPrice(
      amount: json['amount']?.toDouble(),
      currency: json['currency'] ?? 'EUR',
      isOnRequest: json['isOnRequest'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (amount != null) 'amount': amount,
      'currency': currency,
      'isOnRequest': isOnRequest,
    };
  }
}

class PropertySpecs {
  final int? bedrooms;
  final int? bathrooms;
  final double? areaSize;
  final String? areaUnit; // sqm or sqft
  final dynamic _propertyType; // Can be String or Map<String, String>

  // Localized getter
  String get propertyType => MultilingualHelper.getLocalizedText(_propertyType);

  // Helper method to access raw multilingual data (for admin editing)
  dynamic get rawPropertyType => _propertyType;

  PropertySpecs({
    this.bedrooms,
    this.bathrooms,
    this.areaSize,
    this.areaUnit,
    dynamic propertyType,
  }) : _propertyType = propertyType ?? '';

  factory PropertySpecs.fromJson(Map<String, dynamic> json) {
    return PropertySpecs(
      bedrooms: json['bedrooms'],
      bathrooms: json['bathrooms'],
      areaSize: json['areaSize']?.toDouble(),
      areaUnit: json['areaUnit'],
      propertyType: json['propertyType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (bedrooms != null) 'bedrooms': bedrooms,
      if (bathrooms != null) 'bathrooms': bathrooms,
      if (areaSize != null) 'areaSize': areaSize,
      if (areaUnit != null) 'areaUnit': areaUnit,
      'propertyType': _propertyType,
    };
  }
}
