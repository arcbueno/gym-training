abstract class State {}

abstract class ErrorState extends State {
  late String errorMessage;

  ErrorState({required this.errorMessage});
}
