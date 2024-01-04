import 'package:gym_training/models/training_day.dart';

abstract class HomeState {}

class HomeInit extends HomeState {
  final List<TrainingDay> trainingList = [];
}

class HomeSuccess extends HomeState {
  List<TrainingDay> trainingList;
  HomeSuccess({required this.trainingList});
}

class HomeLoading extends HomeState {}

class HomeError extends HomeState {
  String errorMessage;
  HomeError({required this.errorMessage});
}
