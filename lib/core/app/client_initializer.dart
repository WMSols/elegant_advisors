import 'package:flutter/material.dart';
import 'package:elegant_advisors/core/config/firebase_config.dart';
import 'package:google_fonts/google_fonts.dart';

/// Client application initializer
/// Handles all initialization logic for the client app
class ClientInitializer {
  /// Initialize the client application
  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();

    // Preload Playfair Display so button/layout widths are correct on first paint.
    GoogleFonts.playfairDisplay();
    GoogleFonts.playfairDisplay(fontWeight: FontWeight.w500);
    GoogleFonts.playfairDisplay(fontWeight: FontWeight.w600);
    GoogleFonts.playfairDisplay(fontStyle: FontStyle.italic);
    await GoogleFonts.pendingFonts();

    await FirebaseConfig.initialize();
  }
}
