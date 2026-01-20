import 'package:flutter/material.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/domain/models/property_model.dart';
import 'package:elegant_advisors/presentation/client/widgets/properties/cards/client_property_card_image_section.dart';
import 'package:elegant_advisors/presentation/client/widgets/properties/cards/client_property_card_info_section.dart';

/// Client-side property card widget with alternating image/info layout
class ClientPropertyCard extends StatefulWidget {
  final PropertyModel property;
  final VoidCallback? onTap;
  final int? index; // Used to determine alternating layout
  final bool
  isRelatedProperty; // When true, shows image gallery on top and info below
  final double?
  fixedHeight; // Fixed height for related property cards on desktop

  const ClientPropertyCard({
    super.key,
    required this.property,
    this.onTap,
    this.index,
    this.isRelatedProperty = false,
    this.fixedHeight,
  });

  @override
  State<ClientPropertyCard> createState() => _ClientPropertyCardState();
}

class _ClientPropertyCardState extends State<ClientPropertyCard> {
  // Beige background color matching the screenshot
  static const Color _beigeBackground = Color(0XFFe3dfd6);
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    // If it's a related property, always use vertical layout (image on top)
    if (widget.isRelatedProperty) {
      return MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: AnimatedScale(
          scale: _isHovered ? 1.02 : 1.0,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            decoration: BoxDecoration(
              color: _beigeBackground,
              borderRadius: BorderRadius.circular(
                AppResponsive.radius(context, factor: 1.5),
              ),
              border: Border.all(
                color: _isHovered ? AppColors.primary : Colors.transparent,
              ),
              boxShadow: _isHovered
                  ? [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.2),
                        blurRadius: 20,
                        spreadRadius: 2,
                        offset: const Offset(0, 0),
                      ),
                    ]
                  : null,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                AppResponsive.radius(context, factor: 1.5),
              ),
              child: _buildRelatedPropertyLayout(context),
            ),
          ),
        ),
      );
    }

    // Determine if image should be on left (even index) or right (odd index)
    final isImageOnLeft = (widget.index ?? 0) % 2 == 0;

    // Check if mobile view
    final isMobile = AppResponsive.isMobile(context);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        scale: _isHovered ? 1.02 : 1.0,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            color: _beigeBackground,
            borderRadius: BorderRadius.circular(
              AppResponsive.radius(context, factor: 1.5),
            ),
            border: Border.all(
              color: _isHovered ? AppColors.primary : Colors.transparent,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.2),
                      blurRadius: 20,
                      spreadRadius: 2,
                      offset: const Offset(0, 0),
                    ),
                  ]
                : null,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(
              AppResponsive.radius(context, factor: 1.5),
            ),
            child: isMobile
                ? _buildMobileLayout(context)
                : _buildDesktopLayout(context, isImageOnLeft),
          ),
        ),
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildImageGallery(context),
        AppSpacing.vertical(context, 0.04),
        Padding(
          padding: AppSpacing.symmetric(context, h: 0.04, v: 0.02),
          child: _buildPropertyInfo(context, isMobile: true),
        ),
      ],
    );
  }

  Widget _buildDesktopLayout(BuildContext context, bool isImageOnLeft) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isImageOnLeft) ...[
          Expanded(flex: 6, child: _buildImageGallery(context)),
          AppSpacing.horizontal(context, 0.04),
          Expanded(
            flex: 4,
            child: Padding(
              padding: AppSpacing.symmetric(context, h: 0.04, v: 0.06),
              child: _buildPropertyInfo(context),
            ),
          ),
        ] else ...[
          Expanded(
            flex: 4,
            child: Padding(
              padding: AppSpacing.symmetric(context, h: 0.04, v: 0.06),
              child: _buildPropertyInfo(context),
            ),
          ),
          AppSpacing.horizontal(context, 0.04),
          Expanded(flex: 6, child: _buildImageGallery(context)),
        ],
      ],
    );
  }

  Widget _buildImageGallery(BuildContext context) {
    return ClientPropertyCardImageSection(property: widget.property);
  }

  Widget _buildPropertyInfo(BuildContext context, {bool isMobile = false}) {
    return ClientPropertyCardInfoSection(
      property: widget.property,
      onTap: widget.onTap,
      isMobile: isMobile,
    );
  }

  Widget _buildRelatedPropertyLayout(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Use fixed height if provided (for desktop horizontal scroll), otherwise use constraints
        final availableHeight =
            widget.fixedHeight ??
            (constraints.maxHeight.isFinite && constraints.maxHeight > 0
                ? constraints.maxHeight
                : AppResponsive.screenHeight(context) * 0.5);

        // Use 40% for image, rest for info section
        final imageHeight = availableHeight * 0.5;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              height: imageHeight,
              width: double.infinity,
              child: ClientPropertyCardImageSection(
                property: widget.property,
                fixedHeight: imageHeight,
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Padding(
                  padding: AppSpacing.symmetric(context, h: 0.04, v: 0.02),
                  child: _buildPropertyInfo(context, isMobile: true),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
