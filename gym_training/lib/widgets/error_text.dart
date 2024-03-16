import 'package:flutter/material.dart';

class ErrorText extends StatelessWidget {
  final String text;
  const ErrorText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(color: Colors.red.shade400),
      textAlign: TextAlign.center,
    );
  }
}
