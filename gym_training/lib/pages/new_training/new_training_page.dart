import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_training/pages/new_training/new_training_controller.dart';
import 'package:gym_training/pages/new_training/state.dart';
import 'package:gym_training/utils/extensions.dart';
import 'package:gym_training/widgets/custom_form_field.dart';
import 'package:gym_training/widgets/exercise_bottom_sheet/exercise_bottom_sheet.dart';
import 'package:gym_training/widgets/new_exercise_field.dart';
import 'package:gym_training/widgets/save_form_button.dart';

class NewTrainingPage extends StatefulWidget {
  const NewTrainingPage({super.key});

  @override
  State<NewTrainingPage> createState() => _NewTrainingPageState();
}

class _NewTrainingPageState extends State<NewTrainingPage> {
  late final NewTrainingController _controller;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _controller = NewTrainingController(trainingRepository: Get.find());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'New Training',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AnimatedSize(
                    curve: Curves.easeIn.flipped,
                    duration: const Duration(milliseconds: 300),
                    child: _controller.state.value is NewTrainingError
                        ? Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Text(
                              (_controller.state.value as NewTrainingError)
                                  .errorMessage,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(color: Colors.red.shade300),
                            ),
                          )
                        : const SizedBox(),
                  ),
                  CustomFormField(
                    hintText: 'Name',
                    onChanged: (value) {
                      _controller.trainingDayName = value;
                    },
                    validator: (value) {
                      if (value.isNullOrEmpty) return 'Required field';
                      return null;
                    },
                    maxLines: 1,
                  ),
                  24.h,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _controller.exercises.isNotEmpty
                            ? 'Exercise list:'
                            : 'Add a new exercise',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        _controller.exercises.length.toString(),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      AnimatedSize(
                        curve: Curves.easeIn.flipped,
                        duration: const Duration(milliseconds: 300),
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _controller.exercises.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            var item = _controller.exercises[index];
                            return NewExerciseField(
                              key: ValueKey(item.id),
                              controller: _controller,
                              item: item,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      OutlinedButton(
                        onPressed: addNewExercise,
                        child: const Icon(Icons.add),
                      ),
                    ],
                  ),
                  24.h,
                  CustomFormField(
                    hintText: 'Observation',
                    onChanged: (value) {
                      _controller.trainingDayObservations = value;
                    },
                    maxLines: null,
                  ),
                  48.h,
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: MediaQuery.sizeOf(context).width / 1.5,
                      height: 48,
                      child: SaveFormButton(
                        onTap: () async {
                          var success = _controller.validateAllExercises();
                          if (success && _formKey.currentState!.validate()) {
                            bool success = await _controller.save();
                            if (success) Get.back();
                          }
                        },
                        text: 'Save',
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  addNewExercise() {
    var success = _controller.validateAllExercises();
    if (!success) return;
    ExerciseBottomSheet().show(context, _controller.addExercise);
  }
}
