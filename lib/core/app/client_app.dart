import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../theme/app_theme.dart';
import '../constants/client_constants.dart';
import '../../presentation/client/routes/app_routes.dart';

/// Client-facing application
class ClientApp extends StatelessWidget {
  const ClientApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Elegant Advisors',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      initialRoute: ClientConstants.routeHome,
      getPages: AppRoutes.routes,
    );
  }
}
