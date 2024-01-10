import 'package:gym_training/models/exercise.dart';
import 'package:uuid/uuid.dart';

class TrainingDay {
  late final String id;
  late final String title;
  late final DateTime? lastTimeExecuted;
  late final List<Exercise> exercises;
  late final String? observation;

  TrainingDay({
    String? itemId,
    required this.title,
    required this.exercises,
    this.lastTimeExecuted,
    this.observation,
  }) : id = itemId ?? const Uuid().v1();

  TrainingDay copyWith({
    String? id,
    String? title,
    DateTime? lastTimeExecuted,
    List<Exercise>? exercises,
    String? observation,
  }) {
    return TrainingDay(
      itemId: id ?? this.id,
      title: title ?? this.title,
      lastTimeExecuted: lastTimeExecuted ?? this.lastTimeExecuted,
      exercises: exercises ?? this.exercises,
      observation: observation ?? this.observation,
    );
  }

  Map<String, dynamic> toMapNew() {
    final result = <String, dynamic>{};

    result.addAll({'title': title});
    result.addAll({'lastTimeExecuted': lastTimeExecuted});
    result.addAll({'id': id});
    result.addAll({
      'exercises': exercises.map((e) => e.toMapNew()).toList(),
    });
    if (observation != null) {
      result.addAll({'observation': observation!});
    }

    return result;
  }

  static TrainingDay fromFirebase(Map<String, dynamic> data) {
    return TrainingDay(
        itemId: data["id"],
        title: data["title"],
        lastTimeExecuted: data["lastTimeExecuted"],
        observation: data["observation"],
        exercises: (data["exercises"] as List<dynamic>)
            .map((e) => Exercise.fromMap(e))
            .toList());
  }
}
