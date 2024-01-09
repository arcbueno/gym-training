import 'dart:developer';

import 'package:get/get.dart';
import 'package:gym_training/models/exercise.dart';
import 'package:gym_training/models/training_day.dart';
import 'package:gym_training/pages/new_training/state.dart';
import 'package:gym_training/repositories/training_repository.dart';
import 'package:gym_training/utils/extensions.dart';

class NewTrainingController {
  late final TrainingRepository trainingRepository;
  RxList<Exercise> exercises = <Exercise>[].obs;
  Rx<NewTrainingState> state = Rx<NewTrainingState>(NewTrainingInit());

  String? trainingDayName;
  String? trainingDayObservations;

  NewTrainingController({required this.trainingRepository});

  bool validateAllExercises() {
    if (exercises.isEmpty) return true;
    if (exercises.any((element) => element.name.isNullOrEmpty)) {
      Get.snackbar('Atention', 'There\'s a exercise without a name');
      return false;
    }
    if (exercises.any((element) => element.reps == 0 || element.sets == 0)) {
      Get.snackbar(
          'Atention', 'There\'s a exercise with undefined reps or sets');
      return false;
    }
    return true;
  }

  removeExercise(Exercise item) {
    exercises.remove(item);
  }

  addExercise(Exercise item) {
    exercises.add(item);
  }

  Future<bool> save() async {
    if (trainingDayName.isNullOrEmpty) {
      Get.snackbar('Atention', 'The training should have a name');
      return false;
    }
    var training = TrainingDay(
        title: trainingDayName!,
        exercises: exercises,
        observation: trainingDayObservations);

    try {
      state.value = NewTrainingLoading();
      await trainingRepository.createNew(training);
      state.value = NewTrainingSuccess();
      return true;
    } catch (e) {
      log(e.toString());
      state.value = NewTrainingError(errorMessage: e.toString());
      return false;
    }
  }
}
