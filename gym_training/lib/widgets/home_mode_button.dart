import 'package:flutter/material.dart';
import 'package:gym_training/utils/extensions.dart';

class HomeModeButton extends StatelessWidget {
  final void Function() onChangeMode;
  final bool isCalendar;

  const HomeModeButton({
    super.key,
    required this.onChangeMode,
    required this.isCalendar,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onChangeMode,
      child: Row(
        children: [
          Text(isCalendar ? 'Exercise List' : 'Calendar'),
          4.w,
          Icon(isCalendar ? Icons.list : Icons.calendar_month),
        ],
      ),
    );
  }
}
