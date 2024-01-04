// ignore: depend_on_referenced_packages
import 'package:get_storage/get_storage.dart';
import 'package:gym_training/utils/shared_keys.dart';

class SplashController {
  late final GetStorage shared;

  SplashController({
    required this.shared,
  });

  Future<bool> isUserLoggedin() async {
    var session = shared.read<String>(SharedKeys.userDataKey);
    return session != null;
  }
}
