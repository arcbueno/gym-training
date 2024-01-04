import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gym_training/models/exercise.dart';

class TrainingDay {
  late final String? id;
  late final String title;
  late final DateTime? lastTimeExecuted;
  late final List<Exercise> exercises;

  TrainingDay({
    this.id,
    required this.title,
    required this.exercises,
    this.lastTimeExecuted,
  });

  TrainingDay copyWith({
    String? id,
    String? title,
    DateTime? lastTimeExecuted,
    List<Exercise>? exercises,
  }) {
    return TrainingDay(
      id: id ?? this.id,
      title: title ?? this.title,
      lastTimeExecuted: lastTimeExecuted ?? this.lastTimeExecuted,
      exercises: exercises ?? this.exercises,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id!});
    }
    result.addAll({'title': title});
    result.addAll({'lastTimeExecuted': lastTimeExecuted});
    result.addAll({
      'exercises': exercises.map((e) => e.toMap()).toList(),
    });

    return result;
  }

  static TrainingDay fromFirebase(DocumentSnapshot<Map<String, dynamic>> doc) {
    return TrainingDay(
        id: doc.id,
        title: doc.data()!["title"],
        lastTimeExecuted: doc.data()!["lastTimeExecuted"],
        exercises: (doc.data()!["exercises"] as List<Map<String, dynamic>>)
            .map((e) => Exercise.fromMap(e))
            .toList());
  }
}
