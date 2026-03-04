import 'package:flutter/material.dart';
import '../../../../core/app_strings.dart';
import '../../../../core/services/api_caller.dart';
import '../../../../data/models/recipe_details_model.dart';

class RecipeDetailsProvider extends ChangeNotifier {

  bool isLoading = false;
  String? errorMessage;
  RecipeDetailsModel? recipeDetails;

  Future<void> fetchRecipeDetails(int id) async {

    isLoading = true;
    errorMessage = null;
    notifyListeners();

    final response = await NetworkCaller(
      onUnauthorize: () {

      },
    ).getRequest(
      url: "https://api.spoonacular.com/recipes/$id/information?apiKey=${AppStrings.apiKey}",
    );

    if (response.isSuccess) {

      recipeDetails =
          RecipeDetailsModel.fromJson(response.responseData);

    } else {

      errorMessage = response.errorMessage;

    }

    isLoading = false;
    notifyListeners();
  }
}