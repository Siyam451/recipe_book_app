import 'package:flutter/material.dart';
import '../../../../domain/entities/recipes.dart';
import '../../saved-recipes/save_recipe_manager.dart';


class RecipeHeader extends StatelessWidget {
  final Recipe recipe;

  const RecipeHeader({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      children: [
        Hero(
          tag: "recipeImage${recipe.id}",
          child: Image.network(
            recipe.image,
            height: 300,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),

        Positioned(
          top: 50,
          left: 16,
          child: CircleAvatar(
            backgroundColor: theme.cardColor,
            child: IconButton(
              icon: Icon(Icons.arrow_back,
                  color: theme.iconTheme.color),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),

        Positioned(
          top: 50,
          right: 16,
          child: CircleAvatar(
            backgroundColor: theme.cardColor,
            child: IconButton(
              icon: Icon(
                SavedRecipeManager.isSaved(recipe)
                    ? Icons.bookmark
                    : Icons.bookmark_border,
                color: SavedRecipeManager.isSaved(recipe)
                    ? theme.colorScheme.primary
                    : theme.iconTheme.color,
              ),
              onPressed: () {
                SavedRecipeManager.toggleRecipe(recipe);
              },
            ),
          ),
        ),

        const Positioned(
          top: 55,
          left: 0,
          right: 0,
          child: Center(
            child: Text(
              "Recipe Details",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}