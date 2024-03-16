import 'dart:developer';

import 'package:get/get.dart';
import 'package:gym_training/pages/create_account/state.dart';
import 'package:gym_training/repositories/session_repository.dart';

class CreateAccountController {
  late final SessionRepository repository;
  Rx<CreateAccountState> state = Rx<CreateAccountState>(CreateAccountInit());

  String? email;
  String? password;
  String? repeatedPassword;

  CreateAccountController({
    required this.repository,
  });

  Future<bool> save() async {
    try {
      state.value = CreateAccountLoading();
      var result = await repository.createUser(email!, password!);
      return result.fold<bool>(
        (success) {
          state.value = CreateAccountSuccess();
          return true;
        },
        (failure) {
          _onError(failure);
          return false;
        },
      );
    } catch (e) {
      _onError(e as Exception);
      return false;
    }
  }

  _onError(Exception e) {
    log(e.toString());
    state.value = CreateAccountError(errorMessage: e.toString());
  }
}
