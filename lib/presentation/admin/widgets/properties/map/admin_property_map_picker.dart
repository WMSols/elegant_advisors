import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/core/utils/app_texts/app_texts.dart';
import 'package:elegant_advisors/core/widgets/forms/app_text_field.dart';
import 'package:elegant_advisors/core/widgets/feedback/app_loading_indicator.dart';
import 'package:elegant_advisors/core/widgets/buttons/app_icon_button.dart';
import 'package:elegant_advisors/data/services/location_search_service.dart';
import 'package:iconsax/iconsax.dart';

/// Map picker widget for selecting property location using OpenStreetMap
class AdminPropertyMapPicker extends StatefulWidget {
  final Function(double lat, double lng) onLocationSelected;
  final double? initialLat;
  final double? initialLng;

  const AdminPropertyMapPicker({
    super.key,
    required this.onLocationSelected,
    this.initialLat,
    this.initialLng,
  });

  @override
  State<AdminPropertyMapPicker> createState() => _AdminPropertyMapPickerState();
}

class _AdminPropertyMapPickerState extends State<AdminPropertyMapPicker> {
  final MapController _mapController = MapController();
  final LocationSearchService _searchService = LocationSearchService();
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  final GlobalKey _searchFieldKey = GlobalKey();

  LatLng? _selectedLocation;
  List<LocationSearchResult> _searchResults = [];
  bool _isSearching = false;
  bool _showSuggestions = false;
  bool _isMapReady = false;
  Timer? _searchDebounce;

  @override
  void initState() {
    super.initState();
    if (widget.initialLat != null && widget.initialLng != null) {
      _selectedLocation = LatLng(widget.initialLat!, widget.initialLng!);
    } else {
      // Default to Portugal center
      _selectedLocation = const LatLng(39.5, -8.0);
    }
    // Don't call move() here - use initialCenter and initialZoom in MapOptions instead
    // The map needs to be rendered first before using MapController

    _searchController.addListener(_onSearchChanged);
    _searchFocusNode.addListener(_onFocusChanged);
    _ensureMapReady();
  }

  void _onSearchChanged() {
    if (_searchDebounce?.isActive ?? false) {
      _searchDebounce!.cancel();
    }

    _searchDebounce = Timer(const Duration(milliseconds: 500), () {
      _performSearch();
    });
  }

  void _onFocusChanged() {
    if (mounted) {
      setState(() {
        // Show suggestions when focused and we have results, or when we have text
        _showSuggestions =
            _searchResults.isNotEmpty &&
            (_searchFocusNode.hasFocus || _searchController.text.isNotEmpty);
      });
    }
  }

  void _onMapReady() {
    if (mounted) {
      setState(() {
        _isMapReady = true;
      });
    }
  }

