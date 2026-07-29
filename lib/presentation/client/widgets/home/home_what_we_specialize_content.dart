import 'package:flutter/material.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_images/app_images.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';
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
        AppSpacing.vertical(context, 0.08),
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: AppResponsive.screenWidth(context) * 0.8,
          ),
          child: const _OurServicesSubsection(),
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
        AppSpacing.vertical(context, 0.08),
        const _OurServicesSubsection(),
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

class _AdvisoryServiceItem {
  final String title;
  final String description;

  const _AdvisoryServiceItem({required this.title, required this.description});
}

List<_AdvisoryServiceItem> _advisoryServices(BuildContext context) {
  final l10n = context.l10n;
  return [
    _AdvisoryServiceItem(
      title: l10n.homeOurServicesOffMarketTitle,
      description: l10n.homeOurServicesOffMarketDescription,
    ),
    _AdvisoryServiceItem(
      title: l10n.homeOurServicesInvestmentTitle,
      description: l10n.homeOurServicesInvestmentDescription,
    ),
    _AdvisoryServiceItem(
      title: l10n.homeOurServicesTransactionTitle,
      description: l10n.homeOurServicesTransactionDescription,
    ),
    _AdvisoryServiceItem(
      title: l10n.homeOurServicesFinancialTitle,
      description: l10n.homeOurServicesFinancialDescription,
    ),
    _AdvisoryServiceItem(
      title: l10n.homeOurServicesMarketTitle,
      description: l10n.homeOurServicesMarketDescription,
    ),
    _AdvisoryServiceItem(
      title: l10n.homeOurServicesDevelopmentTitle,
      description: l10n.homeOurServicesDevelopmentDescription,
    ),
    _AdvisoryServiceItem(
      title: l10n.homeOurServicesPrivateClientTitle,
      description: l10n.homeOurServicesPrivateClientDescription,
    ),
  ];
}

class _OurServicesSubsection extends StatelessWidget {
  const _OurServicesSubsection();

  static const int _columnsWide = 3;

  @override
  Widget build(BuildContext context) {
    final services = _advisoryServices(context);
    final isWide = AppResponsive.screenWidth(context) >= 768;

    return Column(
      children: [
        ClientSectionHeader(
          title: context.l10n.homeOurServicesTitle,
          tagline: context.l10n.homeOurServicesTagline,
        ),
        AppSpacing.vertical(context, 0.05),
        if (isWide)
          LayoutBuilder(
            builder: (context, constraints) {
              final gap = AppResponsive.screenWidth(context) * 0.025;
              final cardWidth =
                  (constraints.maxWidth - (gap * (_columnsWide - 1))) /
                  _columnsWide;
              return Wrap(
                spacing: gap,
                runSpacing: AppResponsive.screenHeight(context) * 0.03,
                alignment: WrapAlignment.center,
                children: [
                  for (final item in services)
                    SizedBox(
                      width: cardWidth,
                      child: _AdvisoryServiceCard(item: item),
                    ),
                ],
              );
            },
          )
        else
          Column(
            children: [
              for (var i = 0; i < services.length; i++) ...[
                if (i > 0) AppSpacing.vertical(context, 0.025),
                _AdvisoryServiceCard(item: services[i]),
              ],
            ],
          ),
      ],
    );
  }
}

class _AdvisoryServiceCard extends StatefulWidget {
  final _AdvisoryServiceItem item;

  const _AdvisoryServiceCard({required this.item});

  @override
  State<_AdvisoryServiceCard> createState() => _AdvisoryServiceCardState();
}

class _AdvisoryServiceCardState extends State<_AdvisoryServiceCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final radius = AppResponsive.propertyCardBorderRadius(context);
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
          width: double.infinity,
          padding: AppSpacing.symmetric(context, h: 0.02, v: 0.03),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: radius,
            border: Border.all(
              color: _isHovered
                  ? AppColors.white
                  : AppColors.primary.withValues(alpha: 0.12),
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.35),
                      blurRadius: 20,
                      spreadRadius: 2,
                      offset: Offset.zero,
                    ),
                  ]
                : [],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                widget.item.title,
                style: AppTextStyles.displayLabel(context).copyWith(
                  color: AppColors.white,
                  fontSize: AppResponsive.fontSizeClamped(
                    context,
                    min: 15,
                    max: 18,
                  ),
                ),
                textAlign: TextAlign.center,
              ),
              AppSpacing.vertical(context, 0.012),
              Text(
                widget.item.description,
                style: AppTextStyles.bodyText(context).copyWith(
                  color: AppColors.white.withValues(alpha: 0.85),
                  height: 1.5,
                  fontSize: AppResponsive.fontSizeClamped(
                    context,
                    min: 13,
                    max: 15,
                  ),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
