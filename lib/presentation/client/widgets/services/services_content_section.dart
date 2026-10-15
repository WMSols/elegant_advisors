import 'package:flutter/material.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/core/utils/app_styles/app_text_styles.dart';
import 'package:elegant_advisors/core/utils/app_helpers/language/app_localizations_helper.dart';
import 'package:elegant_advisors/core/widgets/text/app_text.dart';
import 'package:elegant_advisors/presentation/client/widgets/common/client_background_section.dart';
import 'package:elegant_advisors/presentation/client/widgets/common/client_content_container.dart';
import 'package:elegant_advisors/presentation/client/widgets/common/client_section_header.dart';

class ServicesContentSection extends StatelessWidget {
  const ServicesContentSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ClientBackgroundSection(
      horizontalPadding: 0.04,
      verticalPadding: 0.1,
      child: ClientContentContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Space for header overlay
            AppSpacing.vertical(context, 0.06),
            ClientSectionHeader(
              title: context.l10n.homeOurServicesTitle,
              tagline: context.l10n.homeOurServicesTagline,
            ),
            AppSpacing.vertical(context, 0.06),
            _ServicesGrid(),
          ],
        ),
      ),
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

class _ServicesGrid extends StatelessWidget {
  static const int _columnsWide = 3;

  @override
  Widget build(BuildContext context) {
    final services = _advisoryServices(context);
    final isWide = AppResponsive.screenWidth(context) >= 768;

    if (isWide) {
      return LayoutBuilder(
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
                  child: _ServiceCard(item: item),
                ),
            ],
          );
        },
      );
    }

    return Column(
      children: [
        for (var i = 0; i < services.length; i++) ...[
          if (i > 0) AppSpacing.vertical(context, 0.025),
          _ServiceCard(item: services[i]),
        ],
      ],
    );
  }
}

class _ServiceCard extends StatefulWidget {
  final _AdvisoryServiceItem item;

  const _ServiceCard({required this.item});

  @override
  State<_ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<_ServiceCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
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
            border: Border.all(
              color: _isHovered
                  ? AppColors.white
                  : AppColors.white.withValues(alpha: 0.18),
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: AppColors.white.withValues(alpha: 0.08),
                      blurRadius: 20,
                      spreadRadius: 2,
                    ),
                  ]
                : [],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppText(
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
              AppText(
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
