import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/routes/app_routes.dart';
import 'core/theme/app_theme.dart';
import 'core/constants/app_constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Elegant Advisors',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      initialRoute: AppConstants.routeHome,
      getPages: AppRoutes.routes,
    );
  }
}
