import 'dart:async';
import 'package:flutter/material.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/widgets/images/app_network_image.dart';
import 'package:elegant_advisors/core/widgets/feedback/app_loading_indicator.dart';

/// Full image gallery widget for property detail page
class ClientPropertyDetailImageGallery extends StatefulWidget {
  final List<String> images;
  final double height;
  final Duration autoScrollDuration;
  final bool showIndicators;

  const ClientPropertyDetailImageGallery({
    super.key,
    required this.images,
    this.height = 500,
    this.autoScrollDuration = const Duration(seconds: 5),
    this.showIndicators = true,
  });

  @override
  State<ClientPropertyDetailImageGallery> createState() =>
      _ClientPropertyDetailImageGalleryState();
}

class _ClientPropertyDetailImageGalleryState
    extends State<ClientPropertyDetailImageGallery> {
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

  void _goToPage(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.images.isEmpty) {
      return Container(
        height: widget.height,
        color: AppColors.grey.withValues(alpha: 0.2),
        child: Center(
          child: Icon(
            Icons.image,
            size: AppResponsive.scaleSize(context, 60, min: 40, max: 80),
            color: AppColors.primary,
          ),
        ),
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
          maxWidthDiskCache: 1200,
          maxHeightDiskCache: 800,
          memCacheWidth: 1200,
          memCacheHeight: 800,
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
                maxWidthDiskCache: 1200,
                maxHeightDiskCache: 800,
                memCacheWidth: 1200,
                memCacheHeight: 800,
              );
            },
          ),
        ),
        // Indicators
        if (widget.showIndicators && widget.images.length > 1)
          Positioned(
            bottom: AppResponsive.scaleSize(context, 20, min: 16, max: 24),
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
        // Navigation Arrows
        if (widget.images.length > 1) ...[
          Positioned(
            left: AppResponsive.scaleSize(context, 16, min: 12, max: 20),
            top: 0,
            bottom: 0,
            child: Center(
              child: _buildArrowButton(
                context,
                Icons.arrow_back_ios,
                _currentIndex > 0
                    ? () => _goToPage(_currentIndex - 1)
                    : () => _goToPage(widget.images.length - 1),
              ),
            ),
          ),
          Positioned(
            right: AppResponsive.scaleSize(context, 16, min: 12, max: 20),
            top: 0,
            bottom: 0,
            child: Center(
              child: _buildArrowButton(
                context,
                Icons.arrow_forward_ios,
                _currentIndex < widget.images.length - 1
                    ? () => _goToPage(_currentIndex + 1)
                    : () => _goToPage(0),
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildIndicator(BuildContext context, bool isActive) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: AppResponsive.scaleSize(context, 6, min: 4, max: 8),
      ),
      width: isActive
          ? AppResponsive.scaleSize(context, 32, min: 24, max: 40)
          : AppResponsive.scaleSize(context, 10, min: 8, max: 12),
      height: AppResponsive.scaleSize(context, 10, min: 8, max: 12),
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

  Widget _buildArrowButton(
    BuildContext context,
    IconData icon,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(
          AppResponsive.scaleSize(context, 12, min: 8, max: 16),
        ),
        decoration: BoxDecoration(
          color: AppColors.black.withValues(alpha: 0.5),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: AppColors.white,
          size: AppResponsive.scaleSize(context, 24, min: 20, max: 28),
        ),
      ),
    );
  }
}
