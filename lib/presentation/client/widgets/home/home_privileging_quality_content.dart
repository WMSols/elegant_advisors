import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:elegant_advisors/core/constants/client_constants.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_images/app_images.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';
import 'package:elegant_advisors/core/utils/app_helpers/language/app_localizations_helper.dart';
import 'package:elegant_advisors/core/widgets/buttons/app_button.dart';
import 'package:elegant_advisors/core/widgets/images/app_error_image_fallback.dart';

class HomePrivilegingQualityContentDesktop extends StatelessWidget {
  const HomePrivilegingQualityContentDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _QualityHeader(),
        AppSpacing.vertical(context, 0.06),
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: AppResponsive.screenWidth(context) * 0.55,
          ),
          child: _ImageCarouselWithGallery(),
        ),
        AppSpacing.vertical(context, 0.06),
        _QualityButton(),
      ],
    );
  }
}

class HomePrivilegingQualityContentMobile extends StatelessWidget {
  const HomePrivilegingQualityContentMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _QualityHeader(),
        AppSpacing.vertical(context, 0.06),
        _ImageCarouselWithGallery(),
        AppSpacing.vertical(context, 0.06),
        _QualityButton(fullWidth: true),
      ],
    );
  }
}

class _QualityHeader extends StatelessWidget {
  const _QualityHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          context.l10n.homePrivilegingQualityTitle,
          style: AppTextStyles.bodyText(context).copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
            fontSize: AppResponsive.fontSizeClamped(context, min: 26, max: 30),
          ),
          textAlign: TextAlign.center,
        ),
        AppSpacing.vertical(context, 0.02),
        Text(
          context.l10n.homePrivilegingQualitySubtitle,
          style: AppTextStyles.bodyText(context).copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
            fontSize: AppResponsive.fontSizeClamped(context, min: 18, max: 22),
          ),
          textAlign: TextAlign.center,
        ),
        AppSpacing.vertical(context, 0.02),
        Text(
          context.l10n.homePrivilegingQualityDescription,
          style: AppTextStyles.bodyText(context).copyWith(
            color: AppColors.grey,
            height: 1.6,
            fontSize: AppResponsive.fontSizeClamped(context, min: 10, max: 14),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _ImageCarousel extends StatelessWidget {
  final PageController pageController;
  final Function(int) onImageChanged;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  const _ImageCarousel({
    required this.pageController,
    required this.onImageChanged,
    required this.onPrevious,
    required this.onNext,
  });

  static const List<String> _images = [
    AppImages.homePrivilegingQuality1,
    AppImages.homePrivilegingQuality2,
    AppImages.homePrivilegingQuality3,
    AppImages.homePrivilegingQuality4,
    AppImages.homePrivilegingQuality5,
    AppImages.homePrivilegingQuality6,
    AppImages.homePrivilegingQuality7,
    AppImages.homePrivilegingQuality8,
    AppImages.homePrivilegingQuality9,
    AppImages.homePrivilegingQuality10,
  ];

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 768;
    final carouselHeight = isSmallScreen
        ? AppResponsive.screenHeight(context) * 0.4
        : AppResponsive.screenHeight(context) * 0.8;
    final arrowSize = AppResponsive.fontSizeClamped(context, min: 16, max: 20);
    final arrowButtonSize = AppResponsive.fontSizeClamped(
      context,
      min: 32,
      max: 40,
    );
    final arrowPadding = AppResponsive.screenWidth(context) * 0.02;
    final iconSize = AppResponsive.fontSizeClamped(context, min: 60, max: 80);

    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: carouselHeight,
          decoration: BoxDecoration(
            color: AppColors.grey.withValues(alpha: 0.1),
          ),
          child: ClipRRect(
            child: PageView.builder(
              controller: pageController,
              onPageChanged: onImageChanged,
              itemCount: _images.length,
              itemBuilder: (context, index) {
                return SizedBox.expand(
                  child: Image.asset(
                    _images[index],
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    frameBuilder:
                        (context, child, frame, wasSynchronouslyLoaded) {
                          if (wasSynchronouslyLoaded) {
                            return child;
                          }
                          return frame != null
                              ? child
                              : AppErrorImageFallback(iconSize: iconSize);
                        },
                    errorBuilder: (context, error, stackTrace) {
                      return AppErrorImageFallback(iconSize: iconSize);
                    },
                  ),
                );
              },
            ),
          ),
        ),
        // Left Arrow
        Positioned(
          left: arrowPadding,
          top: 0,
          bottom: 0,
          child: Center(
            child: _CarouselArrow(
              icon: Iconsax.arrow_left_2,
              onTap: onPrevious,
              size: arrowButtonSize,
              iconSize: arrowSize,
            ),
          ),
        ),
        // Right Arrow
        Positioned(
          right: arrowPadding,
          top: 0,
          bottom: 0,
          child: Center(
            child: _CarouselArrow(
              icon: Iconsax.arrow_right_2,
              onTap: onNext,
              size: arrowButtonSize,
              iconSize: arrowSize,
            ),
          ),
        ),
      ],
    );
  }
}

