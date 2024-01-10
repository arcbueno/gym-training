import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_training/models/training_day.dart';
import 'package:gym_training/pages/training_execution/training_execution_controller.dart';
import 'package:gym_training/widgets/save_button.dart';

class TrainingExecutionPage extends StatefulWidget {
  final TrainingDay trainingDay;
  const TrainingExecutionPage({super.key, required this.trainingDay});

  @override
  State<TrainingExecutionPage> createState() => _TrainingExecutionPageState();
}

class _TrainingExecutionPageState extends State<TrainingExecutionPage> {
  late final TrainingExecutionController _controller;

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
            return SingleChildScrollView(
              child: Form(
                child: Column(
                  children: [
                    SaveButton(
                      onPressed: _controller.save,
                      title: 'Save',
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
