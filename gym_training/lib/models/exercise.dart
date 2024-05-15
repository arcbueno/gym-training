import 'package:uuid/uuid.dart';

class Exercise {
  late String id;
  late String name;
  late String? observation;
  late int reps;
  late int sets;
  late List<Exercise> parallelExercises;

  Exercise({
    String? itemId,
    required this.name,
    required this.reps,
    required this.sets,
    this.observation,
    this.parallelExercises = const [],
  }) : id = itemId ?? const Uuid().v1();

  Exercise copyWith({
    String? id,
    String? name,
    String? observation,
    int? reps,
    int? sets,
    List<Exercise>? parallelExercises,
  }) {
    return Exercise(
      itemId: id ?? this.id,
      name: name ?? this.name,
      observation: observation ?? this.observation,
      reps: reps ?? this.reps,
      sets: sets ?? this.sets,
      parallelExercises: parallelExercises ?? this.parallelExercises,
    );
  }

  Map<String, dynamic> toMapNew() {
    final result = <String, dynamic>{};

    if (observation != null) {
      result.addAll({'observation': observation});
    }
    result.addAll({'name': name});
    result.addAll({'reps': reps});
    result.addAll({'sets': sets});
    result.addAll({'id': id});
    result.addAll({
      'parallelExercises': parallelExercises.map((e) => e.toMapNew()).toList(),
    });

    return result;
  }

  factory Exercise.fromMap(Map<String, dynamic> map) {
    return Exercise(
      itemId: map['id'],
      name: map['name'],
      observation: map['observation'],
      reps: map['reps'],
      sets: map['sets'],
      parallelExercises: map['parallelExercises'] != null
          ? List<Exercise>.from(
              map['parallelExercises']?.map((x) => Exercise.fromMap(x)))
          : [],
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Exercise &&
        other.id == id &&
        other.name == name &&
        other.observation == observation &&
        other.reps == reps &&
        other.sets == sets &&
        other.parallelExercises == parallelExercises;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        observation.hashCode ^
        reps.hashCode ^
        sets.hashCode ^
        parallelExercises.hashCode;
  }
}
