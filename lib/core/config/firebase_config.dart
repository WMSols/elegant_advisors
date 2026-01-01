import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class FirebaseConfig {
  static Future<void> initialize() async {
    if (kIsWeb) {
      // For web, Firebase options should be configured in index.html
      // or passed here if using FlutterFire CLI
      await Firebase.initializeApp(
        options: const FirebaseOptions(
          // These will be replaced with actual values from Firebase Console
          apiKey: "YOUR_API_KEY",
          authDomain: "YOUR_AUTH_DOMAIN",
          projectId: "YOUR_PROJECT_ID",
          storageBucket: "YOUR_STORAGE_BUCKET",
          messagingSenderId: "YOUR_MESSAGING_SENDER_ID",
          appId: "YOUR_APP_ID",
          measurementId: "YOUR_MEASUREMENT_ID",
        ),
      );
    } else {
      await Firebase.initializeApp();
    }
  }
}
