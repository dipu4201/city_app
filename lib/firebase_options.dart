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
    apiKey: 'AIzaSyBNX4nGn5aHD60vyhmSLLBVuWGkuAphGno',
    appId: '1:848779875799:web:967f215869bc09782be792',
    messagingSenderId: '848779875799',
    projectId: 'rajshahi-5ecf5',
    authDomain: 'rajshahi-5ecf5.firebaseapp.com',
    storageBucket: 'rajshahi-5ecf5.firebasestorage.app',
    measurementId: 'G-2H4G74N4V5',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCF3CtB-nhX7JcZP5vR39i6kNMfplxrmLU',
    appId: '1:848779875799:android:60dcd4599bd24dfd2be792',
    messagingSenderId: '848779875799',
    projectId: 'rajshahi-5ecf5',
    storageBucket: 'rajshahi-5ecf5.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDXmvC6BB_5s5-Wh081Sp9Td6PQ6jUO4bU',
    appId: '1:848779875799:ios:1a545884c91eb74f2be792',
    messagingSenderId: '848779875799',
    projectId: 'rajshahi-5ecf5',
    storageBucket: 'rajshahi-5ecf5.firebasestorage.app',
    androidClientId: '848779875799-vg7l4che98mgl356hg3gjgg91i6snl14.apps.googleusercontent.com',
    iosClientId: '848779875799-t36p867gdtv9gnlig2grpck434e3n6ed.apps.googleusercontent.com',
    iosBundleId: 'com.example.rajshaiTown',
  );

}