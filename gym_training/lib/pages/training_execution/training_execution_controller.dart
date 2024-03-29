import 'dart:developer';

import 'package:get/get.dart';
import 'package:gym_training/models/exercise.dart';
import 'package:gym_training/models/exercise_executions.dart';
import 'package:gym_training/models/training_day.dart';
import 'package:gym_training/models/training_execution.dart';
import 'package:gym_training/repositories/training_execution_repository.dart';

import 'state.dart';

class TrainingExecutionController {
  late final TrainingExecutionRepository trainingExecutionRepository;
  late final TrainingDay trainingDay;
  TrainingExecution? lastTraining;
  DateTime? doneDate;

  final Rx<TrainingExecutionState> state =
      Rx<TrainingExecutionState>(TraningExecutionEmpty());

  final RxList<ExerciseExecution> executions = <ExerciseExecution>[].obs;

  final RxBool useTodaysDate = true.obs;

  TrainingExecutionController({
    required this.trainingExecutionRepository,
    required this.trainingDay,
  }) {
    executions.addAll(trainingDay.exercises
        .map((e) => ExerciseExecution.fromBaseExercise(e))
        .toList());
    getLastTraining();
  }

  ExerciseExecution? getLasExecution(String exerciseId) {
    if (lastTraining == null || lastTraining!.exerciseExecutions.isEmpty) {
      return null;
    }
    return lastTraining?.exerciseExecutions
        .singleWhere((element) => element.exerciseId == exerciseId);
  }

  getLastTraining() async {
    try {
      state.value = TraningExecutionLoading();
      lastTraining = await trainingExecutionRepository.getLast(trainingDay.id);
      state.value = TraningExecutionEmpty();
    } catch (e) {
      log(e.toString());
      state.value = TraningExecutionError(errorMessage: e.toString());
    }
  }

  Exercise getByExerciseId(String id) {
    return trainingDay.exercises.singleWhere((element) => element.id == id);
  }

  void updateExecution(ExerciseExecution item) {
    var index = executions.indexWhere((element) => element.id == item.id);
    executions[index] = item;
    executions.refresh();
  }

  Future<bool> save() async {
    try {
      state.value = TraningExecutionLoading();
      var execution = TrainingExecution(
        executionDate: doneDate ?? DateTime.now(),
        trainingId: trainingDay.id,
        exerciseExecutions: executions,
      );

      await trainingExecutionRepository.newExecution(execution);

      state.value = TraningExecutionSuccess();
      return true;
    } catch (e) {
      log(e.toString());
      state.value = TraningExecutionError(errorMessage: e.toString());
      return false;
    }
  }
}
