import 'package:elegant_advisors/core/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:elegant_advisors/core/theme/app_theme.dart';
import 'package:elegant_advisors/core/constants/client_constants.dart';
import 'package:elegant_advisors/core/utils/app_texts/app_texts.dart';
import 'package:elegant_advisors/presentation/admin/controllers/language/language_controller.dart';
import 'package:elegant_advisors/presentation/client/routes/client_routes.dart';

/// Client-facing application
class ClientApp extends StatelessWidget {
  const ClientApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize language controller
    final languageController = Get.put(LanguageController(), permanent: true);

    return GetMaterialApp(
      title: AppTexts.appTitleClient,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,

      // Localization support
      locale: languageController.currentLocale,
      supportedLocales: LanguageController.supportedLocales,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

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
        page: () => Builder(
          builder: (context) => Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(AppLocalizations.of(context)!.commonPageNotFound),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () =>
                        Get.offAllNamed(ClientConstants.routeClientHome),
                    child: Text(AppLocalizations.of(context)!.commonGoHome),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
