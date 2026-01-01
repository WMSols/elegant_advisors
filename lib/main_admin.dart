import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'core/app/admin_initializer.dart';
import 'core/app/admin_app.dart';

void main() async {
  // Set URL strategy to remove hash from URLs
  setUrlStrategy(PathUrlStrategy());
  
  await AdminInitializer.initialize();
  runApp(const AdminApp());
}
