import 'dart:developer';

import 'package:get/get.dart';
import 'package:gym_training/pages/login/state.dart';
import 'package:gym_training/repositories/session_repository.dart';

class LoginController {
  late final SessionRepository repository;
  Rx<LoginState> state = Rx<LoginState>(LoginInit());

  String? password;
  String? email;

  LoginController({
    required this.repository,
  });

  Future<bool> login() async {
    try {
      state.value = LoginLoading();
      var result = await repository.login(email!, password!);
      if (result == null) {
        state.value = LoginSuccess();
        return true;
      }
      state.value = LoginError(errorMessage: result);
      return false;
    } catch (e) {
      log(e.toString());
      state.value = LoginError(errorMessage: e.toString());
      return false;
    }
  }
}
