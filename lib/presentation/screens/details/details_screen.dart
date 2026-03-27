import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipebookapp/presentation/screens/details/provider/recipe_details_provider.dart';
import 'package:recipebookapp/presentation/screens/details/widgets/recipe_info.dart';
import '../../../domain/entities/recipes.dart';
import 'widgets/recipe_header.dart';

class RecipeDetailsScreen extends StatefulWidget {
  final Recipe recipe;

  const RecipeDetailsScreen({super.key, required this.recipe});

  @override
  State<RecipeDetailsScreen> createState() =>
      _RecipeDetailsScreenState();
}

class _RecipeDetailsScreenState
    extends State<RecipeDetailsScreen> {

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context
          .read<RecipeDetailsProvider>()
          .fetchRecipeDetails(widget.recipe.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final recipe = widget.recipe;

    return Scaffold(
      body: Consumer<RecipeDetailsProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.errorMessage != null) {
            return Center(child: Text(provider.errorMessage!));
          }

          final details = provider.recipeDetails!;

          return SingleChildScrollView(
            child: Column(
              children: [
                RecipeHeader(recipe: recipe),

                RecipeInfoSection(
                  title: recipe.title,
                  rating: recipe.rating,
                  ingredients: details.ingredients,
                  time: details.readyInMinutes,
                  servings: details.servings,
                  description: details.summary
                      .replaceAll(RegExp(r'<[^>]*>'), ''),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}