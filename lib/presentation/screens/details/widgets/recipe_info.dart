import 'package:flutter/material.dart';

import 'package:recipebookapp/presentation/screens/details/widgets/ingredient_items.dart';
import 'package:recipebookapp/presentation/screens/details/widgets/review_sections.dart';

import 'recipe_rating.dart';
import 'recipe_meta.dart';
import 'recipe_description.dart';

class RecipeInfoSection extends StatelessWidget {
  final String title;
  final double rating;
  final List ingredients;
  final int time;
  final int servings;
  final String description;
  final String recipeId;
  final String recipeImage;

  const RecipeInfoSection({
    super.key,
    required this.title,
    required this.rating,
    required this.ingredients,
    required this.time,
    required this.servings,
    required this.description,
    required this.recipeId,
    required this.recipeImage,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [


          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              RecipeRating(rating: rating),
            ],
          ),

          const SizedBox(height: 20),


          Text(
            "Ingredients",
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 15),

          SizedBox(
            height: 140,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: ingredients.length,
              itemBuilder: (context, index) {
                final ingredient = ingredients[index];
                return IngredientItem(
                  name: ingredient.name,
                  quantity: "${ingredient.amount} ${ingredient.unit}",
                );
              },
            ),
          ),

          const SizedBox(height: 25),


          RecipeMeta(time: time, servings: servings),
          const SizedBox(height: 15),
          RecipeDescription(description: description),
          const SizedBox(height: 30),


          const SizedBox(height: 30),
          ReviewsSection(
            recipeId: recipeId,
            recipeImage: recipeImage,
            recipeTitle: title,
          ),
        ],
      ),
    );
  }
}

