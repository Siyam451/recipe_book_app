import 'package:flutter/material.dart';
import '../../../../domain/entities/recipes.dart';
import '../../../../domain/reposotrys/home_reprostry.dart';


class HomeProvider extends ChangeNotifier {
  final HomeRepository repository;

  HomeProvider(this.repository);

  List<Recipe> popular = [];
  bool isLoading = false;
  String? error;

  Future<void> loadRecipes() async {
    try {
      isLoading = true;
      notifyListeners();

      popular = await repository.getPopularRecipes();
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}