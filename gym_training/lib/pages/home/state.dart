import 'package:gym_training/models/training_day.dart';
import 'package:gym_training/models/training_execution.dart';
import 'package:gym_training/states.dart';

abstract class HomeState extends State {}

class HomeLoading extends HomeState {}

class HomeInit extends HomeState {
  final List<TrainingDay> trainingList = [];
}

class HomeListSuccess extends HomeState {
  final List<TrainingDay> trainingList;
  HomeListSuccess({required this.trainingList});
}

class HomeCalendarSuccess extends HomeState {
  final List<TrainingExecution> executionList;
  final List<TrainingDay> trainingList;
  HomeCalendarSuccess({
    required this.trainingList,
    required this.executionList,
  });
}

class HomeError extends HomeState {
  String errorMessage;
  HomeError({required this.errorMessage});
}
