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
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyA7jErrP22dhr8U1kS2XRgSNrmdXBdKcKw',
    appId: '1:7311521816:web:8d3353a466fa5b4a392b6d',
    messagingSenderId: '7311521816',
    projectId: 'online-booking-b241b',
    authDomain: 'online-booking-b241b.firebaseapp.com',
    storageBucket: 'online-booking-b241b.appspot.com',
    measurementId: 'G-CV30RNQGJT',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCCCewrSKU1heeZpysd-xo7EDd-45L9aNg',
    appId: '1:7311521816:android:abf24cc78e28b6e8392b6d',
    messagingSenderId: '7311521816',
    projectId: 'online-booking-b241b',
    storageBucket: 'online-booking-b241b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDkEkVGYQ4pnj_04s9fBmkwrqCAY3oVCXU',
    appId: '1:7311521816:ios:68edbbf2ed39a121392b6d',
    messagingSenderId: '7311521816',
    projectId: 'online-booking-b241b',
    storageBucket: 'online-booking-b241b.appspot.com',
    androidClientId: '7311521816-g8ele8g64709hjfuec6tbtp126be6l3e.apps.googleusercontent.com',
    iosClientId: '7311521816-4gq45laap80kkhp0ftm11ha4o2cvo1jq.apps.googleusercontent.com',
    iosBundleId: 'com.example.onlinebookingAdminside',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDkEkVGYQ4pnj_04s9fBmkwrqCAY3oVCXU',
    appId: '1:7311521816:ios:68edbbf2ed39a121392b6d',
    messagingSenderId: '7311521816',
    projectId: 'online-booking-b241b',
    storageBucket: 'online-booking-b241b.appspot.com',
    androidClientId: '7311521816-g8ele8g64709hjfuec6tbtp126be6l3e.apps.googleusercontent.com',
    iosClientId: '7311521816-4gq45laap80kkhp0ftm11ha4o2cvo1jq.apps.googleusercontent.com',
    iosBundleId: 'com.example.onlinebookingAdminside',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyA7jErrP22dhr8U1kS2XRgSNrmdXBdKcKw',
    appId: '1:7311521816:web:8fd44027810c1b1f392b6d',
    messagingSenderId: '7311521816',
    projectId: 'online-booking-b241b',
    authDomain: 'online-booking-b241b.firebaseapp.com',
    storageBucket: 'online-booking-b241b.appspot.com',
    measurementId: 'G-FF6XCKM1KL',
  );
}
