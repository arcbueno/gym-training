import 'package:gym_training/states.dart';

abstract class NewTrainingState extends State {}

class NewTrainingInit extends NewTrainingState {}

class NewTrainingSuccess extends NewTrainingState {}

class NewTrainingLoading extends NewTrainingState {}

class NewTrainingError extends NewTrainingState {
  String errorMessage;
  NewTrainingError({required this.errorMessage});
}
