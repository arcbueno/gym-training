import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_training/pages/home/home_page.dart';
import 'package:gym_training/pages/login/login_page.dart';
import 'package:gym_training/pages/splash/splash_controller.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final controller = Get.find<SplashController>();

  @override
  void initState() {
    super.initState();
    controller.isUserLoggedin().then((isLogged) {
      if (isLogged) {
        Get.to(const HomePage());
        return;
      }
      Get.to(const LoginPage());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 140,
          child: Image.asset('assets/muscle.png'),
        ),
      ),
    );
  }
}
