import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:elegant_advisors/core/theme/app_theme.dart';
import 'package:elegant_advisors/core/constants/client_constants.dart';
import 'package:elegant_advisors/presentation/client/routes/client_routes.dart';

/// Client-facing application
class ClientApp extends StatelessWidget {
  const ClientApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Elegant Advisors',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      initialRoute: ClientConstants.routeClientHome,
      getPages: ClientRoutes.routes,
      // Enable browser back/forward button support
      popGesture: true,
      defaultTransition: Transition.fadeIn,
      // Add GetObserver to properly handle browser navigation
      // GetObserver automatically handles browser back/forward buttons
      navigatorObservers: [GetObserver()],
      // Enable browser history support - GetX handles this automatically
      enableLog: false,
      // Ensure proper route management for web
      unknownRoute: GetPage(
        name: '/notfound',
        page: () => Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Page Not Found'),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () =>
                      Get.offAllNamed(ClientConstants.routeClientHome),
                  child: const Text('Go Home'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
