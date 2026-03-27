import 'package:flutter/material.dart';

class RecipeMeta extends StatelessWidget {
  final int time;
  final int servings;

  const RecipeMeta({
    super.key,
    required this.time,
    required this.servings,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Icon(Icons.timer, size: 18, color: theme.iconTheme.color),
        const SizedBox(width: 5),
        Text("$time mins"),

        const SizedBox(width: 20),

        Icon(Icons.restaurant,
            size: 18, color: theme.iconTheme.color),
        const SizedBox(width: 5),
        Text("$servings servings"),
      ],
    );
  }
}