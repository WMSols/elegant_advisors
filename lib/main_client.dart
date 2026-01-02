import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:elegant_advisors/core/app/client_initializer.dart';
import 'package:elegant_advisors/core/app/client_app.dart';

void main() async {
  // Set URL strategy to remove hash from URLs
  setUrlStrategy(PathUrlStrategy());

  await ClientInitializer.initialize();
  runApp(const ClientApp());
}
