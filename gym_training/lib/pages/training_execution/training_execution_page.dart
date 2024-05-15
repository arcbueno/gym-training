import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_training/models/training_day.dart';
import 'package:gym_training/pages/training_execution/state.dart';
import 'package:gym_training/pages/training_execution/training_execution_controller.dart';
import 'package:gym_training/pages/training_execution/widgets/execution_list_item.dart';
import 'package:gym_training/utils/extensions.dart';
import 'package:gym_training/widgets/alarm_bottom_sheet/alarm_bottom_sheet.dart';
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
        bottomNavigationBar: const AlarmBottomSheet(),
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
                            return ExecutionListItem(
                              key: ValueKey(item.id),
                              item: item,
                              exercise:
                                  _controller.getByExerciseId(item.exerciseId),
                              lastExecution:
                                  _controller.getLastExecution(item.exerciseId),
                              onEditExecution: _controller.updateExecution,
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
                            if ((_formKey.currentState?.validate() ?? false) &&
                                _controller.validate()) {
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
