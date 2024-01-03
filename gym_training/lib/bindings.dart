import 'package:get/get.dart';
import 'package:gym_training/pages/splash/splash_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashController());
  }
}
