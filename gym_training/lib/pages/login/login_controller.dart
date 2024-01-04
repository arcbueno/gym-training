import 'package:gym_training/repositories/session_repository.dart';

class LoginController {
  late final SessionRepository repository;

  String? password;
  String? email;

  LoginController({
    required this.repository,
  });

  Future<bool> login() {
    return repository.login(email!, password!);
  }
}
