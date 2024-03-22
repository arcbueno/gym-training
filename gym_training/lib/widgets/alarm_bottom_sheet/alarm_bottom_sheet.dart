import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:get/get.dart';
import 'package:gym_training/utils/extensions.dart';
import 'package:gym_training/widgets/alarm_bottom_sheet/alarm_bottom_sheet_controller.dart';

class AlarmBottomSheet extends StatefulWidget {
  const AlarmBottomSheet({super.key});

  @override
  State<AlarmBottomSheet> createState() => _AlarmBottomSheetState();
}

class _AlarmBottomSheetState extends State<AlarmBottomSheet> {
  late final AlarmBottomSheetController controller;

  @override
  void initState() {
    controller = AlarmBottomSheetController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.orange.shade100,
        // shape: BoxShape.circle,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Obx(() {
          return Row(
            children: [
              !controller.state.isRunning
                  ? const Icon(Icons.schedule)
                  : TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0, end: 1),
                      duration: Duration(
                          seconds: controller.currentDuration.totalInSeconds),
                      builder: (context, value, _) => CircularProgressIndicator(
                        value: value,
                        color: Colors.black,
                        backgroundColor: Colors.white,
                      ),
                    ),
              24.w,
              Text(controller.state.isRunning
                  ? 'Running timer of'
                  : 'Start break of'),
              12.w,
              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      DateTime dt = DateTime.now();

                      return AlertDialog(
                        title: const Text('How much time'),
                        content: TimePickerSpinner(
                          time: DateTime(
                            2024,
                            1,
                            1,
                            controller.currentDuration.hours,
                            controller.currentDuration.minutes,
                            controller.currentDuration.seconds,
                          ),
                          is24HourMode: true,
                          spacing: 50,
                          itemHeight: 80,
                          isShowSeconds: true,
                          isForce2Digits: false,
                          onTimeChange: (time) {
                            dt = time;
                          },
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              controller.setNewDuration(dt);
                              Navigator.pop(context);
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Row(
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: controller.currentDuration.hours.toString(),
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          TextSpan(
                            text: 'h',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: Colors.grey.shade600),
                          ),
                        ],
                      ),
                    ),
                    4.w,
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: controller.currentDuration.minutes.toString(),
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          TextSpan(
                            text: 'm',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: Colors.grey.shade600),
                          ),
                        ],
                      ),
                    ),
                    4.w,
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: controller.currentDuration.seconds.toString(),
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          TextSpan(
                            text: 's',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: Colors.grey.shade600),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              IconButton(
                visualDensity: VisualDensity.compact,
                onPressed: () async {
                  if (controller.state.isRunning) {
                    return controller.stop();
                  }
                  await controller.start();
                },
                icon: Icon(
                  controller.state.isRunning
                      ? Icons.stop_rounded
                      : Icons.play_arrow_rounded,
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
