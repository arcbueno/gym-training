import 'package:alarm/model/alarm_settings.dart';

import 'package:gym_training/states.dart';

class AlarmBottomSheetState extends State {
  final AlarmSettings? currentAlarm;
  final bool isRunning;
  final String? error;

  AlarmBottomSheetState(
      {this.currentAlarm, this.isRunning = false, this.error});

  factory AlarmBottomSheetState.empty() {
    return AlarmBottomSheetState();
  }

  AlarmBottomSheetState copyWith({
    AlarmSettings? currentAlarm,
    bool? isRunning,
    String? error,
  }) {
    return AlarmBottomSheetState(
      currentAlarm: currentAlarm ?? this.currentAlarm,
      isRunning: isRunning ?? this.isRunning,
      error: error ?? this.error,
    );
  }
}
