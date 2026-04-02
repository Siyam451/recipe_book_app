import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipebookapp/presentation/common/screens/main_navigation_screen.dart';
import '../home/providers/home_screen_provider.dart';
import '../home/widgets/weekly_recipe_tile.dart';

import 'widgets/saved_toggle.dart';

class SavedRecipeScreen extends StatefulWidget {
  const SavedRecipeScreen({super.key});

  @override
  State<SavedRecipeScreen> createState() =>
      _SavedRecipeScreenState();
}

class _SavedRecipeScreenState
    extends State<SavedRecipeScreen> {

  int selectedTab = 0;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HomeScreenProvider>();

    final savedRecipes = provider.categoryrecipe
        .where((recipe) =>
        provider.favoriteIds.contains(recipe.id.toString()))
        .toList();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) => MainNavigationScreen(),
                      ),
                    ),
                    icon: const Icon(Icons.arrow_back),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        "Saved Recipes",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const Icon(Icons.search),
                ],
              ),

              const SizedBox(height: 20),

              SavedToggle(
                selectedIndex: selectedTab,
                onChanged: (index) {
                  setState(() {
                    selectedTab = index;
                  });
                },
              ),

              const SizedBox(height: 20),

              Expanded(
                child: savedRecipes.isEmpty
                    ? const Center(
                  child: Text(
                    "No saved recipes yet.",
                    style: TextStyle(color: Colors.grey),
                  ),
                )
                    : ListView.builder(
                  itemCount: savedRecipes.length,
                  itemBuilder: (context, index) {
                    return WeeklyRecipeTile(
                      recipe: savedRecipes[index],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}