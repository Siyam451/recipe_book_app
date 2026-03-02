import '../../../domain/entities/recipes.dart';


class SavedRecipeManager {
  static final List<Recipe> _savedRecipes = [];

  static List<Recipe> get savedRecipes => _savedRecipes;

  static void toggleRecipe(Recipe recipe) {
    if (_savedRecipes.any((r) => r.id == recipe.id)) {
      _savedRecipes.removeWhere((r) => r.id == recipe.id);
    } else {
      _savedRecipes.add(recipe);
    }
  }

  static bool isSaved(Recipe recipe) {
    return _savedRecipes.any((r) => r.id == recipe.id);
  }
}