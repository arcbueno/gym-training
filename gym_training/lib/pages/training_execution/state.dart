abstract class TrainingExecutionState {}

class TraningExecutionInit extends TrainingExecutionState {}

class TraningExecutionSuccess extends TrainingExecutionState {}

class TraningExecutionLoading extends TrainingExecutionState {}

class TraningExecutionError extends TrainingExecutionState {
  String errorMessage;
  TraningExecutionError({required this.errorMessage});
}
