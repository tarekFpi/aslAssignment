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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB4YGBCwzjUEbMSwDQDDmV8bWbvTLm3KHE',
    appId: '1:1096995679193:android:c7648d84e952c887bf07c8',
    messagingSenderId: '1096995679193',
    projectId: 'userlist-3fe50',
    databaseURL: 'https://userlist-3fe50-default-rtdb.firebaseio.com',
    storageBucket: 'userlist-3fe50.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAy2JxsyCQkPE6W1j68IoKg9c8TvTVOxAE',
    appId: '1:1096995679193:ios:6fa08ccfff80b5bebf07c8',
    messagingSenderId: '1096995679193',
    projectId: 'userlist-3fe50',
    databaseURL: 'https://userlist-3fe50-default-rtdb.firebaseio.com',
    storageBucket: 'userlist-3fe50.firebasestorage.app',
    iosBundleId: 'com.example.assignmentAsl',
  );
}
