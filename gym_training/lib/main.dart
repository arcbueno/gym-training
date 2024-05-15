import 'dart:io';
import 'dart:ui';

import 'package:alarm/alarm.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:gym_training/bindings.dart';
import 'package:gym_training/pages/splash/splash_page.dart';
// ignore: depend_on_referenced_packages
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Alarm.init();
  await Firebase.initializeApp(
    // Comment the name when running/building for Android
    // name: 'gym_training',
    options: FirebaseOptions(
      apiKey: const String.fromEnvironment('apiKey'),
      appId: Platform.isAndroid
          ? const String.fromEnvironment('androidAppId')
          : const String.fromEnvironment('iosAppId'),
      messagingSenderId: const String.fromEnvironment('messagingSenderId'),
      projectId: const String.fromEnvironment('projectId'),
      authDomain: const String.fromEnvironment('authDomain'),
      storageBucket: const String.fromEnvironment('storageBucket'),
      measurementId: const String.fromEnvironment('measurementId'),
      iosClientId: const String.fromEnvironment('iosClientId'),
      iosBundleId: const String.fromEnvironment('iosBundleId'),
    ),
  );

  // Pass all uncaught "fatal" errors from the framework to Crashlytics
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Gym Training',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.dark,
      home: const SplashPage(),
      initialBinding: AppBindings(),
    );
  }
}
