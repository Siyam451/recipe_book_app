import 'package:flutter/material.dart';

class WatchButton extends StatelessWidget {
  const WatchButton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: theme.colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onPressed: () {},
        icon: const Icon(Icons.play_circle_fill),
        label: const Text("Watch Videos"),
      ),
    );
  }
}