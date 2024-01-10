import 'package:gym_training/models/exercise_executions.dart';
import 'package:uuid/uuid.dart';

class TrainingExecution {
  late final String id;
  late final DateTime executionDate;
  late final String trainingId;
  late final List<ExerciseExecution> exerciseExecutions;

  TrainingExecution({
    String? itemId,
    required this.executionDate,
    required this.trainingId,
    required this.exerciseExecutions,
  }) : id = itemId ?? const Uuid().v1();

  TrainingExecution copyWith({
    String? id,
    DateTime? executionDate,
    String? trainingId,
    List<ExerciseExecution>? exerciseExecutions,
  }) {
    return TrainingExecution(
      itemId: id ?? this.id,
      executionDate: executionDate ?? this.executionDate,
      trainingId: trainingId ?? this.trainingId,
      exerciseExecutions: exerciseExecutions ?? this.exerciseExecutions,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'executionDate': executionDate});
    result.addAll({'trainingId': trainingId});
    result.addAll({
      'exerciseExecutions': exerciseExecutions.map((e) => e.toMap()).toList(),
    });

    return result;
  }

  static TrainingExecution fromFirebase(Map<String, dynamic> data) {
    return TrainingExecution(
      itemId: data['id'],
      executionDate: (data["executionDate"]).toDate(),
      trainingId: data["trainingId"],
      exerciseExecutions: (data["exerciseExecutions"] as List<dynamic>)
          .map((e) => ExerciseExecution.fromMap(e))
          .toList(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TrainingExecution &&
        other.id == id &&
        other.executionDate == executionDate &&
        other.trainingId == trainingId &&
        other.exerciseExecutions == exerciseExecutions;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        executionDate.hashCode ^
        trainingId.hashCode ^
        exerciseExecutions.hashCode;
  }
}
