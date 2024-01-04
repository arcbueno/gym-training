import 'package:flutter/material.dart';

class HomeEmptyList extends StatelessWidget {
  final void Function() onNewTraining;
  const HomeEmptyList({super.key, required this.onNewTraining});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: const Icon(Icons.add),
      onTap: onNewTraining,
      title: Text(
        'Training list empty, touch here to create a new one',
        style: Theme.of(context).textTheme.labelLarge,
        textAlign: TextAlign.center,
      ),
    );
  }
}
