import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:elegant_advisors/core/app/app_initializer.dart';
import 'package:elegant_advisors/core/app/ea_app.dart';
import 'package:elegant_advisors/core/app/app_type.dart';

/// Main entry point for the unified Elegant Advisors application
///
/// This runs both client and admin routes together.
/// For isolated apps, use:
/// - `main_client.dart` for client-only app
/// - `main_admin.dart` for admin-only app
void main() async {
  // Set URL strategy to remove hash from URLs
  setUrlStrategy(PathUrlStrategy());

  await AppInitializer.initialize();
  runApp(const EAApp(appType: AppType.admin));
}
