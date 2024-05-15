import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gym_training/models/exercise.dart';
import 'package:gym_training/models/exercise_executions.dart';
import 'package:gym_training/utils/extensions.dart';
import 'package:gym_training/widgets/custom_form_field.dart';

class ExecutionListItem extends StatelessWidget {
  final ExerciseExecution item;
  final Exercise exercise;
  final ExerciseExecution? lastExecution;
  final Function(ExerciseExecution, bool) onEditExecution;
  final bool isChild;
  const ExecutionListItem({
    super.key,
    required this.item,
    required this.exercise,
    required this.onEditExecution,
    this.lastExecution,
    this.isChild = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                value: item.completed,
                onChanged: (val) {
                  onEditExecution(
                      item.copyWith(completed: val ?? false), isChild);
                },
                title: Text(exercise.name),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${exercise.sets} of ${exercise.reps}'),
                    if (!exercise.observation.isNullOrEmpty)
                      Text('\n${exercise.observation!}'),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                if (lastExecution?.weight.toStringAsFixed(2) != null) ...[
                  Text('Last: ${lastExecution?.weight.toStringAsFixed(2)}'),
                  4.h,
                ],
                SizedBox(
                  width: 100,
                  child: CustomFormField(
                    validator: (String? val) {
                      if (val.isNullOrEmpty && item.completed) {
                        return 'Required';
                      }
                      return null;
                    },
                    hintText: 'Weight',
                    onChanged: (String? val) {
                      onEditExecution(
                          item.copyWith(weight: double.tryParse(val ?? '')),
                          isChild);
                    },
                    maxLines: 1,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^(\d+)?\.?\d{0,2}'))
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        if (exercise.parallelExercises.isNotEmpty)
          ...exercise.parallelExercises
              .map((e) => Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Row(
                      children: [
                        const Icon(Icons.add),
                        Expanded(
                          child: ExecutionListItem(
                            isChild: true,
                            item: item.parallelExererciseExecution.firstWhere(
                                (element) => element.exerciseId == e.id),
                            exercise: e,
                            onEditExecution: onEditExecution,
                            lastExecution: lastExecution
                                ?.parallelExererciseExecution
                                .firstWhere(
                                    (element) => element.exerciseId == e.id),
                          ),
                        ),
                      ],
                    ),
                  ))
              .toList(),
      ],
    );
  }
}