class _ImageCarouselWithGallery extends StatefulWidget {
  const _ImageCarouselWithGallery();

  @override
  State<_ImageCarouselWithGallery> createState() =>
      _ImageCarouselWithGalleryState();
}

class _ImageCarouselWithGalleryState extends State<_ImageCarouselWithGallery> {
  late final PageController _pageController;
  int _currentImageIndex = 0;

  static const List<String> _allImages = [
    AppImages.homePrivilegingQuality1,
    AppImages.homePrivilegingQuality2,
    AppImages.homePrivilegingQuality3,
    AppImages.homePrivilegingQuality4,
    AppImages.homePrivilegingQuality5,
    AppImages.homePrivilegingQuality6,
    AppImages.homePrivilegingQuality7,
    AppImages.homePrivilegingQuality8,
    AppImages.homePrivilegingQuality9,
    AppImages.homePrivilegingQuality10,
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _previousImage() {
    if (_currentImageIndex > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _pageController.jumpToPage(_allImages.length - 1);
    }
  }

  void _nextImage() {
    if (_currentImageIndex < _allImages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _pageController.jumpToPage(0);
    }
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
    return Column(
      children: [
        _ImageCarousel(
          pageController: _pageController,
          onImageChanged: (index) {
            setState(() {
              _currentImageIndex = index;
            });
          },
          onPrevious: _previousImage,
          onNext: _nextImage,
        ),
        AppSpacing.vertical(context, 0.02),
        _ThumbnailGallery(
          images: _allImages,
          currentIndex: _currentImageIndex,
          onThumbnailTap: _goToPage,
        ),
      ],
    );
  }
}

class _ThumbnailGallery extends StatelessWidget {
  final List<String> images;
  final int currentIndex;
  final Function(int) onThumbnailTap;

  const _ThumbnailGallery({
    required this.images,
    required this.currentIndex,
    required this.onThumbnailTap,
  });

  @override
  Widget build(BuildContext context) {
    final thumbnailSpacing = AppResponsive.screenWidth(context) * 0.005;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          images.length,
          (index) => Padding(
            padding: EdgeInsets.only(
              right: index < images.length - 1 ? thumbnailSpacing : 0,
            ),
            child: _ThumbnailItem(
              imagePath: images[index],
              isSelected: index == currentIndex,
              onTap: () => onThumbnailTap(index),
            ),
          ),
        ),
      ),
    );
  }
}

class _ThumbnailItem extends StatefulWidget {
  final String imagePath;
  final bool isSelected;
  final VoidCallback onTap;

  const _ThumbnailItem({
    required this.imagePath,
    this.isSelected = false,
    required this.onTap,
  });

  @override
  State<_ThumbnailItem> createState() => _ThumbnailItemState();
}

class _ThumbnailItemState extends State<_ThumbnailItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 768;
    final thumbnailSize = isSmallScreen
        ? AppResponsive.screenWidth(context) * 0.12
        : AppResponsive.screenWidth(context) * 0.05;
    final thumbnailIconSize = AppResponsive.fontSizeClamped(
      context,
      min: 20,
      max: 30,
    );
    final scale = _isHovered ? 1.1 : 1.0;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedScale(
          scale: scale,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          child: Container(
            width: thumbnailSize,
            height: thumbnailSize,
            decoration: BoxDecoration(
              color: AppColors.grey.withValues(alpha: 0.1),
              border: widget.isSelected
                  ? Border.all(color: AppColors.primary, width: 1)
                  : null,
            ),
            child: ClipRRect(
              child: SizedBox(
                width: thumbnailSize,
                height: thumbnailSize,
                child: Image.asset(
                  widget.imagePath,
                  fit: BoxFit.cover,
                  width: thumbnailSize,
                  height: thumbnailSize,
                  frameBuilder:
                      (context, child, frame, wasSynchronouslyLoaded) {
                        if (wasSynchronouslyLoaded) {
                          return child;
                        }
                        return frame != null
                            ? child
                            : AppErrorImageFallback(
                                iconSize: thumbnailIconSize,
                              );
                      },
                  errorBuilder: (context, error, stackTrace) {
                    return AppErrorImageFallback(iconSize: thumbnailIconSize);
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _QualityButton extends StatelessWidget {
  final bool fullWidth;

  const _QualityButton({this.fullWidth = false});

  @override
  Widget build(BuildContext context) {
    return AppButton(
      text: context.l10n.homePrivilegingQualityButton,
      backgroundColor: AppColors.primary,
      textColor: AppColors.white,
      width: fullWidth ? double.infinity : null,
      onPressed: () => Get.toNamed(ClientConstants.routeClientContact),
    );
  }
}

class _CarouselArrow extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final double size;
  final double iconSize;

  const _CarouselArrow({
    required this.icon,
    required this.onTap,
    required this.size,
    required this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: AppColors.white.withValues(alpha: 0.8),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: AppColors.primary, size: iconSize),
        ),
      ),
    );
  }
}
