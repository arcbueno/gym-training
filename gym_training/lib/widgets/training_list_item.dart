import 'package:flutter/material.dart';
import 'package:gym_training/models/training_day.dart';

class TrainingListItem extends StatelessWidget {
  final TrainingDay trainingDay;

  const TrainingListItem({super.key, required this.trainingDay});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(trainingDay.title),
    );
  }
}
