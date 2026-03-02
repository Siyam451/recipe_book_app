
import '../entities/recipes.dart';

abstract class HomeRepository {
  Future<List<Recipe>> getPopularRecipes();
}