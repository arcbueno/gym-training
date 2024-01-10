import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gym_training/models/exercise.dart';
import 'package:gym_training/widgets/custom_form_field.dart';
import 'package:gym_training/utils/extensions.dart';
import 'package:gym_training/widgets/save_button.dart';
import 'package:uuid/uuid.dart';

class ExerciseBottomSheet {
  show(
    BuildContext context,
    void Function(Exercise) onAdd,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
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
          child: Padding(
            padding: const EdgeInsets.all(32).add(EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom)),
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
                12.h,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width / 3,
                      child: CustomFormField(
                        controller: _setsController,
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
                        controller: _repsController,
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
                  controller: _observationController,
                  hintText: 'Exercise obs',
                  maxLines: null,
                ),
                24.h,
                SizedBox(
                  width: MediaQuery.sizeOf(context).width / 1.5,
                  height: 48,
                  child: SaveButton(
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
                    title: 'Add',
                  ),
                ),
              ],
            ),
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
