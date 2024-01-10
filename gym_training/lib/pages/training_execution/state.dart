import 'package:gym_training/states.dart';

abstract class TrainingExecutionState extends State {}

class TraningExecutionEmpty extends TrainingExecutionState {}

class TraningExecutionSuccess extends TrainingExecutionState {}

class TraningExecutionLoading extends TrainingExecutionState {}

class TraningExecutionError extends TrainingExecutionState
    implements ErrorState {
  @override
  late String errorMessage;

  TraningExecutionError({required this.errorMessage});
}
