class Exercise {
  late final String? id;
  late final String name;
  late final String observation;
  late final int reps;
  late final int sets;

  Exercise({
    this.id,
    required this.name,
    required this.observation,
    required this.reps,
    required this.sets,
  });

  Exercise copyWith({
    String? id,
    String? name,
    String? observation,
    int? reps,
    int? sets,
  }) {
    return Exercise(
      id: id ?? this.id,
      name: name ?? this.name,
      observation: observation ?? this.observation,
      reps: reps ?? this.reps,
      sets: sets ?? this.sets,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id!});
    }
    result.addAll({'name': name});
    result.addAll({'observation': observation});
    result.addAll({'reps': reps});
    result.addAll({'sets': sets});

    return result;
  }

  factory Exercise.fromMap(Map<String, dynamic> map) {
    return Exercise(
      id: map['id'],
      name: map['name'],
      observation: map['observation'],
      reps: map['reps'],
      sets: map['sets'],
    );
  }
}
