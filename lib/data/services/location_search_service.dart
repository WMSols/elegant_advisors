import 'dart:convert';
import 'package:http/http.dart' as http;

/// Model for location search results
class LocationSearchResult {
  final String displayName;
  final double latitude;
  final double longitude;
  final String? type; // e.g., "city", "country", "house", etc.

  LocationSearchResult({
    required this.displayName,
    required this.latitude,
    required this.longitude,
    this.type,
  });
}

/// Service for searching locations using OpenStreetMap Nominatim API
class LocationSearchService {
  static const String _baseUrl = 'https://nominatim.openstreetmap.org';

  /// Search for locations by query string
  /// Returns a list of location suggestions
  Future<List<LocationSearchResult>> searchLocations(String query) async {
    if (query.trim().isEmpty) {
      return [];
    }

    try {
      final uri = Uri.parse('$_baseUrl/search').replace(queryParameters: {
        'q': query,
        'format': 'json',
        'limit': '10',
        'addressdetails': '1',
        'extratags': '1',
      });

      final response = await http.get(
        uri,
        headers: {
          'User-Agent': 'ElegantAdvisors/1.0',
        },
      );

      if (response.statusCode == 200) {
        final dynamic decoded = json.decode(response.body);
        if (decoded is List) {
          return decoded.map((item) {
            try {
              if (item is Map<String, dynamic>) {
                final lat = item['lat'];
                final lon = item['lon'];
                if (lat != null && lon != null) {
                  return LocationSearchResult(
                    displayName: _formatDisplayName(item),
                    latitude: double.tryParse(lat.toString()) ?? 0.0,
                    longitude: double.tryParse(lon.toString()) ?? 0.0,
                    type: item['type']?.toString(),
                  );
                }
              }
            } catch (e) {
              // Skip invalid items
            }
            return null;
          }).whereType<LocationSearchResult>().toList();
        }
        return [];
      } else {
        return [];
      }
    } catch (e) {
      // Return empty list on error
      return [];
    }
  }

  /// Format display name from Nominatim response
  String _formatDisplayName(Map<String, dynamic> item) {
    final address = item['address'] as Map<String, dynamic>?;
    final displayName = item['display_name'] as String?;

    if (displayName != null && displayName.isNotEmpty) {
      // Use the full display name from Nominatim
      return displayName;
    }

    // Fallback: construct from address components
    if (address != null) {
      final parts = <String>[];
      if (address['house_number'] != null) {
        parts.add(address['house_number'].toString());
      }
      if (address['road'] != null) {
        parts.add(address['road'].toString());
      }
      if (address['city'] != null) {
        parts.add(address['city'].toString());
      } else if (address['town'] != null) {
        parts.add(address['town'].toString());
      } else if (address['village'] != null) {
        parts.add(address['village'].toString());
      }
      if (address['country'] != null) {
        parts.add(address['country'].toString());
      }

      return parts.isNotEmpty ? parts.join(', ') : 'Unknown location';
    }

    return 'Unknown location';
  }

  /// Reverse geocode: Get location name from coordinates
  Future<String?> reverseGeocode(double lat, double lng) async {
    try {
      final uri = Uri.parse('$_baseUrl/reverse').replace(queryParameters: {
        'lat': lat.toString(),
        'lon': lng.toString(),
        'format': 'json',
        'addressdetails': '1',
      });

      final response = await http.get(
        uri,
        headers: {
          'User-Agent': 'ElegantAdvisors/1.0',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['display_name']?.toString();
      }
    } catch (e) {
      // Return null on error
    }
    return null;
  }
}
