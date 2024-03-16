import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gym_training/models/training_day.dart';
import 'package:gym_training/pages/training_execution/state.dart';
import 'package:gym_training/pages/training_execution/training_execution_controller.dart';
import 'package:gym_training/utils/extensions.dart';
import 'package:gym_training/widgets/custom_form_field.dart';
import 'package:gym_training/widgets/error_text.dart';
import 'package:gym_training/widgets/save_form_button.dart';

class TrainingExecutionPage extends StatefulWidget {
  final TrainingDay trainingDay;
  const TrainingExecutionPage({super.key, required this.trainingDay});

  @override
  State<TrainingExecutionPage> createState() => _TrainingExecutionPageState();
}

class _TrainingExecutionPageState extends State<TrainingExecutionPage> {
  late final TrainingExecutionController _controller;
  final TextEditingController _dateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _controller = TrainingExecutionController(
      trainingExecutionRepository: Get.find(),
      trainingDay: widget.trainingDay,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            widget.trainingDay.title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        body: Obx(
          () {
            return Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    children: [
                      AnimatedSize(
                        curve: Curves.easeIn.flipped,
                        duration: const Duration(milliseconds: 300),
                        child: _controller.state.value is TraningExecutionError
                            ? Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: ErrorText(
                                  text: (_controller.state.value
                                          as TraningExecutionError)
                                      .errorMessage,
                                ),
                              )
                            : const SizedBox(),
                      ),
                      MediaQuery.removePadding(
                        context: context,
                        removeBottom: true,
                        removeTop: true,
                        child: ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: _controller.executions.length,
                          itemBuilder: (context, index) {
                            var item = _controller.executions[index];
                            var exercise =
                                _controller.getByExerciseId(item.exerciseId);
                            var lastExecution =
                                _controller.getLasExecution(item.exerciseId);
                            return Row(
                              children: [
                                Expanded(
                                  child: CheckboxListTile(
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    value: item.completed,
                                    onChanged: (val) {
                                      _controller.updateExecution(item.copyWith(
                                          completed: val ?? false));
                                    },
                                    title: Text(exercise.name),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            '${exercise.sets} of ${exercise.reps}'),
                                        if (!exercise.observation.isNullOrEmpty)
                                          Text('\n${exercise.observation!}'),
                                      ],
                                    ),
                                  ),
                                ),
                                Column(
                                  children: [
                                    if (lastExecution?.weight
                                            .toStringAsFixed(2) !=
                                        null) ...[
                                      Text(
                                          'Last: ${lastExecution?.weight.toStringAsFixed(2)}'),
                                      4.h,
                                    ],
                                    SizedBox(
                                      width: 100,
                                      child: CustomFormField(
                                        validator: (String? val) {
                                          if (val.isNullOrEmpty &&
                                              item.completed) {
                                            return 'Required';
                                          }
                                          return null;
                                        },
                                        hintText: 'Weight',
                                        onChanged: (String? val) {
                                          _controller.updateExecution(
                                              item.copyWith(
                                                  weight: double.tryParse(
                                                      val ?? '')));
                                        },
                                        maxLines: 1,
                                        keyboardType: const TextInputType
                                            .numberWithOptions(decimal: true),
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.allow(
                                              RegExp(r'^(\d+)?\.?\d{0,2}'))
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const Divider();
                          },
                        ),
                      ),
                      12.h,
                      const Divider(
                        thickness: 1,
                        height: 1,
                      ),
                      if (!widget.trainingDay.observation.isNullOrEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Observation',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(color: Colors.grey),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Text(
                                  widget.trainingDay.observation!,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ),
                            ],
                          ),
                        ),
                      CheckboxListTile(
                        value: _controller.useTodaysDate.value,
                        title: const Text('Use today\'s date?'),
                        onChanged: (_) {
                          _controller.useTodaysDate.value =
                              !_controller.useTodaysDate.value;
                        },
                      ),
                      AnimatedSize(
                        curve: Curves.easeIn.flipped,
                        duration: const Duration(milliseconds: 300),
                        child: _controller.useTodaysDate.value
                            ? const SizedBox()
                            : Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Expanded(
                                      child: Text(
                                        'So, when this training was done?',
                                      ),
                                    ),
                                    24.w,
                                    SizedBox(
                                      width: 100,
                                      child: CustomFormField(
                                        textAlign: TextAlign.center,
                                        readOnly: true,
                                        contentPadding: const EdgeInsets.all(8),
                                        hintText: 'Date',
                                        controller: _dateController,
                                        maxLines: 1,
                                        onTap: () async {
                                          var date = await showDatePicker(
                                            context: context,
                                            firstDate: DateTime(2000),
                                            lastDate: DateTime.now(),
                                          );
                                          if (date == null) return;
                                          _dateController.text =
                                              '${date.month}/${date.day}/${date.year}';
                                          _controller.doneDate = date;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      ),
                      24.h,
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: SaveFormButton(
                          onTap: () async {
                            if (_formKey.currentState?.validate() ?? false) {
                              var success = await _controller.save();
                              if (success) {
                                Get.back();
                              }
                            }
                          },
                          text: 'Save',
                          isLoading: _controller.state.value
                              is TraningExecutionLoading,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
