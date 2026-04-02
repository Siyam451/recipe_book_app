import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipebookapp/core/app_colors.dart';
import 'package:recipebookapp/domain/entities/recipes.dart';
import 'package:recipebookapp/presentation/screens/details/details_screen.dart';
import 'package:recipebookapp/presentation/screens/search-by-name/provider/search_recipe_provider.dart';

class SearchByNameScreen extends StatefulWidget {
  const SearchByNameScreen({super.key});

  @override
  State<SearchByNameScreen> createState() => _SearchByNameScreenState();
}

class _SearchByNameScreenState extends State<SearchByNameScreen> {

  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text("Search Recipe"),
        backgroundColor: AppColors.primary,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            /// SEARCH FIELD
            TextFormField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Search recipe name...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              onChanged: (value) {
                if (value.trim().isNotEmpty) {
                  context
                      .read<SearchRecipeProvider>()
                      .searchRecipe(value);
                }
              },
            ),

            const SizedBox(height: 20),

            /// GRID VIEW
            Expanded(
              child: Consumer<SearchRecipeProvider>(
                builder: (context, provider, child){

                  if (provider.isLoading) {
                    return const Center(
                        child: CircularProgressIndicator());
                  }

                  if (provider.errorMessage != null) {
                    return Center(
                        child: Text(provider.errorMessage!));
                  }

                  if (provider.recipes.isEmpty) {
                    return const Center(
                        child: Text("Search a recipe"));
                  }

                  return GridView.builder(
                    padding: const EdgeInsets.only(bottom: 10),
                    itemCount: provider.recipes.length,
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.75,
                    ),
                    itemBuilder: (context, index) {

                      final recipe = provider.recipes[index];

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  RecipeDetailsScreen(recipe: Recipe(
                                      id: recipe.id,
                                      title: recipe.title,
                                      image: recipe.image,
                                      author: "Parvin akter",
                                      rating: 4.5,
                                  )),
                            ),
                          );
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              /// IMAGE
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(15)),
                                child: Image.network(
                                  recipe.image,
                                  height: 120,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) =>
                                  const SizedBox(
                                    height: 120,
                                    child: Icon(Icons.image, size: 50),
                                  ),
                                ),
                              ),

                              /// TITLE
                              Padding(
                                padding:  EdgeInsets.all(8),
                                child: Text(
                                  recipe.title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style:  TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}