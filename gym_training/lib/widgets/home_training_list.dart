import 'package:flutter/material.dart';
import 'package:gym_training/models/training_day.dart';
import 'package:gym_training/widgets/home_empty_list.dart';
import 'package:gym_training/widgets/training_list_item.dart';

class HomeTrainingList extends StatelessWidget {
  final List<TrainingDay> trainingList;
  final void Function() onNewTraining;
  const HomeTrainingList(
      {super.key, required this.trainingList, required this.onNewTraining});

  @override
  Widget build(BuildContext context) {
    if (trainingList.isEmpty) {
      return HomeEmptyList(onNewTraining: onNewTraining);
    }
    return ListView.builder(
      itemCount: trainingList.length,
      itemBuilder: (context, index) {
        return TrainingListItem(trainingDay: trainingList[index]);
      },
    );
  }
}
