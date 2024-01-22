import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:gym_training/models/training_day.dart';
import 'package:gym_training/models/training_execution.dart';
import 'package:gym_training/pages/home/calendar/calendar_controller.dart';
import 'package:gym_training/utils/extensions.dart';
import 'package:gym_training/widgets/home_mode_button.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarView extends StatefulWidget {
  final List<TrainingDay> trainingList;
  final List<TrainingExecution> executionList;
  final void Function() onChangeMode;
  const CalendarView({
    super.key,
    required this.trainingList,
    required this.executionList,
    required this.onChangeMode,
  });

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  late final CalendarController _controller;

  @override
  void initState() {
    _controller = CalendarController(
      executions: widget.executionList,
      trainingDays: widget.trainingList,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                HomeModeButton(
                  onChangeMode: widget.onChangeMode,
                  isCalendar: true,
                ),
              ],
            ),
            TableCalendar(
              firstDay: DateTime(2000),
              lastDay: DateTime.now(),
              selectedDayPredicate: (day) =>
                  isSameDay(_controller.selectedDay.value, day),
              focusedDay: _controller.focusedDay.value,
              onDaySelected: (selectedDay, focusedDay) {
                if (!isSameDay(_controller.selectedDay.value, selectedDay)) {
                  _controller.updateCalendar(focusedDay, selectedDay);
                }
              },
              eventLoader: _controller.getExecutionsByDay,
              onPageChanged: _controller.onPageChanged,
              onFormatChanged: (_) {},
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _controller.currentDayExecutions.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                var item = _controller.currentDayExecutions[index];
                if (!_controller.trainingDays
                    .any((training) => training.id == item.trainingId)) {
                  return Container();
                }
                var trainingItem = _controller.trainingDays
                    .singleWhere((training) => training.id == item.trainingId);
                return ListTile(
                  leading: const Icon(
                    Icons.circle,
                    size: 12,
                  ),
                  title: Text(trainingItem.title),
                );
              },
            )
          ],
        ),
      );
    });
  }
}
