import 'package:flutter/material.dart';
import '../../../../core/app_strings.dart';
import '../../../../core/services/api_caller.dart';
import '../../../../data/models/seach_recipe_model.dart';

class SearchRecipeProvider extends ChangeNotifier {

  bool isLoading = false;
  String? errorMessage;

  List<SearchRecipe> recipes = []; //taking a list

  Future<void> searchRecipe(String query) async {

    isLoading = true;
    notifyListeners();

    final response = await NetworkCaller(
      onUnauthorize: () {},
    ).getRequest(
      url:
      "${AppStrings.baseUrl}/recipes/complexSearch?query=$query&number=20&apiKey=${AppStrings.apiKey}"
    );

    if (response.isSuccess) {

      final model =
      SearchRecipeModel.fromJson(response.responseData); //searchrecipemodel theke fromjson e responsedata te j data ta ase seita nibo

      recipes = model.results;

    } else {
      errorMessage = response.errorMessage;
    }

    isLoading = false;
    notifyListeners();
  }
}