import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_training/models/training_day.dart';
import 'package:gym_training/pages/training_execution/training_execution_page.dart';
import 'package:gym_training/utils/extensions.dart';

class TrainingListItem extends StatelessWidget {
  final TrainingDay trainingDay;
  final void Function(TrainingDay) onRemove;
  final void Function(TrainingDay) onUpdate;

  const TrainingListItem({
    super.key,
    required this.trainingDay,
    required this.onRemove,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              trainingDay.title,
            ),
          ),
          IconButton(
            onPressed: () {
              Get.to(() => TrainingExecutionPage(trainingDay: trainingDay));
            },
            icon: const Icon(Icons.play_arrow_rounded),
          )
        ],
      ),
      trailing: PopupMenuButton(
        itemBuilder: (context) => <PopupMenuEntry>[
          // PopupMenuItem(
          //   onTap: () => onUpdate(trainingDay),
          //   child: Row(
          //     children: [
          //       const Icon(Icons.edit),
          //       4.w,
          //       const Text('Update'),
          //     ],
          //   ),
          // ),
          PopupMenuItem(
            onTap: () => onRemove(trainingDay),
            child: Row(
              children: [
                const Icon(Icons.close),
                4.w,
                const Text('Remove'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
