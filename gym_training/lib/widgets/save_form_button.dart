import 'package:flutter/material.dart';

class SaveFormButton extends StatelessWidget {
  final Function() onTap;
  final bool isLoading;
  final String text;

  const SaveFormButton(
      {super.key,
      required this.onTap,
      required this.text,
      this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onTap,
      child: isLoading
          ? const SizedBox(
              height: 24, width: 24, child: CircularProgressIndicator())
          : Text(text),
    );
  }
}
