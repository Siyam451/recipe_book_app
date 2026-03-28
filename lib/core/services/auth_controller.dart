import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class RecipeLocalController {

  static const _favoriteKey = "favorite-recipes";

  /// Cache (optional)
  static List<Map<String, dynamic>> favoriteRecipes = [];

  /// Save full list
  static Future<void> saveFavorites(List<Map<String, dynamic>> recipes) async {
    final prefs = await SharedPreferences.getInstance();

    String encodedData = jsonEncode(recipes);
    await prefs.setString(_favoriteKey, encodedData);

    favoriteRecipes = recipes;
  }

  /// Get all favorites
  static Future<List<Map<String, dynamic>>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();

    final data = prefs.getString(_favoriteKey);

    if (data != null) {
      final decoded = jsonDecode(data);
      favoriteRecipes = List<Map<String, dynamic>>.from(decoded);
      return favoriteRecipes;
    }

    return [];
  }

  /// Add single recipe
  static Future<void> addFavorite(Map<String, dynamic> recipe) async {
    final currentList = await getFavorites();

    currentList.add(recipe);

    await saveFavorites(currentList);
  }

  /// Remove recipe
  static Future<void> removeFavorite(String id) async {
    final currentList = await getFavorites();

    currentList.removeWhere((item) => item["id"] == id);

    await saveFavorites(currentList);
  }

  /// Check if already favorite
  static Future<bool> isFavorite(String id) async {
    final currentList = await getFavorites();

    return currentList.any((item) => item["id"] == id);
  }

  /// Clear all
  static Future<void> clearFavorites() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(_favoriteKey);
    favoriteRecipes = [];
  }
}