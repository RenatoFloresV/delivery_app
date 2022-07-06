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
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAHiXE2a0v1wBB2V_0sEO6aoaBoBLQTRtU',
    appId: '1:423372987319:web:645e650d07f1dd98e3a632',
    messagingSenderId: '423372987319',
    projectId: 'myfirtsstore',
    authDomain: 'myfirtsstore.firebaseapp.com',
    databaseURL: 'https://myfirtsstore-default-rtdb.firebaseio.com',
    storageBucket: 'myfirtsstore.appspot.com',
    measurementId: 'G-8ZVWH9FQH2',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAjGnNUXVXX4aZxMSl0wsaY23yBC3Dypfs',
    appId: '1:423372987319:android:d0b13f33eeeef981e3a632',
    messagingSenderId: '423372987319',
    projectId: 'myfirtsstore',
    databaseURL: 'https://myfirtsstore-default-rtdb.firebaseio.com',
    storageBucket: 'myfirtsstore.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB0NKUf9s6XEk7rEEwfawzfTNDgH0SLwrk',
    appId: '1:423372987319:ios:b248915d4c56da11e3a632',
    messagingSenderId: '423372987319',
    projectId: 'myfirtsstore',
    databaseURL: 'https://myfirtsstore-default-rtdb.firebaseio.com',
    storageBucket: 'myfirtsstore.appspot.com',
    iosClientId: '423372987319-4n699bvrsn19j2kgt7ijecoviadft2fi.apps.googleusercontent.com',
    iosBundleId: 'myapp',
  );
}