  void _ensureMapReady() {
    // Try to set map as ready after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted && !_isMapReady) {
          setState(() {
            _isMapReady = true;
          });
        }
      });
    });
  }

  Future<void> _performSearch() async {
    final query = _searchController.text.trim();

    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
        _isSearching = false;
        _showSuggestions = false;
      });
      return;
    }

    setState(() {
      _isSearching = true;
    });

    try {
      final results = await _searchService.searchLocations(query);
      if (mounted) {
        setState(() {
          _searchResults = results;
          _isSearching = false;
          // Show suggestions if we have results
          _showSuggestions = results.isNotEmpty;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _searchResults = [];
          _isSearching = false;
          _showSuggestions = false;
        });
      }
    }
  }

  void _onLocationSelected(LocationSearchResult location) {
    final newLocation = LatLng(location.latitude, location.longitude);

    setState(() {
      _selectedLocation = newLocation;
      _searchController.text = location.displayName;
      _showSuggestions = false;
    });

    // Move map to selected location
    _moveMapToLocation(newLocation);

    widget.onLocationSelected(location.latitude, location.longitude);
    _searchFocusNode.unfocus();
  }

  void _moveMapToLocation(LatLng location) {
    if (_isMapReady) {
      // Map is ready, move immediately
      try {
        _mapController.move(location, 15.0);
      } catch (e) {
        // If move fails, try again after a delay
        Future.delayed(const Duration(milliseconds: 200), () {
          try {
            _mapController.move(location, 15.0);
          } catch (e) {
            // Ignore error
          }
        });
      }
    } else {
      // Map not ready yet, wait for it
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Future.delayed(const Duration(milliseconds: 300), () {
          if (mounted && _isMapReady) {
            try {
              _mapController.move(location, 15.0);
            } catch (e) {
              // Ignore error
            }
          }
        });
      });
    }
  }

  void _onMapTap(TapPosition tapPosition, LatLng point) {
    setState(() {
      _selectedLocation = point;
    });
    widget.onLocationSelected(point.latitude, point.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          AppTexts.adminPropertyMapPickerSelectLocation,
          style: AppTextStyles.bodyText(
            context,
          ).copyWith(color: AppColors.white, fontWeight: FontWeight.bold),
        ),
        AppSpacing.vertical(context, 0.01),
        // Search Field with Suggestions
        GestureDetector(
          onTap: () {
            // Close suggestions when tapping outside
            if (_showSuggestions) {
              _searchFocusNode.unfocus();
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppTextField(
                key: _searchFieldKey,
                controller: _searchController,
                hint: AppTexts.adminPropertyMapPickerSearchHint,
                prefixIcon: Icon(
                  Iconsax.search_normal,
                  size: AppResponsive.scaleSize(context, 20, min: 16, max: 24),
                ),
                suffixIcon: _isSearching
                    ? SizedBox(
                        width: 20,
                        height: 20,
                        child: AppLoadingIndicator(
                          variant: LoadingIndicatorVariant.primary,
                          size: 20,
                        ),
                      )
                    : _searchController.text.isNotEmpty
                    ? AppIconButton(
                        icon: Iconsax.close_circle,
                        iconSize: AppResponsive.scaleSize(
                          context,
                          20,
                          min: 16,
                          max: 24,
                        ),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {
                            _searchResults = [];
                            _showSuggestions = false;
                          });
                        },
                      )
                    : null,
                focusNode: _searchFocusNode,
                onChanged: (value) {
                  // Search is handled by listener
                },
              ),
              // Suggestions Dropdown
              if (_showSuggestions && _searchResults.isNotEmpty)
                GestureDetector(
                  onTap: () {
                    // Prevent closing when tapping on suggestions
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                      top: AppResponsive.scaleSize(context, 4, min: 2, max: 8),
                    ),
                    constraints: BoxConstraints(
                      maxHeight: AppResponsive.scaleSize(
                        context,
                        300,
                        min: 200,
                        max: 400,
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(
                        AppResponsive.radius(context),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.black.withValues(alpha: 0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ListView.separated(
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(
                        vertical: AppResponsive.scaleSize(
                          context,
                          8,
                          min: 4,
                          max: 12,
                        ),
                      ),
                      itemCount: _searchResults.length,
                      separatorBuilder: (context, index) => Divider(
                        height: 1,
                        color: AppColors.grey.withValues(alpha: 0.2),
                      ),
                      itemBuilder: (context, index) {
                        final location = _searchResults[index];
                        return InkWell(
                          onTap: () => _onLocationSelected(location),
                          child: Padding(
                            padding: AppSpacing.all(context, factor: 0.4),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.location_pin,
                                  color: AppColors.error,
                                  size: 20,
                                ),
                                AppSpacing.horizontal(context, 0.01),
                                Expanded(
                                  child: Text(
                                    location.displayName,
                                    style: AppTextStyles.bodyText(context)
                                        .copyWith(
                                          color: AppColors.black,
                                          fontSize: 14,
                                        ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
            ],
          ),
        ),
        AppSpacing.vertical(context, 0.01),
        Container(
          height: AppResponsive.scaleSize(context, 400, min: 300, max: 500),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppResponsive.radius(context)),
            border: Border.all(
              color: AppColors.white.withValues(alpha: 0.3),
              width: 2,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppResponsive.radius(context)),
            child: FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter: _selectedLocation!,
                initialZoom: 10.0,
                minZoom: 3.0,
                maxZoom: 18.0,
                onTap: _onMapTap,
                onMapReady:
                    _onMapReady, // May not exist in all versions, but safe to include
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.elegantadvisors.app',
                ),
                MarkerLayer(
                  markers: [
                    if (_selectedLocation != null)
                      Marker(
                        point: _selectedLocation!,
                        width: 40,
                        height: 40,
                        child: Icon(
                          Icons.location_pin,
                          color: AppColors.error,
                          size: 40,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
        AppSpacing.vertical(context, 0.01),
        if (_selectedLocation != null)
          Container(
            padding: AppSpacing.all(context, factor: 0.3),
            decoration: BoxDecoration(
              color: AppColors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(
                AppResponsive.radius(context),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.location_pin, color: AppColors.white, size: 16),
                AppSpacing.horizontal(context, 0.01),
                Expanded(
                  child: Text(
                    'Lat: ${_selectedLocation!.latitude.toStringAsFixed(6)}, Lng: ${_selectedLocation!.longitude.toStringAsFixed(6)}',
                    style: AppTextStyles.bodyText(
                      context,
                    ).copyWith(color: AppColors.white, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  @override
  void dispose() {
    _searchDebounce?.cancel();
    _searchController.removeListener(_onSearchChanged);
    _searchFocusNode.removeListener(_onFocusChanged);
    _searchController.dispose();
    _searchFocusNode.dispose();
    _mapController.dispose();
    super.dispose();
  }
}
