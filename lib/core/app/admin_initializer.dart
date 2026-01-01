import 'package:flutter/material.dart';
import '../config/firebase_config.dart';

/// Admin application initializer
/// Handles all initialization logic for the admin app
class AdminInitializer {
  /// Initialize the admin application
  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    await FirebaseConfig.initialize();
  }
}
