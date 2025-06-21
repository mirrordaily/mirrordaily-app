// lib/firebase/firebase_initializer.dart

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import '../firebase_options_dev.dart' as dev;
import '../firebase_options_prod.dart' as prod;

enum AppFlavor { dev, prod }

class FirebaseInitializer {
  static Future<void> initialize(AppFlavor flavor) async {
    FirebaseOptions options;

    switch (flavor) {
      case AppFlavor.dev:
        options = dev.DefaultFirebaseOptions.currentPlatform;
        break;
      case AppFlavor.prod:
        options = prod.DefaultFirebaseOptions.currentPlatform;
        break;
    }

    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(options: options);
    } else {
      // debugPrint('⚠️ Firebase already initialized.');
    }
  }
}
