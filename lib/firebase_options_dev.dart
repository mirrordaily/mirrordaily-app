// lib/firebase_options_dev.dart

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'Web is not supported for this configuration.',
      );
    }

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAbeEuUFXxCMO3stN3gz6u254Y_2k3dqwE',
    appId: '1:471417058402:android:3162de6eb8e93698ba8d3b',
    messagingSenderId: '471417058402',
    projectId: 'mirrordaily-dev',
    storageBucket: 'mirrordaily-dev.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDkb5LQj2hnLiRuDx0s7weqV5J05kKqYHA',
    appId: '1:471417058402:ios:c15a00f0d0e2484bba8d3b',
    messagingSenderId: '471417058402',
    projectId: 'mirrordaily-dev',
    storageBucket: 'mirrordaily-dev.firebasestorage.app',
    iosBundleId: 'com.mirrormedia.mirrordaily.dev',
  );

}