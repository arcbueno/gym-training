import 'package:get/get.dart';
import 'package:gym_training/models/exercise.dart';

class ExerciseBottomSheetController {
  final Rx<Exercise> _mainExercise = Rx<Exercise>(
    Exercise(name: '', reps: 0, sets: 0),
  );

  Exercise get mainExercise => _mainExercise.value;

  void addExercise() {
    _mainExercise.value = _mainExercise.value.copyWith(
      parallelExercises: [
        ..._mainExercise.value.parallelExercises,
        Exercise(name: '', reps: 0, sets: 0),
      ],
    );
  }

  void removeExercise(String id) {
    _mainExercise.value.parallelExercises
        .removeWhere((element) => element.id == id);
    _mainExercise.refresh();
  }

  void onChangeName(String value, String id) {
    if (_mainExercise.value.id == id) {
      _mainExercise.value.name = value;
      return;
    }
    _mainExercise.value.parallelExercises
        .singleWhere((element) => element.id == id)
        .name = value;
  }

  void onChangeSet(String value, String id) {
    if (value.isEmpty || int.tryParse(value) == null) {
      return;
    }
    if (_mainExercise.value.id == id) {
      _mainExercise.value =
          _mainExercise.value.copyWith(sets: int.parse(value));
      return;
    }
    _mainExercise.value.parallelExercises
        .singleWhere((element) => element.id == id)
        .sets = int.parse(value);
  }

  void onChangeReps(String value, String id) {
    if (value.isEmpty || int.tryParse(value) == null) {
      return;
    }
    if (_mainExercise.value.id == id) {
      _mainExercise.value =
          _mainExercise.value.copyWith(reps: int.parse(value));
      return;
    }
    _mainExercise.value.parallelExercises
        .singleWhere((element) => element.id == id)
        .reps = int.parse(value);
  }

  void onChangeObservation(String value, String id) {
    if (_mainExercise.value.id == id) {
      _mainExercise.value = _mainExercise.value.copyWith(observation: value);
      return;
    }
    _mainExercise.value.parallelExercises
        .singleWhere((element) => element.id == id)
        .observation = value;
  }
}
