import 'package:gym_training/states.dart';

abstract class CreateAccountState extends State {}

class CreateAccountInit extends CreateAccountState {}

class CreateAccountSuccess extends CreateAccountState {}

class CreateAccountLoading extends CreateAccountState {}

class CreateAccountError extends CreateAccountState implements ErrorState {
  @override
  late String errorMessage;

  CreateAccountError({
    required this.errorMessage,
  });
}
