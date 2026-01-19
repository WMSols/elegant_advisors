import 'package:flutter/material.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/core/utils/app_spacing/app_spacing.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/presentation/client/widgets/footer/footer_company_info.dart';
import 'package:elegant_advisors/presentation/client/widgets/footer/footer_quick_links.dart';
import 'package:elegant_advisors/presentation/client/widgets/footer/footer_contact_info.dart';
import 'package:elegant_advisors/presentation/client/widgets/footer/footer_social_media.dart';
import 'package:elegant_advisors/presentation/client/widgets/footer/footer_copyright.dart';

class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = AppResponsive.isMobile(context);
    final isTablet = AppResponsive.isTablet(context);

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(color: AppColors.primary),
      child: Column(
        children: [
          // Main Footer Content
          Padding(
            padding: AppSpacing.symmetric(context, h: 0.04, v: 0.04),
            child: isMobile
                ? _buildMobileLayout(context)
                : isTablet
                ? _buildTabletLayout(context)
                : _buildDesktopLayout(context),
          ),
          // Copyright Bar
          const FooterCopyright(),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FooterCompanyInfo(),
        AppSpacing.vertical(context, 0.03),
        const FooterQuickLinks(),
        AppSpacing.vertical(context, 0.03),
        const FooterContactInfo(),
        AppSpacing.vertical(context, 0.03),
        const FooterSocialMedia(),
      ],
    );
  }

  Widget _buildTabletLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const FooterCompanyInfo(),
              AppSpacing.vertical(context, 0.02),
              const FooterSocialMedia(),
            ],
          ),
        ),
        AppSpacing.horizontal(context, 0.03),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const FooterQuickLinks(),
              AppSpacing.vertical(context, 0.02),
              const FooterContactInfo(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Company Info Column
        const Expanded(flex: 3, child: FooterCompanyInfo()),
        AppSpacing.horizontal(context, 0.02),
        // Quick Links Column
        const Expanded(flex: 2, child: FooterQuickLinks()),
        AppSpacing.horizontal(context, 0.02),
        // Contact Column
        const Expanded(flex: 2, child: FooterContactInfo()),
        AppSpacing.horizontal(context, 0.02),
        // Social Media Column
        const Expanded(flex: 2, child: FooterSocialMedia()),
      ],
    );
  }
}
