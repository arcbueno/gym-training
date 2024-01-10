import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:gym_training/bindings.dart';
import 'package:gym_training/firebase_options.dart';
import 'package:gym_training/pages/splash/splash_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
// ignore: depend_on_referenced_packages
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  // print(dotenv.env);
  // await dotenv.load(fileName: '.env');
  // print(dotenv.env);
  await Firebase.initializeApp(
    name: 'gym_training',
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
