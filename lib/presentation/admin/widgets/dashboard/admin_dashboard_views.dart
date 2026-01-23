import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:elegant_advisors/core/utils/app_texts/app_texts.dart';
import 'package:elegant_advisors/core/utils/app_responsive/app_responsive.dart';
import 'package:elegant_advisors/core/utils/app_colors/app_colors.dart';
import 'package:elegant_advisors/presentation/admin/controllers/dashboard/admin_dashboard_controller.dart';
import 'package:elegant_advisors/presentation/admin/widgets/layout/admin_layout.dart';
import 'package:elegant_advisors/presentation/admin/widgets/dashboard/cards/admin_dashboard_stat_card.dart';
import 'package:elegant_advisors/presentation/admin/widgets/dashboard/charts/admin_dashboard_pie_chart.dart';

/// Reusable dashboard views widget containing both mobile and desktop views
class AdminDashboardViews extends GetView<AdminDashboardController> {
  const AdminDashboardViews({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = AppResponsive.isMobile(context);

    return AdminLayout(
      title: AppTexts.adminDashboardTitle,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(
          AppResponsive.scaleSize(
            context,
            isMobile ? 16 : 24,
            min: 12,
            max: 32,
          ),
        ),
        child: Obx(
          () => isMobile
              ? _buildMobileContent(context)
              : _buildDesktopContent(context),
        ),
      ),
    );
  }

  /// Builds the list of stat cards (shared between desktop and mobile)
  List<Widget> _buildStatCards() {
    return [
      AdminDashboardStatCard(
        title: AppTexts.adminDashboardTotalVisitors,
        value: controller.totalVisitors.value.toString(),
        icon: Iconsax.user,
        color: AppColors.totalVisits,
      ),
      AdminDashboardStatCard(
        title: AppTexts.adminDashboardTotalPropertyVisits,
        value: controller.totalPropertyVisits.value.toString(),
        icon: Iconsax.eye,
        color: AppColors.propertyVisits,
      ),
      AdminDashboardStatCard(
        title: AppTexts.adminDashboardUniqueVisits,
        value: controller.totalUniqueVisits.value.toString(),
        icon: Iconsax.profile_2user,
        color: AppColors.uniqueVisits,
      ),
      AdminDashboardStatCard(
        title: AppTexts.adminDashboardTotalProperties,
        value: controller.propertiesCount.value.toString(),
        icon: Iconsax.buildings,
        color: AppColors.totalProperties,
      ),
      AdminDashboardStatCard(
        title: AppTexts.adminDashboardPublishedProperties,
        value: controller.publishedPropertiesCount.value.toString(),
        icon: Iconsax.building,
        color: AppColors.publishedProperties,
      ),
      AdminDashboardStatCard(
        title: AppTexts.adminDashboardTeamMembers,
        value: controller.teamCount.value.toString(),
        icon: Iconsax.people,
        color: AppColors.teamMembers,
      ),
      AdminDashboardStatCard(
        title: AppTexts.adminDashboardNewInquiries,
        value: controller.newInquiriesCount.value.toString(),
        icon: Iconsax.information,
        color: AppColors.newInquiries,
      ),
    ];
  }

  Widget _buildDesktopContent(BuildContext context) {
    final spacing = AppResponsive.scaleSize(context, 16, min: 12, max: 24);
    final childAspectRatio = 2.2;
    final statCards = _buildStatCards();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Stat Cards Grid - Adjust columns based on number of cards
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: spacing,
            mainAxisSpacing: spacing,
            childAspectRatio: childAspectRatio,
          ),
          itemCount: statCards.length,
          itemBuilder: (context, index) => statCards[index],
        ),
        SizedBox(height: spacing),
        // Pie Chart
        const AdminDashboardPieChart(),
      ],
    );
  }

  Widget _buildMobileContent(BuildContext context) {
    final spacing = AppResponsive.scaleSize(context, 12, min: 8, max: 16);
    final statCards = _buildStatCards();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Stat Cards
        for (int i = 0; i < statCards.length; i++) ...[
          statCards[i],
          if (i < statCards.length - 1) SizedBox(height: spacing),
        ],
        SizedBox(height: spacing),
        // Pie Chart
        const AdminDashboardPieChart(),
      ],
    );
  }
}
