import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:gym_training/pages/login/login_controller.dart';
import 'package:gym_training/pages/splash/splash_controller.dart';
// ignore: depend_on_referenced_packages
import 'package:get_storage/get_storage.dart';
import 'package:gym_training/repositories/firebase_repository.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    // Init
    Get.put(GetStorage());
    Get.put(SplashController(shared: Get.find()));

    // Login
    Get.put(FirebaseAuth.instance);
    Get.put(
      FirebaseRepository(
        sharedPreferences: Get.find(),
        firebaseAuth: Get.find(),
      ),
    );
    Get.put(LoginController(repository: Get.find()));
  }
}
