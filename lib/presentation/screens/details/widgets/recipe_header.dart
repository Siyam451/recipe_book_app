import 'package:flutter/material.dart';
import '../../../../domain/entities/recipes.dart';
import '../../saved-recipes/save_recipe_manager.dart';

class RecipeHeader extends StatefulWidget {
  final Recipe recipe;

  const RecipeHeader({super.key, required this.recipe});

  @override
  State<RecipeHeader> createState() => _RecipeHeaderState();
}

class _RecipeHeaderState extends State<RecipeHeader> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final recipe = widget.recipe;

    final isSaved = SavedRecipeManager.isSaved(recipe);

    return Stack(
      children: [
        /// Image
        Hero(
          tag: "recipeImage${recipe.id}",
          child: Image.network(
            recipe.image,
            height: 300,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),

        /// Back Button
        Positioned(
          top: 50,
          left: 16,
          child: CircleAvatar(
            backgroundColor: theme.cardColor,
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: theme.iconTheme.color,
              ),
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
                isSaved
                    ? Icons.bookmark
                    : Icons.bookmark_border,
                color: isSaved
                    ? theme.colorScheme.primary
                    : theme.iconTheme.color,
              ),
              onPressed: () {
                setState(() {
                  SavedRecipeManager.toggleRecipe(recipe);
                });
              },
            ),
          ),
        ),

        /// Title
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