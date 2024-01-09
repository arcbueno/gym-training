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
      title: Row(
        children: [
          Text(
            item.name,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const VerticalDivider(
            color: Colors.black,
            thickness: 1,
          ),
          12.w,
        ],
      ),
      expandedAlignment: Alignment.centerLeft,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
            ],
          ),
        )
      ],
    );
  }
}
