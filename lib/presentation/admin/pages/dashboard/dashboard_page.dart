import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/utils/app_colors/app_colors.dart';
import 'dashboard_controller.dart';

class DashboardPage extends GetView<DashboardController> {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: controller.logout,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dashboard Overview',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 24),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 2,
                children: [
                  _StatCard(
                    title: 'Today\'s Visitors',
                    value: controller.todayVisitors.value.toString(),
                    icon: Icons.people,
                  ),
                  _StatCard(
                    title: 'Yesterday\'s Visitors',
                    value: controller.yesterdayVisitors.value.toString(),
                    icon: Icons.people_outline,
                  ),
                  _StatCard(
                    title: 'Total Properties',
                    value: controller.propertiesCount.value.toString(),
                    icon: Icons.home,
                  ),
                  _StatCard(
                    title: 'Published Properties',
                    value: controller.publishedPropertiesCount.value.toString(),
                    icon: Icons.home_work,
                  ),
                  _StatCard(
                    title: 'Team Members',
                    value: controller.teamCount.value.toString(),
                    icon: Icons.group,
                  ),
                  _StatCard(
                    title: 'New Inquiries',
                    value: controller.newInquiriesCount.value.toString(),
                    icon: Icons.mail,
                    color: AppColors.warning,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color? color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color ?? AppColors.primary),
            const SizedBox(height: 8),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    color: color ?? AppColors.primary,
                  ),
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
