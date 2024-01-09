import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gym_training/models/exercise.dart';

class TrainingDay {
  late final String? id;
  late final String title;
  late final DateTime? lastTimeExecuted;
  late final List<Exercise> exercises;
  late final String? observation;

  TrainingDay({
    this.id,
    required this.title,
    required this.exercises,
    this.lastTimeExecuted,
    this.observation,
  });

  TrainingDay copyWith({
    String? id,
    String? title,
    DateTime? lastTimeExecuted,
    List<Exercise>? exercises,
    String? observation,
  }) {
    return TrainingDay(
      id: id ?? this.id,
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
    result.addAll({
      'exercises': exercises.map((e) => e.toMapNew()).toList(),
    });
    if (observation != null) {
      result.addAll({'observation': observation!});
    }

    return result;
  }

  static TrainingDay fromFirebase(DocumentSnapshot<Map<String, dynamic>> doc) {
    return TrainingDay(
        id: doc.id,
        title: doc.data()!["title"],
        lastTimeExecuted: doc.data()!["lastTimeExecuted"],
        observation: doc.data()!["observation"],
        exercises: (doc.data()!["exercises"] as List<dynamic>)
            .map((e) => Exercise.fromMap(e))
            .toList());
  }
}
