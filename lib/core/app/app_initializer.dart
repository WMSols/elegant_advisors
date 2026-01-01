import 'package:flutter/material.dart';
import '../config/firebase_config.dart';

/// Unified application initializer
/// Handles initialization logic for the unified app
class AppInitializer {
  /// Initialize the application
  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    await FirebaseConfig.initialize();
  }
}
