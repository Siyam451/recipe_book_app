import 'package:flutter/material.dart';
import 'package:recipebookapp/presentation/common/screens/main_navigation_screen.dart';
import '../../../domain/entities/recipes.dart';

import '../home/widgets/weekly_recipe_tile.dart';
import 'save_recipe_manager.dart';
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
    final List<Recipe> savedRecipes =
        SavedRecipeManager.savedRecipes;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,


      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [

              /// ===== HEADER =====
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (ctx)=>MainNavigationScreen())),
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

              /// ===== TOGGLE =====
              SavedToggle(
                selectedIndex: selectedTab,
                onChanged: (index) {
                  setState(() {
                    selectedTab = index;
                  });
                },
              ),

              const SizedBox(height: 20),

              /// ===== SAVED LIST =====
              Expanded(
                child: savedRecipes.isEmpty
                    ? const Center(
                  child: Text(
                    "No saved recipes yet.",
                    style:
                    TextStyle(color: Colors.grey),
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