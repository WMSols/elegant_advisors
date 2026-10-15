import 'package:flutter/material.dart';
import 'package:elegant_advisors/core/config/firebase_config.dart';

/// Client application initializer
/// Handles all initialization logic for the client app
class ClientInitializer {
  /// Initialize the client application
  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    await FirebaseConfig.initialize();
  }
}
