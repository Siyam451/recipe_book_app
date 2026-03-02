import 'package:flutter/material.dart';
import '../../../../domain/entities/recipes.dart';
import '../../details/details_screen.dart';
import '../../saved-recipes/save_recipe_manager.dart';

class WeeklyRecipeTile extends StatefulWidget {
  final Recipe recipe;

  const WeeklyRecipeTile({
    super.key,
    required this.recipe,
  });

  @override
  State<WeeklyRecipeTile> createState() =>
      _WeeklyRecipeTileState();
}

class _WeeklyRecipeTileState
    extends State<WeeklyRecipeTile> {

  @override
  Widget build(BuildContext context) {
    final recipe = widget.recipe;

    final isSaved =
    SavedRecipeManager.isSaved(recipe);

    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,

          onTap: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    RecipeDetailsScreen(recipe: recipe),
              ),
            );

            // 🔥 Refresh after returning
            setState(() {});
          },

          /// Hero Image
          leading: Hero(
            tag: "recipeImage${recipe.id}",
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                recipe.image,
                width: 65,
                height: 65,
                fit: BoxFit.cover,
              ),
            ),
          ),

          title: Text(
            recipe.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),

          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(
                    Icons.star,
                    size: 14,
                    color: Colors.orange,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    recipe.rating.toStringAsFixed(1),
                    style: const TextStyle(fontSize: 13),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                "By: ${recipe.author}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),

          /// 🔥 Bookmark Button With Logic
          trailing: IconButton(
            icon: Icon(
              isSaved
                  ? Icons.bookmark
                  : Icons.bookmark_border,
              color:
              isSaved ? Colors.orange : Colors.grey,
            ),
            onPressed: () {
              setState(() {
                SavedRecipeManager.toggleRecipe(recipe);
              });
            },
          ),
        ),

        const Divider(height: 20),
      ],
    );
  }
}