import 'package:get/get.dart';
import 'package:gym_training/models/training_day.dart';
import 'package:gym_training/models/training_execution.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarController {
  late final List<TrainingExecution> executions;
  late final List<TrainingDay> trainingDays;

  final focusedDay = DateTime.now().obs;
  final selectedDay = DateTime.now().obs;
  final currentDayExecutions = <TrainingExecution>[].obs;

  CalendarController({
    required this.executions,
    required this.trainingDays,
  }) {
    currentDayExecutions.value = getExecutionsByDay(selectedDay.value);
  }

  List<TrainingExecution> getExecutionsByDay(DateTime day) {
    return executions
        .where((element) => isSameDay(element.executionDate, day))
        .toList();
  }

  onPageChanged(DateTime day) {
    focusedDay.value = day;
  }

  updateCalendar(DateTime focusDay, DateTime selecDay) {
    focusedDay.value = focusDay;
    selectedDay.value = selecDay;
    updateCurrentExecutions();
  }

  updateCurrentExecutions() {
    currentDayExecutions.value = getExecutionsByDay(selectedDay.value);
  }
}
