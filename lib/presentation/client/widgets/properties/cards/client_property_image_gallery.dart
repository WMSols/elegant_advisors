import 'dart:async';
import 'package:flutter/material.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/widgets/images/app_network_image.dart';
import 'package:elegant_advisors/core/widgets/feedback/app_loading_indicator.dart';

/// Image gallery widget for property cards with auto-scroll carousel
class ClientPropertyImageGallery extends StatefulWidget {
  final List<String> images;
  final double height;
  final Duration autoScrollDuration;
  final bool showIndicators;

  const ClientPropertyImageGallery({
    super.key,
    required this.images,
    required this.height,
    this.autoScrollDuration = const Duration(seconds: 4),
    this.showIndicators = true,
  });

  @override
  State<ClientPropertyImageGallery> createState() =>
      _ClientPropertyImageGalleryState();
}

class _ClientPropertyImageGalleryState
    extends State<ClientPropertyImageGallery> {
  late PageController _pageController;
  late Timer _autoScrollTimer;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    if (widget.images.length > 1) {
      _startAutoScroll();
    }
  }

  @override
  void dispose() {
    _autoScrollTimer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    _autoScrollTimer = Timer.periodic(widget.autoScrollDuration, (_) {
      if (_pageController.hasClients) {
        if (_currentIndex < widget.images.length - 1) {
          _currentIndex++;
        } else {
          _currentIndex = 0;
        }
        _pageController.animateToPage(
          _currentIndex,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.images.isEmpty) {
      return Container(
        height: widget.height,
        color: AppColors.grey.withValues(alpha: 0.2),
        child: const Center(child: Icon(Icons.image, color: AppColors.primary)),
      );
    }

    if (widget.images.length == 1) {
      return SizedBox(
        height: widget.height,
        width: double.infinity,
        child: AppNetworkImage(
          imageUrl: widget.images.first,
          fit: BoxFit.cover,
          loadingVariant: LoadingIndicatorVariant.primary,
          maxWidthDiskCache: 800,
          maxHeightDiskCache: 600,
          memCacheWidth: 800,
          memCacheHeight: 600,
        ),
      );
    }

    return Stack(
      children: [
        SizedBox(
          height: widget.height,
          width: double.infinity,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            itemCount: widget.images.length,
            itemBuilder: (context, index) {
              return AppNetworkImage(
                imageUrl: widget.images[index],
                fit: BoxFit.cover,
                loadingVariant: LoadingIndicatorVariant.primary,
                maxWidthDiskCache: 800,
                maxHeightDiskCache: 600,
                memCacheWidth: 800,
                memCacheHeight: 600,
              );
            },
          ),
        ),
        // Indicators
        if (widget.showIndicators && widget.images.length > 1)
          Positioned(
            bottom: AppResponsive.scaleSize(context, 12, min: 8, max: 16),
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.images.length,
                (index) => _buildIndicator(context, index == _currentIndex),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildIndicator(BuildContext context, bool isActive) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: AppResponsive.scaleSize(context, 4, min: 2, max: 6),
      ),
      width: isActive
          ? AppResponsive.scaleSize(context, 24, min: 20, max: 28)
          : AppResponsive.scaleSize(context, 8, min: 6, max: 10),
      height: AppResponsive.scaleSize(context, 8, min: 6, max: 10),
      decoration: BoxDecoration(
        color: isActive
            ? AppColors.white
            : AppColors.white.withValues(alpha: 0.5),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(AppResponsive.radius(context, factor: 3)),
          bottomLeft: Radius.circular(AppResponsive.radius(context, factor: 3)),
        ),
      ),
    );
  }
}
