import 'package:gym_training/states.dart';

abstract class LoginState extends State {}

class LoginInit extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginLoading extends LoginState {}

class LoginError extends LoginState implements ErrorState {
  @override
  late String errorMessage;

  LoginError({
    required this.errorMessage,
  });
}
