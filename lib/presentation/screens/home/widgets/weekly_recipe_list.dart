import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipebookapp/presentation/screens/home/widgets/weekly_recipe_tile.dart';

import '../providers/home_screen_provider.dart';
class WeeklyRecipeList extends StatelessWidget {
  const WeeklyRecipeList({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HomeScreenProvider>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Recipes of The Week",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

        const SizedBox(height: 16),

        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: provider.categoryrecipe.length,
          itemBuilder: (context, index) {
            return WeeklyRecipeTile(
              recipe: provider.categoryrecipe[index],
            );
          },
        ),
      ],
    );
  }
}