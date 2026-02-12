import 'package:elegant_advisors/core/utils/app_fonts/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:elegant_advisors/core/constants/client_constants.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';
import 'package:elegant_advisors/core/utils/app_helpers/language/app_localizations_helper.dart';
import 'package:elegant_advisors/core/widgets/buttons/app_button.dart';
import 'package:elegant_advisors/domain/models/property_model.dart';
import 'package:elegant_advisors/presentation/client/widgets/properties/cards/client_property_card_spec_item.dart';
import 'package:elegant_advisors/presentation/client/controllers/properties/client_property_detail_controller.dart';

/// Property card info section (title, description, specs, button)
class ClientPropertyCardInfoSection extends StatelessWidget {
  final PropertyModel property;
  final VoidCallback? onTap;
  final bool isMobile;

  /// When true, show "Inquire" and navigate to contact with property id (off-market inquire-only).
  final bool isInquireOnly;

  const ClientPropertyCardInfoSection({
    super.key,
    required this.property,
    this.onTap,
    this.isMobile = false,
    this.isInquireOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    final hasSpecs =
        property.specs.bedrooms != null ||
        property.specs.bathrooms != null ||
        (property.specs.areaSize != null && property.specs.areaUnit != null);

    final description = property.fullDescription.isNotEmpty
        ? property.fullDescription
        : property.shortDescription;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Title
        Text(
          property.title,
          style: AppTextStyles.bodyText(context).copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
            fontFamily: AppFonts.primaryFont,
            fontSize: AppResponsive.fontSizeClamped(context, min: 26, max: 30),
          ),
          textAlign: TextAlign.left,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        AppSpacing.vertical(context, 0.02),
        // Description - limit length to prevent overflow
        if (description.isNotEmpty)
          Text(
            description,
            style: AppTextStyles.bodyText(context).copyWith(
              color: AppColors.black.withValues(alpha: 0.7),
              height: 1.6,
            ),
            textAlign: TextAlign.left,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        if (description.isNotEmpty) AppSpacing.vertical(context, 0.04),
        // Specs
        if (hasSpecs) ...[
          Wrap(
            spacing: AppResponsive.scaleSize(context, 16, min: 12, max: 20),
            runSpacing: AppResponsive.scaleSize(context, 12, min: 8, max: 16),
            children: [
              if (property.specs.bedrooms != null)
                ClientPropertyCardSpecItem(
                  icon: Iconsax.home,
                  text:
                      '${property.specs.bedrooms} ${context.l10n.clientPropertyCardBed}',
                ),
              if (property.specs.bathrooms != null)
                ClientPropertyCardSpecItem(
                  icon: Iconsax.level,
                  text:
                      '${property.specs.bathrooms} ${context.l10n.clientPropertyCardBath}',
                ),
              if (property.specs.areaSize != null &&
                  property.specs.areaUnit != null)
                ClientPropertyCardSpecItem(
                  icon: Iconsax.ruler,
                  text: '${property.specs.areaSize} ${property.specs.areaUnit}',
                ),
            ],
          ),
          AppSpacing.vertical(context, 0.02),
        ] else
          AppSpacing.vertical(context, 0.02),
        // Show More / Inquire Button (inquire-only for off-market)
        AppButton(
          text: isInquireOnly
              ? context.l10n.clientPropertyDetailInquire
              : context.l10n.clientPropertiesShowMore,
          backgroundColor: AppColors.primary,
          textColor: AppColors.white,
          width: isMobile ? double.infinity : null,
          onPressed:
              onTap ??
              (isInquireOnly
                  ? () {
                      if (property.id != null) {
                        Get.toNamed(
                          ClientConstants.routeClientContact,
                          arguments: property.id,
                        );
                      }
                    }
                  : () {
                      if (Get.isRegistered<ClientPropertyDetailController>()) {
                        Get.delete<ClientPropertyDetailController>(force: true);
                      }
                      Get.toNamed(
                        ClientConstants.routeClientPropertyDetail.replaceAll(
                          ':slug',
                          property.slug,
                        ),
                      );
                    }),
        ),
      ],
    );
  }
}
