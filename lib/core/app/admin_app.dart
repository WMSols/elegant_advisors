import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:elegant_advisors/core/theme/app_theme.dart';
import 'package:elegant_advisors/core/constants/admin_constants.dart';
import 'package:elegant_advisors/presentation/admin/routes/admin_routes.dart';

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
      getPages: AdminRoutes.routes,
    );
  }
}
