// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAvgtIPrxWUa5zI97Py-rOoBVw1uIWEM4g',
    appId: '1:352568696422:web:e763272bc0874a8d22d7a7',
    messagingSenderId: '352568696422',
    projectId: 'abl-dev',
    authDomain: 'abl-dev.firebaseapp.com',
    storageBucket: 'abl-dev.firebasestorage.app',
    measurementId: 'G-4PCY1C1Q0M',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCqDNV0qAADa21rESaSQE3nLSiYNnAD3wQ',
    appId: '1:352568696422:android:2bbffd234f316f7022d7a7',
    messagingSenderId: '352568696422',
    projectId: 'abl-dev',
    storageBucket: 'abl-dev.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAJjn7t4lDjsz8hoRnpBe3nKjMLH92Dwh4',
    appId: '1:352568696422:ios:64424de7efd12b8a22d7a7',
    messagingSenderId: '352568696422',
    projectId: 'abl-dev',
    storageBucket: 'abl-dev.firebasestorage.app',
    iosBundleId: 'com.abl.abl.ablv2',
  );
}
