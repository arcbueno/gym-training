import 'package:gym_training/models/exercise.dart';
import 'package:uuid/uuid.dart';

class ExerciseExecution {
  late final String? id;
  late final String exerciseId;
  late final double weight;
  late final bool completed;

  ExerciseExecution({
    String? itemId,
    required this.exerciseId,
    required this.weight,
    this.completed = false,
  }) : id = itemId ?? const Uuid().v1();

  factory ExerciseExecution.fromBaseExercise(Exercise base) {
    return ExerciseExecution(exerciseId: base.id, weight: 0.0);
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

    return result;
  }

  factory ExerciseExecution.fromMap(Map<String, dynamic> map) {
    return ExerciseExecution(
      itemId: map['id'],
      exerciseId: map['exerciseId'],
      weight: map['weight'],
      completed: map['completed'],
    );
  }
}
