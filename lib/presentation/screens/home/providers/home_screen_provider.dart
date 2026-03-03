import 'dart:math';

import 'package:flutter/material.dart';
import 'package:recipebookapp/core/services/api_caller.dart';
import 'package:recipebookapp/core/services/set_up_network_caller.dart';
import 'package:recipebookapp/domain/entities/recipes.dart';

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

   Future<bool> fetchcategoryRecipes(String category) async {
     bool isSuccess = false;
     _homescreenLoading = true;
     _errorMassege = null;
     notifyListeners();

     try {
       final NetworkResponse response =
       await getNetworkcaller().getRequest(
         url:
         'https://api.spoonacular.com/recipes/complexSearch?apiKey=183b0c5444a14691acf8dbfe884f5f10&query=$category',
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

}