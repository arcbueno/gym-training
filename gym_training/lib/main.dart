import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:gym_training/bindings.dart';
import 'package:gym_training/firebase_options.dart';
import 'package:gym_training/pages/splash/splash_page.dart';
// ignore: depend_on_referenced_packages
import 'package:get_storage/get_storage.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform
      // name: 'gym-training-a8f19',
      // options: FirebaseOptions(
      //   apiKey: dotenv.env['API_KEY'] ?? '',
      //   appId: dotenv.env['APP_ID'] ?? '',
      //   messagingSenderId: dotenv.env['MESSSAGING_SENDER_ID'] ?? '',
      //   projectId: dotenv.env['PROJECT_ID'] ?? '',
      //   authDomain: dotenv.env['AUTH_DOMAIN'] ?? '',
      //   storageBucket: dotenv.env['STORAGE_BUCKET'] ?? '',
      //   measurementId: dotenv.env['MEASUREMENT_ID'] ?? '',
      //   iosClientId: dotenv.env['IOS_CLIENT_ID'] ?? '',
      //   iosBundleId: dotenv.env['IOS_BUNDLE_ID'] ?? '',
      // ),
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
