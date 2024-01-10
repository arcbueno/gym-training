import 'package:flutter/material.dart';
import 'package:gym_training/states.dart' as st;
import 'package:gym_training/states.dart';

class ErrorWidget extends StatelessWidget {
  final st.State state;
  const ErrorWidget({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      curve: Curves.easeIn.flipped,
      duration: const Duration(milliseconds: 300),
      child: state is ErrorState
          ? Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text(
                (state as ErrorState).errorMessage,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: Colors.red.shade300),
              ),
            )
          : const SizedBox(),
    );
  }
}
