import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../theme/app_theme.dart';
import '../constants/admin_constants.dart';
import '../../presentation/admin/routes/app_routes.dart';

/// Admin/management application
class AdminApp extends StatelessWidget {
  const AdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Elegant Advisors - Admin',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      initialRoute: AdminConstants.routeLogin,
      getPages: AppRoutes.routes,
    );
  }
}
