import 'dart:async';

import 'package:alarm/alarm.dart';
import 'package:alarm/model/alarm_settings.dart';
import 'package:get/get.dart';

import 'package:gym_training/widgets/alarm_bottom_sheet/state.dart';

class AlarmBottomSheetController {
  final Rx<AlarmBottomSheetState> _state =
      Rx<AlarmBottomSheetState>(AlarmBottomSheetState.empty());
  AlarmBottomSheetState get state => _state.value;

  final Rx<Period> _duration = Rx<Period>(Period());
  Period get currentDuration => _duration.value;
  Timer? timer;

  void setNewDuration(DateTime dt) {
    _duration.value =
        Period(hours: dt.hour, minutes: dt.minute, seconds: dt.second);
  }

  Future<void> start() async {
    var alarmDuration = Duration(
        hours: currentDuration.hours,
        minutes: currentDuration.minutes,
        seconds: currentDuration.seconds);
    final alarmSettings = AlarmSettings(
      id: 1,
      dateTime: DateTime.now().add(
        alarmDuration,
      ),
      assetAudioPath: 'assets/alarm.mp3',
      loopAudio: true,
      vibrate: true,
      volume: 0.8,
      fadeDuration: 3.0,
      notificationTitle: 'Break is over',
      notificationBody: '',
      enableNotificationOnKill: true,
    );

    await Alarm.set(alarmSettings: alarmSettings);
    timer = Timer(alarmDuration, () {});
    _state.value = _state.value.copyWith(
      isRunning: true,
      currentAlarm: alarmSettings,
    );
  }

  Future<void> stop() async {
    if (_state.value.isRunning) {
      await Alarm.stop(_state.value.currentAlarm!.id);
    }
    _state.value = _state.value.copyWith(
      isRunning: false,
    );
  }
}

class Period {
  int hours = 0;
  int minutes = 0;
  int seconds = 0;

  int get totalInSeconds =>
      Duration(hours: hours, minutes: minutes, seconds: seconds).inSeconds;

  Period({
    this.hours = 0,
    this.minutes = 0,
    this.seconds = 0,
  });
}
