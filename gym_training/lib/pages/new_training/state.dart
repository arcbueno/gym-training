abstract class NewTrainingState {}

class NewTrainingInit extends NewTrainingState {}

class NewTrainingSuccess extends NewTrainingState {}

class NewTrainingLoading extends NewTrainingState {}

class NewTrainingError extends NewTrainingState {
  String errorMessage;
  NewTrainingError({required this.errorMessage});
}
