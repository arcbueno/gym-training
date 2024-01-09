import 'package:flutter/material.dart';
import 'package:gym_training/models/training_day.dart';
import 'package:gym_training/widgets/home_empty_list.dart';
import 'package:gym_training/widgets/training_list_item.dart';

class HomeTrainingList extends StatelessWidget {
  final List<TrainingDay> trainingList;
  final void Function() onNewTraining;
  final void Function(TrainingDay) onRemove;
  final void Function(TrainingDay) onUpdate;
  const HomeTrainingList({
    super.key,
    required this.trainingList,
    required this.onNewTraining,
    required this.onRemove,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    if (trainingList.isEmpty) {
      return HomeEmptyList(onNewTraining: onNewTraining);
    }
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            OutlinedButton(
              onPressed: onNewTraining,
              child: const Icon(Icons.add),
            ),
          ],
        ),
        ListView.builder(
          itemCount: trainingList.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return TrainingListItem(
              trainingDay: trainingList[index],
              onRemove: onRemove,
              onUpdate: onUpdate,
            );
          },
        ),
      ],
    );
  }
}
