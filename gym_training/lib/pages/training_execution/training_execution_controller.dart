import 'package:get/get.dart';
import 'package:gym_training/models/exercise_executions.dart';
import 'package:gym_training/models/training_day.dart';
import 'package:gym_training/repositories/training_execution_repository.dart';

import 'state.dart';

class TrainingExecutionController {
  late final TrainingExecutionRepository trainingExecutionRepository;
  late final TrainingDay trainingDay;

  final Rx<TrainingExecutionState> state =
      Rx<TrainingExecutionState>(TraningExecutionInit());

  final RxList<ExerciseExecution> executions = <ExerciseExecution>[].obs;

  TrainingExecutionController({
    required this.trainingExecutionRepository,
    required this.trainingDay,
  }) {
    executions.addAll(trainingDay.exercises
        .map((e) => ExerciseExecution.fromBaseExercise(e))
        .toList());
  }

  void save() {}
}
