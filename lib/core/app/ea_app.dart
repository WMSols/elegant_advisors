import 'package:flutter/material.dart';
import 'app_type.dart';
import 'client_app.dart';
import 'admin_app.dart';

/// Elegant Real Estate unified application
/// Can switch between client, admin, or unified mode
class EAApp extends StatelessWidget {
  final AppType appType;

  const EAApp({super.key, this.appType = AppType.unified});

  @override
  Widget build(BuildContext context) {
    switch (appType) {
      case AppType.client:
        return const ClientApp();
      case AppType.admin:
        return const AdminApp();
      case AppType.unified:
        // For unified mode, you can return a combined app or default to client
        // This can be extended later to support both routes together
        return const ClientApp();
    }
  }
}
