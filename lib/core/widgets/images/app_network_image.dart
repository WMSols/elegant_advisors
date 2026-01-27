import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:elegant_advisors/core/widgets/feedback/app_loading_indicator.dart';
import 'package:elegant_advisors/core/widgets/images/app_error_image_fallback.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';

/// Reusable network image widget with loading, error handling, and fallback
///
/// Handles:
/// - Cached network image loading
/// - Loading states with responsive indicators
/// - Error handling with fallback to Image.network
/// - Responsive sizing
class AppNetworkImage extends StatelessWidget {
  /// The image URL to load
  final String imageUrl;

  /// How the image should be fitted
  final BoxFit fit;

  /// Loading indicator variant
  final LoadingIndicatorVariant loadingVariant;

  /// Custom placeholder widget (optional)
  final Widget? placeholder;

  /// Custom error fallback widget (optional)
  final Widget? errorWidget;

  /// Background color for loading/error states
  final Color? backgroundColor;

  /// Icon color for error fallback
  final Color? iconColor;

  /// Maximum width for disk cache
  final int? maxWidthDiskCache;

  /// Maximum height for disk cache
  final int? maxHeightDiskCache;

  /// Maximum width for memory cache (keeps image in memory for instant display)
  final int? memCacheWidth;

  /// Maximum height for memory cache (keeps image in memory for instant display)
  final int? memCacheHeight;

  /// Border radius for the image
  final double? borderRadius;

  /// Whether to enable debug logging
  final bool enableDebugLogging;

  const AppNetworkImage({
    super.key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.loadingVariant = LoadingIndicatorVariant.primary,
    this.placeholder,
    this.errorWidget,
    this.backgroundColor,
    this.iconColor,
    this.maxWidthDiskCache,
    this.maxHeightDiskCache,
    this.memCacheWidth,
    this.memCacheHeight,
    this.borderRadius,
    this.enableDebugLogging = false,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = backgroundColor ?? AppColors.grey.withValues(alpha: 0.2);
    final radius = borderRadius ?? AppResponsive.radius(context);

    Widget imageWidget = CachedNetworkImage(
      imageUrl: imageUrl,
      fit: fit,
      httpHeaders: const {'Accept': 'image/*'},
      maxWidthDiskCache: maxWidthDiskCache,
      maxHeightDiskCache: maxHeightDiskCache,
      memCacheWidth: memCacheWidth,
      memCacheHeight: memCacheHeight,
      fadeInDuration: const Duration(milliseconds: 300),
      fadeOutDuration: const Duration(milliseconds: 100),
      useOldImageOnUrlChange: true,
      placeholder: (context, url) =>
          placeholder ?? _buildLoadingPlaceholder(context, bgColor),
      errorWidget: (context, url, error) {
        if (enableDebugLogging) {
          debugPrint('Image load error: $error');
          debugPrint('Image URL: $url');
          debugPrint('Error type: ${error.runtimeType}');
        }
        return errorWidget ??
            _buildErrorFallback(context, url, bgColor, iconColor);
      },
    );

    if (borderRadius != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: imageWidget,
      );
    }

    return imageWidget;
  }

  Widget _buildLoadingPlaceholder(BuildContext context, Color bgColor) {
    return Container(
      color: bgColor,
      child: Center(
        child: AppLoadingIndicator(
          variant: loadingVariant,
          size: AppResponsive.scaleSize(context, 40, min: 30, max: 50),
        ),
      ),
    );
  }

  Widget _buildErrorFallback(
    BuildContext context,
    String url,
    Color bgColor,
    Color? iconColor,
  ) {
    // Try Image.network as fallback
    return Image.network(
      url,
      fit: fit,
      headers: const {'Accept': 'image/*'},
      errorBuilder: (context, error, stackTrace) {
        if (enableDebugLogging) {
          debugPrint('Image.network also failed: $error');
        }
        return AppErrorImageFallback(
          backgroundColor: bgColor,
          iconColor: iconColor,
        );
      },
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Container(
          color: bgColor,
          child: Center(
            child: AppLoadingIndicator(
              variant: loadingVariant,
              size: AppResponsive.scaleSize(context, 40, min: 30, max: 50),
            ),
          ),
        );
      },
    );
  }
}
