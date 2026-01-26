import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';
import 'package:elegant_advisors/core/utils/app_helpers/language/app_localizations_helper.dart';
import 'package:elegant_advisors/core/utils/app_helpers/app_helpers.dart';
import 'package:elegant_advisors/domain/models/property_model.dart';

/// Property location section widget
class ClientPropertyDetailLocationSection extends StatelessWidget {
  final PropertyModel property;

  const ClientPropertyDetailLocationSection({
    super.key,
    required this.property,
  });

  Future<void> _openGoogleMaps(BuildContext context) async {
    if (property.location.lat == null || property.location.lng == null) {
      return;
    }

    final lat = property.location.lat!;
    final lng = property.location.lng!;

    // Create Google Maps URL
    final googleMapsUrl = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=$lat,$lng',
    );

    try {
      if (await canLaunchUrl(googleMapsUrl)) {
        await launchUrl(googleMapsUrl, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      // Handle error silently or show a snackbar
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${context.l10n.locationGoogleMapsError}: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasCoordinates =
        property.location.lat != null && property.location.lng != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.clientPropertyDetailLocation,
          style: AppTextStyles.heading(context).copyWith(
            fontSize: AppResponsive.fontSizeClamped(context, min: 24, max: 30),
            fontWeight: FontWeight.bold,
            color: AppColors.white,
          ),
        ),
        AppSpacing.vertical(context, 0.03),
        Text(
          AppHelpers.formatPropertyLocationFull(
            property.location.country,
            property.location.city,
            property.location.area,
            property.location.address,
          ),
          style: AppTextStyles.bodyText(context).copyWith(
            fontSize: AppResponsive.fontSizeClamped(context, min: 16, max: 18),
            color: AppColors.white,
          ),
        ),
        // Map with tap to open Google Maps
        if (hasCoordinates) ...[
          AppSpacing.vertical(context, 0.03),
          Container(
            height: AppResponsive.screenHeight(context) * 0.75,
            decoration: BoxDecoration(),
            child: ClipRRect(
              child: FlutterMap(
                options: MapOptions(
                  initialCenter: LatLng(
                    property.location.lat!,
                    property.location.lng!,
                  ),
                  initialZoom: 15.0,
                  minZoom: 3.0,
                  maxZoom: 18.0,
                  interactionOptions: const InteractionOptions(
                    flags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
                  ),
                  onTap: (tapPosition, point) => _openGoogleMaps(context),
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.elegantadvisors.app',
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: LatLng(
                          property.location.lat!,
                          property.location.lng!,
                        ),
                        width: 50,
                        height: 50,
                        child: Icon(
                          Icons.location_pin,
                          color: AppColors.error,
                          size: 50,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }
}
