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
        return macos;
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
    apiKey: 'AIzaSyC8huDUyI9IXtcLJBtZmBnE8qH2QMA3Nes',
    appId: '1:375648482396:web:a2b7b3a85e28290bc12299',
    messagingSenderId: '375648482396',
    projectId: 'gym-training-a8f19',
    authDomain: 'gym-training-a8f19.firebaseapp.com',
    storageBucket: 'gym-training-a8f19.appspot.com',
    measurementId: 'G-PNDBRZK0KC',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAOZl0NuPBPbsIo2f-e04Hwofu4212FnAo',
    appId: '1:375648482396:android:5c3ac2405f870fc6c12299',
    messagingSenderId: '375648482396',
    projectId: 'gym-training-a8f19',
    storageBucket: 'gym-training-a8f19.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyASlCZooKe53OOcBrePxmFgcBYlRc1Al8I',
    appId: '1:375648482396:ios:16b16a33a68a2cc1c12299',
    messagingSenderId: '375648482396',
    projectId: 'gym-training-a8f19',
    storageBucket: 'gym-training-a8f19.appspot.com',
    iosClientId:
        '375648482396-mlo7nkjo54f06dvepb0vj68g2klebg67.apps.googleusercontent.com',
    iosBundleId: 'com.example.gymTraining',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyASlCZooKe53OOcBrePxmFgcBYlRc1Al8I',
    appId: '1:375648482396:ios:5dc97ab349d95dfcc12299',
    messagingSenderId: '375648482396',
    projectId: 'gym-training-a8f19',
    storageBucket: 'gym-training-a8f19.appspot.com',
    iosClientId:
        '375648482396-2leun0osf56p1f6h01r6l9n0a6lvprdd.apps.googleusercontent.com',
    iosBundleId: 'com.example.gymTraining.RunnerTests',
  );
}
