import 'package:cloud_firestore/cloud_firestore.dart';

class PropertyModel {
  final String? id;
  final String title;
  final String slug;
  final String shortDescription;
  final String fullDescription;
  final PropertyLocation location;
  final PropertyPrice price;
  final PropertySpecs specs;
  final List<String> features;
  final String status; // available, sold, off_market, coming_soon
  final List<String> images;
  final String? coverImage;
  final bool isFeatured;
  final int sortOrder;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isPublished;

  PropertyModel({
    this.id,
    required this.title,
    required this.slug,
    required this.shortDescription,
    required this.fullDescription,
    required this.location,
    required this.price,
    required this.specs,
    required this.features,
    required this.status,
    required this.images,
    this.coverImage,
    this.isFeatured = false,
    this.sortOrder = 0,
    DateTime? createdAt,
    DateTime? updatedAt,
    this.isPublished = false,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory PropertyModel.fromJson(Map<String, dynamic> json, String id) {
    return PropertyModel(
      id: id,
      title: json['title'] ?? '',
      slug: json['slug'] ?? '',
      shortDescription: json['shortDescription'] ?? '',
      fullDescription: json['fullDescription'] ?? '',
      location: PropertyLocation.fromJson(json['location'] ?? {}),
      price: PropertyPrice.fromJson(json['price'] ?? {}),
      specs: PropertySpecs.fromJson(json['specs'] ?? {}),
      features: List<String>.from(json['features'] ?? []),
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
      'title': title,
      'slug': slug,
      'shortDescription': shortDescription,
      'fullDescription': fullDescription,
      'location': location.toJson(),
      'price': price.toJson(),
      'specs': specs.toJson(),
      'features': features,
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
    String? title,
    String? slug,
    String? shortDescription,
    String? fullDescription,
    PropertyLocation? location,
    PropertyPrice? price,
    PropertySpecs? specs,
    List<String>? features,
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
      title: title ?? this.title,
      slug: slug ?? this.slug,
      shortDescription: shortDescription ?? this.shortDescription,
      fullDescription: fullDescription ?? this.fullDescription,
      location: location ?? this.location,
      price: price ?? this.price,
      specs: specs ?? this.specs,
      features: features ?? this.features,
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
  final String country;
  final String city;
  final String? area;
  final String? address;
  final double? lat;
  final double? lng;

  PropertyLocation({
    required this.country,
    required this.city,
    this.area,
    this.address,
    this.lat,
    this.lng,
  });

  factory PropertyLocation.fromJson(Map<String, dynamic> json) {
    return PropertyLocation(
      country: json['country'] ?? '',
      city: json['city'] ?? '',
      area: json['area'],
      address: json['address'],
      lat: json['lat']?.toDouble(),
      lng: json['lng']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'country': country,
      'city': city,
      if (area != null) 'area': area,
      if (address != null) 'address': address,
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
  final String propertyType; // apartment, villa, etc.

  PropertySpecs({
    this.bedrooms,
    this.bathrooms,
    this.areaSize,
    this.areaUnit,
    required this.propertyType,
  });

  factory PropertySpecs.fromJson(Map<String, dynamic> json) {
    return PropertySpecs(
      bedrooms: json['bedrooms'],
      bathrooms: json['bathrooms'],
      areaSize: json['areaSize']?.toDouble(),
      areaUnit: json['areaUnit'],
      propertyType: json['propertyType'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (bedrooms != null) 'bedrooms': bedrooms,
      if (bathrooms != null) 'bathrooms': bathrooms,
      if (areaSize != null) 'areaSize': areaSize,
      if (areaUnit != null) 'areaUnit': areaUnit,
      'propertyType': propertyType,
    };
  }
}
