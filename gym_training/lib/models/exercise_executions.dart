import 'package:gym_training/models/exercise.dart';
import 'package:uuid/uuid.dart';

class ExerciseExecution {
  late final String? id;
  late final String exerciseId;
  late final double weight;
  late final bool completed;
  late final List<ExerciseExecution> parallelExererciseExecution;

  ExerciseExecution({
    String? itemId,
    required this.exerciseId,
    required this.weight,
    this.completed = false,
    this.parallelExererciseExecution = const [],
  }) : id = itemId ?? const Uuid().v1();

  factory ExerciseExecution.fromBaseExercise(Exercise base) {
    return ExerciseExecution(
      exerciseId: base.id,
      weight: 0.0,
      parallelExererciseExecution: base.parallelExercises.isNotEmpty
          ? base.parallelExercises
              .map((e) => ExerciseExecution.fromBaseExercise(e))
              .toList()
          : [],
    );
  }

  ExerciseExecution copyWith({
    String? id,
    String? exerciseId,
    double? weight,
    bool? completed,
  }) {
    return ExerciseExecution(
      itemId: id ?? this.id,
      exerciseId: exerciseId ?? this.exerciseId,
      weight: weight ?? this.weight,
      completed: completed ?? this.completed,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id!});
    }
    result.addAll({'exerciseId': exerciseId});
    result.addAll({'weight': weight});
    result.addAll({'completed': completed});
    result.addAll({
      'parallelExererciseExecution':
          parallelExererciseExecution.map((e) => e.toMap()).toList()
    });

    return result;
  }

  factory ExerciseExecution.fromMap(Map<String, dynamic> map) {
    return ExerciseExecution(
      itemId: map['id'],
      exerciseId: map['exerciseId'],
      weight: map['weight'],
      completed: map['completed'],
      parallelExererciseExecution: map['parallelExererciseExecution'] != null
          ? map['parallelExererciseExecution']
              .map((e) => ExerciseExecution.fromMap(e))
              .toList()
          : [],
    );
  }
}
