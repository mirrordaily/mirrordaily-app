import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions are not supported for web.',
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
    apiKey: 'AIzaSyAsDKEs4QV31k5RWRc-9cabnmrieDHfpnc',
    appId: '1:947729274065:android:e30b5fed51d0c65c20e1f0',
    messagingSenderId: '947729274065',
    projectId: 'mirrordaily-prod',
    storageBucket: 'mirrordaily-prod.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCI0cozlpHQuzDQc_tmTEFgsoxGhvjDzGk',
    appId: '1:947729274065:ios:18f193e7fdb6733020e1f0',
    messagingSenderId: '947729274065',
    projectId: 'mirrordaily-prod',
    storageBucket: 'mirrordaily-prod.firebasestorage.app',
    iosBundleId: 'com.mirrormedia.mirrordaily',
  );

}