import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gym_training/models/exercise.dart';
import 'package:gym_training/widgets/custom_form_field.dart';
import 'package:gym_training/utils/extensions.dart';
import 'package:uuid/uuid.dart';

class ExerciseBottomSheet {
  show(
    BuildContext context,
    void Function(Exercise) onAdd,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return AddExerciseForm(onAdd: onAdd);
      },
    );
  }
}

class AddExerciseForm extends StatefulWidget {
  final void Function(Exercise) onAdd;

  const AddExerciseForm({super.key, required this.onAdd});

  @override
  State<AddExerciseForm> createState() => _AddExerciseFormState();
}

class _AddExerciseFormState extends State<AddExerciseForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _setsController = TextEditingController();
  final _repsController = TextEditingController();
  final _observationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomFormField(
                controller: _nameController,
                hintText: 'Name',
                validator: (value) {
                  if (value.isNullOrEmpty) return 'Required field';
                  return null;
                },
                maxLines: 1,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 100,
                      child: CustomFormField(
                        controller: _setsController,
                        contentPadding: const EdgeInsets.all(8),
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
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    SizedBox(
                      width: 100,
                      child: CustomFormField(
                        controller: _repsController,
                        contentPadding: const EdgeInsets.all(8),
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
              ),
              12.h,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: CustomFormField(
                  controller: _observationController,
                  contentPadding: const EdgeInsets.all(8),
                  hintText: 'Exercise obs',
                  maxLines: null,
                ),
              ),
              24.h,
              ElevatedButton(
                onPressed: () async {
                  var success = _formKey.currentState?.validate();
                  if (success ?? false) {
                    var newExercise = Exercise(
                      id: const Uuid().v1(),
                      name: _nameController.text,
                      reps: int.tryParse(_repsController.text) ?? 0,
                      sets: int.tryParse(_setsController.text) ?? 0,
                      observation: _observationController.text,
                    );

                    widget.onAdd(newExercise);
                    Get.back();
                  }
                },
                child: const Text('Add new exercise'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _observationController.dispose();
    _repsController.dispose();
    _setsController.dispose();
    super.dispose();
  }
}
