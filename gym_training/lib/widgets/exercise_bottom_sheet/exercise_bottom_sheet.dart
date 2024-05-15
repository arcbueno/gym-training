import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_training/models/exercise.dart';
import 'package:gym_training/utils/extensions.dart';
import 'package:gym_training/widgets/exercise_bottom_sheet/exercise_bottom_sheet_controller.dart';
import 'package:gym_training/widgets/exercise_bottom_sheet/exercise_form.dart';
import 'package:gym_training/widgets/save_form_button.dart';

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
  late final ExerciseBottomSheetController controller;

  @override
  void initState() {
    controller = ExerciseBottomSheetController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height / 1.5,
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16).add(
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            ),
            child: Obx(() {
              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (controller
                              .mainExercise.parallelExercises.isNotEmpty)
                            Text(
                              'Initial exercise',
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                          ExerciseForm(
                            key: ObjectKey(controller.mainExercise.id),
                            onChangeName: (String value) {
                              controller.onChangeName(
                                  value, controller.mainExercise.id);
                            },
                            onChangeObservation: (String value) {
                              controller.onChangeObservation(
                                  value, controller.mainExercise.id);
                            },
                            onChangeReps: (String value) {
                              controller.onChangeReps(
                                  value, controller.mainExercise.id);
                            },
                            onChangeSet: (String value) {
                              controller.onChangeSet(
                                  value, controller.mainExercise.id);
                            },
                          ),
                          if (controller
                              .mainExercise.parallelExercises.isNotEmpty)
                            ...controller.mainExercise.parallelExercises
                                .map(
                                  (e) => Container(
                                    margin: const EdgeInsets.only(top: 24),
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black26),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Icon(
                                              Icons.add,
                                            ),
                                            IconButton(
                                              onPressed: () => controller
                                                  .removeExercise(e.id),
                                              icon: const Icon(Icons.delete),
                                            ),
                                          ],
                                        ),
                                        ExerciseForm(
                                          key: ObjectKey(e.id),
                                          onChangeName: (String value) {
                                            controller.onChangeName(
                                                value, e.id);
                                          },
                                          onChangeObservation: (String value) {
                                            controller.onChangeObservation(
                                                value, e.id);
                                          },
                                          onChangeReps: (String value) {
                                            controller.onChangeReps(
                                                value, e.id);
                                          },
                                          onChangeSet: (String value) {
                                            controller.onChangeSet(value, e.id);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                                .toList(),
                          24.h,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              OutlinedButton(
                                onPressed: controller.addExercise,
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.add),
                                    Text('Add parallel exercise'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          24.h,
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width / 1.5,
                    height: 48,
                    child: SaveFormButton(
                      onTap: () async {
                        var success = _formKey.currentState?.validate();
                        if (success ?? false) {
                          widget.onAdd(controller.mainExercise);
                          Get.back();
                        }
                      },
                      text: 'Add',
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
