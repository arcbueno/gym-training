import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gym_training/utils/extensions.dart';
import 'package:gym_training/widgets/custom_form_field.dart';

class ExerciseForm extends StatelessWidget {
  final Function(String) onChangeName;
  final Function(String) onChangeSet;
  final Function(String) onChangeReps;
  final Function(String) onChangeObservation;
  const ExerciseForm({
    super.key,
    required this.onChangeName,
    required this.onChangeObservation,
    required this.onChangeReps,
    required this.onChangeSet,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CustomFormField(
          onChanged: onChangeName,
          hintText: 'Name',
          validator: (value) {
            if (value.isNullOrEmpty) return 'Required field';
            return null;
          },
          maxLines: 1,
        ),
        12.h,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: MediaQuery.sizeOf(context).width / 3,
              child: CustomFormField(
                onChanged: onChangeSet,
                hintText: 'Sets',
                maxLines: 1,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value.isNullOrEmpty) return 'Required field';
                  return null;
                },
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
              ),
            ),
            Text(
              'of',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(
              width: MediaQuery.sizeOf(context).width / 3,
              child: CustomFormField(
                onChanged: onChangeReps,
                hintText: 'Reps',
                maxLines: 1,
                validator: (value) {
                  if (value.isNullOrEmpty) return 'Required field';
                  return null;
                },
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
              ),
            ),
          ],
        ),
        12.h,
        CustomFormField(
          onChanged: onChangeObservation,
          hintText: 'Exercise obs',
          maxLines: null,
        ),
      ],
    );
  }
}
