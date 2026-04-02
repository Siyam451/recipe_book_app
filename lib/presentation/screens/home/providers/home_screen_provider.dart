import 'dart:math';

import 'package:flutter/material.dart';
import 'package:recipebookapp/core/app_strings.dart';
import 'package:recipebookapp/core/services/api_caller.dart';
import 'package:recipebookapp/core/services/set_up_network_caller.dart';
import 'package:recipebookapp/domain/entities/recipes.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../data/models/recipe_model.dart';

class HomeScreenProvider extends ChangeNotifier{
   bool _homescreenLoading = false;
   bool get homescreenloading => _homescreenLoading;

   String? _errorMassege ;
   String? get errorMassege  => _errorMassege;

   List<Recipe> _categoryRecipes = [];
   List<Recipe> get categoryrecipe => _categoryRecipes;

   List<Recipe> _searchRecipes = [];
   List<Recipe> get searchrecipes => _searchRecipes;

   List<String> _favoriteIds = [];
   List<String> get favoriteIds => _favoriteIds;

   Future<bool> fetchcategoryRecipes(String category) async {
     bool isSuccess = false;
     _homescreenLoading = true;
     _errorMassege = null;
     notifyListeners();

     try {
       final NetworkResponse response =
       await getNetworkcaller().getRequest(
         url:
         'https://api.spoonacular.com/recipes/complexSearch?apiKey=${AppStrings.apiKey}&query=$category',
       );

       if (response.isSuccess) {
         final Map<String, dynamic> data = response.responseData;

         final List<dynamic> results = data['results'];

         _categoryRecipes = results
             .map((e) => RecipeModel
             .fromJson(e as Map<String, dynamic>)
             .toEntity())
             .toList();
         isSuccess = true;
       } else {
         _errorMassege = response.errorMessage ?? "Failed to load recipes";
       }
     } catch (e) {
       _errorMassege = e.toString();
     }

     _homescreenLoading = false;
     notifyListeners();

     return isSuccess;
   }

   Future<void> loadFavorites() async {
     final prefs = await SharedPreferences.getInstance();
     _favoriteIds = prefs.getStringList("favorites") ?? [];

     print("Loaded favorites: $_favoriteIds");

     notifyListeners();
   }

   Future<void> toggleFavorite(String id) async {
     final prefs = await SharedPreferences.getInstance();

     if (_favoriteIds.contains(id)) {
       _favoriteIds.remove(id);
     } else {
       _favoriteIds.add(id);
     }

     await prefs.setStringList("favorites", _favoriteIds);

     print("Saved favorites: $_favoriteIds");

     notifyListeners();
   }

}