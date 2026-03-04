import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipebookapp/presentation/screens/details/provider/recipe_details_provider.dart';
import 'package:recipebookapp/presentation/screens/details/widgets/ingredient_items.dart';
import '../../../domain/entities/recipes.dart';
import '../saved-recipes/save_recipe_manager.dart';


class RecipeDetailsScreen extends StatefulWidget {
  final Recipe recipe;

  const RecipeDetailsScreen({
    super.key,
    required this.recipe,
  });

  @override
  State<RecipeDetailsScreen> createState() =>
      _RecipeDetailsScreenState();
}

class _RecipeDetailsScreenState
    extends State<RecipeDetailsScreen> {

  bool isBookmarked = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask((){
      context.read<RecipeDetailsProvider>().fetchRecipeDetails(widget.recipe.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final recipe = widget.recipe;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Consumer<RecipeDetailsProvider>(
        builder: (context,recipedetailsprovider,_) {
          if(recipedetailsprovider.isLoading){
            return Center(child: CircularProgressIndicator(),);
          }
          if (recipedetailsprovider.errorMessage != null) {
            return Center(child: Text(recipedetailsprovider.errorMessage!));
          }

          final details = recipedetailsprovider.recipeDetails!;
          return SingleChildScrollView(
            child: Column(
              children: [

                Stack(
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
                        backgroundColor: Colors.white,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                    ),

                    Positioned(
                      top: 50,
                      right: 16,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: IconButton(
                          icon: Icon(
                            SavedRecipeManager.isSaved(recipe)
                                ? Icons.bookmark
                                : Icons.bookmark_border,
                            color: SavedRecipeManager.isSaved(recipe)
                                ? Colors.orange
                                : Colors.black,
                          ),
                          onPressed: () {
                            setState(() {
                              SavedRecipeManager.toggleRecipe(recipe);
                            });
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
                            fontWeight: FontWeight.w600,
                            fontSize: 25,
                            color: Colors.white
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                /// ================= DETAILS =================
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(25),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      /// Title + Rating
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              recipe.title,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.orange.shade50,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.star,
                                    color: Colors.orange, size: 16),
                                const SizedBox(width: 4),
                                Text(
                                  recipe.rating.toStringAsFixed(1),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),

                      const SizedBox(height: 20),

                      /// Ingredients
                      const Text(
                        "Ingredients",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 15),

                      SizedBox(
                        height: 140,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: details.ingredients.length,
                          itemBuilder: (context, index) {
                            final ingredient = details.ingredients[index];

                            return IngredientItem(
                              name: ingredient.name,
                              quantity: "${ingredient.amount} ${ingredient.unit}",
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 25),
                      ///cokking time showing

                      Row(
                        children: [
                          const Icon(Icons.timer, size: 18, color: Colors.grey),
                          const SizedBox(width: 5),
                          Text("${details.readyInMinutes} mins"),

                          const SizedBox(width: 20),

                          const Icon(Icons.restaurant, size: 18, color: Colors.grey),
                          const SizedBox(width: 5),
                          Text("${details.servings} servings"),
                        ],
                      ),

                      const SizedBox(height: 10),

                      /// Description
                      const Text(
                        "Description",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        details.summary.replaceAll(RegExp(r'<[^>]*>'), ''),
                        style: const TextStyle(color: Colors.grey),
                      ),

                      const SizedBox(height: 30),

                      /// Watch Video Button
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(30),
                            ),
                          ),
                          onPressed: () {},
                          icon:
                          const Icon(Icons.play_circle_fill),
                          label: const Text(
                            "Watch Videos",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}