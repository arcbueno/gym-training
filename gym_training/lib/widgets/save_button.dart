import 'package:flutter/material.dart';

class SaveButton extends StatelessWidget {
  final void Function() onPressed;
  final String title;
  const SaveButton({super.key, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 22),
      ),
      onPressed: onPressed,
      child: Text(title),
    );
  }
}
