import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipebookapp/presentation/screens/home/widgets/recipecard.dart';

import '../../details/details_screen.dart';
import '../providers/home_screen_provider.dart';
class RecipeList extends StatelessWidget {
  const RecipeList({super.key});
  @override
  Widget build(BuildContext context) {

    final provider = context.watch<HomeScreenProvider>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Recipes", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),

        SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: provider.categoryrecipe.length,
            itemBuilder: (context, index) {
              final recipe = provider.categoryrecipe[index];

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => RecipeDetailsScreen(recipe: recipe),
                    ),
                  );
                },
                child: SizedBox(
                  width: 160,
                  child: RecipeCard(
                    image: recipe.image,
                    rating: recipe.rating.toString(),
                    title: recipe.title,
                    author: recipe.author,
                    id: recipe.id.toString(),
                    isSaved: provider.favoriteIds.contains(recipe.id.toString()),
                    onToggle: (id) {
                      provider.toggleFavorite(id);
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}