import 'package:flutter/material.dart';
import 'package:elegant_advisors/core/utils/app_images/app_images.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/core/utils/app_helpers/language/app_localizations_helper.dart';
import 'package:elegant_advisors/core/widgets/display/app_service_card.dart';
import 'package:elegant_advisors/presentation/client/widgets/common/client_section_header.dart';

class HomeWhatWeSpecializeContentDesktop extends StatelessWidget {
  const HomeWhatWeSpecializeContentDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: AppResponsive.screenWidth(context) * 0.8,
          ),
          child: const _SpecializationHeader(),
        ),
        AppSpacing.vertical(context, 0.06),
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: AppResponsive.screenWidth(context) * 0.8,
          ),
          child: const _SpecializationServicesLayout(),
        ),
      ],
    );
  }
}

class HomeWhatWeSpecializeContentMobile extends StatelessWidget {
  const HomeWhatWeSpecializeContentMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const _SpecializationHeader(),
        AppSpacing.vertical(context, 0.06),
        const _SpecializationServicesLayout(),
      ],
    );
  }
}

class _SpecializationHeader extends StatelessWidget {
  const _SpecializationHeader();

  @override
  Widget build(BuildContext context) {
    return ClientSectionHeader(
      title: context.l10n.homeWhatWeSpecializeInTitle,
      tagline: context.l10n.homeWhatWeSpecializeInTagline,
      description: context.l10n.homeWhatWeSpecializeInDescription,
    );
  }
}

class _ServiceItem {
  final String imagePath;
  final String title;
  final String description;

  const _ServiceItem({
    required this.imagePath,
    required this.title,
    required this.description,
  });
}

List<_ServiceItem> _serviceItems(BuildContext context) {
  final l10n = context.l10n;
  return [
    _ServiceItem(
      imagePath: AppImages.serviceCapitalMarkets,
      title: l10n.homeWhatWeSpecializeInInvestmentCapitalMarketsTitle,
      description:
          l10n.homeWhatWeSpecializeInInvestmentCapitalMarketsDescription,
    ),
    _ServiceItem(
      imagePath: AppImages.serviceCommercialRealEstate,
      title: l10n.homeWhatWeSpecializeInCommercialRealEstateTitle,
      description: l10n.homeWhatWeSpecializeInCommercialRealEstateDescription,
    ),
    _ServiceItem(
      imagePath: AppImages.serviceInvestmentBuildings,
      title: l10n.homeWhatWeSpecializeInInvestmentBuildingsTitle,
      description: l10n.homeWhatWeSpecializeInInvestmentBuildingsDescription,
    ),
    _ServiceItem(
      imagePath: AppImages.serviceStrategicLand,
      title: l10n.homeWhatWeSpecializeInInvestmentPlotsTitle,
      description: l10n.homeWhatWeSpecializeInInvestmentPlotsDescription,
    ),
    _ServiceItem(
      imagePath: AppImages.serviceHospitalityInvestments,
      title: l10n.homeWhatWeSpecializeInHospitalityInvestmentsTitle,
      description: l10n.homeWhatWeSpecializeInHospitalityInvestmentsDescription,
    ),
    _ServiceItem(
      imagePath: AppImages.serviceLuxuryResidential,
      title: l10n.homeWhatWeSpecializeInHighEndResidentialTitle,
      description: l10n.homeWhatWeSpecializeInHighEndResidentialDescription,
    ),
  ];
}

class _SpecializationServicesLayout extends StatelessWidget {
  const _SpecializationServicesLayout();

  static const int _columnsWide = 3;

  @override
  Widget build(BuildContext context) {
    final services = _serviceItems(context);
    final isWide = AppResponsive.screenWidth(context) >= 768;

    if (isWide) {
      return Column(
        children: [
          for (var row = 0; row < services.length; row += _columnsWide) ...[
            if (row > 0) AppSpacing.vertical(context, 0.04),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var col = 0; col < _columnsWide; col++) ...[
                  if (col > 0) AppSpacing.horizontal(context, 0.03),
                  Expanded(
                    child: row + col < services.length
                        ? _serviceCard(services[row + col])
                        : const SizedBox.shrink(),
                  ),
                ],
              ],
            ),
          ],
        ],
      );
    }

    return Column(
      children: [
        for (var i = 0; i < services.length; i++) ...[
          if (i > 0) AppSpacing.vertical(context, 0.04),
          _serviceCard(services[i]),
        ],
      ],
    );
  }

  Widget _serviceCard(_ServiceItem item) {
    return AppServiceCard(
      imagePath: item.imagePath,
      title: item.title,
      description: item.description,
      maxDescriptionLines: 6,
    );
  }
}
