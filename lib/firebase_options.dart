import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError('Windows not supported yet');
      default:
        throw UnsupportedError('Unsupported platform');
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAmIOAUqz12gG8Z3C-uVQk7NPXFDQirt2Y',
    authDomain: 'union-shop-825b3.firebaseapp.com',
    projectId: 'union-shop-825b3',
    storageBucket: 'union-shop-825b3.firebasestorage.app',
    messagingSenderId: '1051074814746',
    appId: '1:1051074814746:web:d410760faa5dbef50942a3',
  );

  // Placeholder for future mobile support
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAmIOAUqz12gG8Z3C-uVQk7NPXFDQirt2Y',
    appId: '1:1051074814746:android:YOUR_ANDROID_APP_ID',
    messagingSenderId: '1051074814746',
    projectId: 'union-shop-825b3',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAmIOAUqz12gG8Z3C-uVQk7NPXFDQirt2Y',
    appId: '1:1051074814746:ios:YOUR_IOS_APP_ID',
    messagingSenderId: '1051074814746',
    projectId: 'union-shop-825b3',
    iosBundleId: 'com.example.unionShop',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAmIOAUqz12gG8Z3C-uVQk7NPXFDQirt2Y',
    appId: '1:1051074814746:macos:YOUR_MACOS_APP_ID',
    messagingSenderId: '1051074814746',
    projectId: 'union-shop-825b3',
    iosBundleId: 'com.example.unionShop',
  );
}