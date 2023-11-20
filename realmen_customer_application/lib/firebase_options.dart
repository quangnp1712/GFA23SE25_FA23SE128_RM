// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyAWUQOUmyG5WIpLFc0lzmlmmdm4LANmQIk',
    appId: '1:557539940447:web:2d151159bc1551b91ea3ea',
    messagingSenderId: '557539940447',
    projectId: 'realmen-2023',
    authDomain: 'realmen-2023.firebaseapp.com',
    databaseURL: 'https://realmen-2023-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'realmen-2023.appspot.com',
    measurementId: 'G-7M4RJ8FDJJ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA0-Ozhc5UuiFEYFpnmR9hFTAIGxEUJzvA',
    appId: '1:557539940447:android:e90663ca165b67cc1ea3ea',
    messagingSenderId: '557539940447',
    projectId: 'realmen-2023',
    databaseURL: 'https://realmen-2023-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'realmen-2023.appspot.com',
  );
}
