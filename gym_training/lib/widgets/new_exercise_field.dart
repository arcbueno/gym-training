import 'package:flutter/material.dart';
import 'package:gym_training/models/exercise.dart';
import 'package:gym_training/pages/new_training/new_training_controller.dart';
import 'package:gym_training/utils/extensions.dart';

class NewExerciseField extends StatelessWidget {
  final NewTrainingController controller;
  final Exercise item;

  const NewExerciseField(
      {super.key, required this.controller, required this.item});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      controlAffinity: ListTileControlAffinity.leading,
      trailing: IconButton(
        onPressed: () {
          controller.removeExercise(item);
        },
        icon: const Icon(Icons.cancel),
      ),
      tilePadding: EdgeInsets.zero,
      title: Text(
        item.name,
        style: Theme.of(context).textTheme.titleLarge,
      ),
      expandedAlignment: Alignment.centerLeft,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: ExerciseData(
            item: item,
          ),
        ),
      ],
    );
  }
}

class ExerciseData extends StatelessWidget {
  final Exercise item;
  final bool isParallel;
  const ExerciseData({
    super.key,
    required this.item,
    this.isParallel = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isParallel) ...[
          const Icon(Icons.add),
          Text(
            item.name,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ],
        Text(
          '${item.sets.toString()} sets / ${item.reps.toString()} reps per set',
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.start,
        ),
        12.h,
        Text(
          !item.observation.isNullOrEmpty
              ? item.observation!
              : 'No observation',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: item.observation.isNullOrEmpty ? Colors.grey : null),
        ),
        12.h,
        ...item.parallelExercises.map(
          (e) => ExerciseData(
            item: e,
            isParallel: true,
          ),
        ),
      ],
    );
  }
}
